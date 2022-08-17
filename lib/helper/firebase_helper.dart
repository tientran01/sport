import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter_app_badger/flutter_app_badger.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:sport_app/bloc/home/bloc/home_bloc.dart';
import 'package:sport_app/bloc/home/bloc/home_event.dart';
import 'package:sport_app/helper/shared_preferences_helper.dart';
import 'package:sport_app/main.dart';
import 'package:sport_app/model/users.dart';
import 'package:sport_app/resource/resource.dart';
import 'package:sport_app/router/navigation_service.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class FirebaseHelper {
  static final FirebaseHelper shared = FirebaseHelper._internal();
  static final FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
  static final FirebaseStorage firebaseStorage = FirebaseStorage.instance;
  FirebaseHelper._internal();
  String? verificationId;
  int? resendToken;
  late PhoneAuthCredential phoneAuthCredential;
  final GoogleSignIn googleSignIn = GoogleSignIn();
  FirebaseAuth auth = FirebaseAuth.instance;
  FirebaseMessaging firebaseMessaging = FirebaseMessaging.instance;
  int number = 0;

  Future<User?> loginWithEmailAndPassword({
    String? email,
    String? password,
  }) async {
    User? user;
    UserCredential userCredential =
        await FirebaseAuth.instance.signInWithEmailAndPassword(
      email: email ?? "",
      password: password ?? "",
    );
    user = userCredential.user;
    return user;
  }

  Future<User?> signUpWithEmailAndPassword({
    String? email,
    String? password,
  }) async {
    User? user;
    UserCredential userCredential =
        await FirebaseAuth.instance.createUserWithEmailAndPassword(
      email: email ?? "",
      password: password ?? "",
    );
    user = userCredential.user;
    return user;
  }

  Future<void> verifyPhoneNumber({
    required String phoneNumber,
    required onVerificationCompleted,
    required onVerificationFailed,
    required onCodeSent,
    required onCodeAutoRetrievalTimeout,
  }) async {
    await FirebaseAuth.instance.verifyPhoneNumber(
      phoneNumber: "+84 $phoneNumber",
      timeout: const Duration(seconds: 30),
      verificationCompleted: (PhoneAuthCredential authCredential) {
        phoneAuthCredential = authCredential;
      },
      verificationFailed: (FirebaseAuthException e) {},
      codeSent: (String verificationID, int? resendCode) {
        verificationId = verificationID;
        resendToken = resendCode;
        onCodeSent(verificationID, resendCode);
      },
      forceResendingToken: resendToken,
      codeAutoRetrievalTimeout: (String verificationID) {
        verificationId = verificationID;
      },
    );
  }

  Future<UserCredential> signInWithGoogle() async {
    final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
    final GoogleSignInAuthentication? googleAuth =
        await googleUser?.authentication;
    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth?.accessToken,
      idToken: googleAuth?.idToken,
    );
    return await FirebaseAuth.instance.signInWithCredential(
      credential,
    );
  }

  Future<UserCredential> signInWithFacebook() async {
    final LoginResult loginResult = await FacebookAuth.instance.login();
    final OAuthCredential facebookAuthCredential =
        FacebookAuthProvider.credential(
      loginResult.accessToken?.token ?? "",
    );
    return FirebaseAuth.instance.signInWithCredential(
      facebookAuthCredential,
    );
  }

  Future<void> signOut() async {
    await FirebaseAuth.instance.signOut();
    SharedPreferencesHelper.shared.removeUid();
  }

  Future<void> resetPasswordWithEmail({String? email}) async {
    FirebaseAuth.instance.sendPasswordResetEmail(email: email ?? "");
  }

  Future<void> registerNotification() async {
    NotificationSettings settings = await firebaseMessaging.requestPermission(
      alert: true,
      badge: true,
      provisional: false,
      sound: true,
    );
    await FirebaseMessaging.instance
        .setForegroundNotificationPresentationOptions(
      alert: true,
      badge: true,
      sound: true,
    );
    // ignore: avoid_print
    print("Authorization status: ${settings.authorizationStatus}");
  }

  Future<void> setupInteractedMessage() async {
    RemoteMessage? initialMessage =
        await FirebaseMessaging.instance.getInitialMessage();
    if (initialMessage != null) {}

    FirebaseMessaging.onMessageOpenedApp.listen(
      (RemoteMessage message) {
        NavigationService.navigatorKey.currentState?.pushNamed(
          AppRouteName.notificationDetail,
          arguments: message,
        );
      },
    );

    FirebaseMessaging.onMessage.listen(
      (RemoteMessage message) {
        number++;
        addBadge(number);
        getIt.get<HomeBloc>().add(
              UpdateBadgeEvent(
                badgeCount: number,
              ),
            );
      },
    );
  }

  void addBadge(int count) async {
    FlutterAppBadger.updateBadgeCount(count);
  }

  void removeBadge() {
    FlutterAppBadger.removeBadge();
    SharedPreferencesHelper.shared.prefs?.remove(AppKeyName.badgeCount);
  }

  Future<void> createUserInformation(
    UserInformation? userInformation,
  ) async {
    User? currentUser = auth.currentUser;
    CollectionReference userCollection = firebaseFirestore.collection(
      AppCollection.userInformation,
    );
    DocumentReference userDocument = userCollection.doc(currentUser?.uid);
    final user = UserInformation(
      uid: currentUser?.uid ?? userInformation?.uid,
      displayName: currentUser?.displayName ?? userInformation?.displayName,
      email: currentUser?.email ?? userInformation?.email,
      photoUrl: currentUser?.photoURL ?? userInformation?.photoUrl,
      phoneNumber: currentUser?.phoneNumber ?? userInformation?.phoneNumber,
    );
    await userDocument.set(user.toJson());
  }

  Future<UserInformation?> getUserByUid() async {
    User? currentUser = auth.currentUser;
    CollectionReference userCollection =
        firebaseFirestore.collection(AppCollection.userInformation);
    UserInformation? user;
    DocumentReference userDocument = userCollection.doc(
      currentUser?.uid,
    );
    await userDocument.get().then(
      (DocumentSnapshot doc) {
        user = UserInformation.fromJson(
          doc.data() as Map<String, dynamic>,
        );
      },
    );
    return user;
  }

  Future<void> uploadImageUser({String? imagePath}) async {
    User? currentUser = FirebaseHelper.shared.auth.currentUser;
    CollectionReference userCollection =
        FirebaseHelper.firebaseFirestore.collection(
      AppCollection.userInformation,
    );
    DocumentReference userDocument = userCollection.doc(currentUser?.uid);
    Reference imageReference = FirebaseHelper.firebaseStorage.ref().child(
          AppFolder.imageUser,
        );
    UploadTask uploadTask =
        imageReference.child("${currentUser?.uid}.png").putFile(
              File(imagePath ?? ""),
            );
    var imageUrl = await (await uploadTask).ref.getDownloadURL();
    userDocument.update({AppFieldName.photoUrl: imageUrl});
  }

  Future<void> updateUser({String? displayName}) async {
    User? currentUser = FirebaseHelper.shared.auth.currentUser;
    CollectionReference userCollection = FirebaseHelper.firebaseFirestore
        .collection(AppCollection.userInformation);
    DocumentReference userDocument = userCollection.doc(currentUser?.uid);
    userDocument.update(
      {
        AppFieldName.displayName: displayName,
      },
    );
  }

  Future<void> deleteUser() async {
    User? currentUser = auth.currentUser;
    CollectionReference userCollection =
        firebaseFirestore.collection(AppCollection.userInformation);
    DocumentReference userDocument = userCollection.doc(currentUser?.uid);
    SharedPreferencesHelper.shared.removeUid();
    userDocument.delete();
    currentUser?.delete();
  }
}
