import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter_app_badger/flutter_app_badger.dart';
import 'package:sport_app/bloc/home/bloc/home_bloc.dart';
import 'package:sport_app/bloc/home/bloc/home_event.dart';
import 'package:sport_app/helper/loading.dart';
import 'package:sport_app/helper/shared_preferences_helper.dart';
import 'package:sport_app/main.dart';
import 'package:sport_app/model/users.dart';
import 'package:sport_app/resource/resource.dart';
import 'package:sport_app/router/navigation_service.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class FirebaseHelper {
  static final FirebaseHelper shared = FirebaseHelper._internal();
  static final FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
  static final FirebaseStorage firebaseStorage = FirebaseStorage.instance;
  FirebaseHelper._internal();
  String? verificationId;
  int? resendToken;
  late PhoneAuthCredential phoneAuthCredential;
  late AuthCredential authCredential;
  final GoogleSignIn _googleSignIn = GoogleSignIn();
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

  Future<User> getCurrentUser() async {
    User currentUser;
    currentUser = auth.currentUser!;
    return currentUser;
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

  Future<void> loginWithPhoneNumber(
    String? smsCode,
  ) async {
    phoneAuthCredential = PhoneAuthProvider.credential(
      verificationId: verificationId ?? '',
      smsCode: smsCode ?? '',
    );
    try {
      Loading.show(AppStrings.loading);
      var result =
          await FirebaseAuth.instance.signInWithCredential(phoneAuthCredential);
      if (result.user != null) {
        Loading.dismiss();
        NavigationService.navigatorKey.currentState
            ?.pushNamed(AppRouteName.main);
      }
    } on FirebaseAuthException {
      Loading.showError(AppStrings.error);
    }
  }

  Future<void> signOut() async {
    await FirebaseAuth.instance.signOut();
    SharedPreferencesHelper.shared.logout();
  }

  Future<void> resetPasswordWithEmail({String? email}) async {
    FirebaseAuth.instance.sendPasswordResetEmail(email: email ?? "");
  }

  Future<User?> signInWithGoogle() async {
    User? user;
    final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();
    Loading.show(AppStrings.loading);
    if (googleUser != null) {
      Loading.dismiss();
      final GoogleSignInAuthentication googleSignInAuthentication =
          await googleUser.authentication;
      authCredential = GoogleAuthProvider.credential(
        accessToken: googleSignInAuthentication.accessToken,
        idToken: googleSignInAuthentication.idToken,
      );
      try {
        final UserCredential userCredential =
            await auth.signInWithCredential(authCredential);
        user = userCredential.user;
        SharedPreferencesHelper.shared
            .setString(AppKeyName.uid, user?.uid ?? "");
        createUser();
        NavigationService.navigatorKey.currentState?.pushNamed(
          AppRouteName.main,
          arguments: user,
        );
      } on FirebaseException {
        Loading.showError(AppStrings.error);
      }
    }
    return user;
  }

  Future signInWithFacebook() async {
    OAuthCredential facebookAuthCredential;
    final LoginResult loginResult = await FacebookAuth.instance.login();
    if (loginResult.status == LoginStatus.success) {
      Loading.show(AppStrings.loading);
      facebookAuthCredential = FacebookAuthProvider.credential(
        loginResult.accessToken?.token ?? "",
      );
      UserCredential userCredential = await FirebaseAuth.instance
          .signInWithCredential(facebookAuthCredential);
      User? user = userCredential.user;
      if (user != null) {
        Loading.showSuccess(AppStrings.success);
        SharedPreferencesHelper.shared.setString(AppKeyName.uid, user.uid);
        await FirebaseHelper.shared.createUser();
        NavigationService.navigatorKey.currentState?.pushNamed(
          AppRouteName.main,
          arguments: user,
        );
      } else {
        Loading.showError(AppStrings.error);
      }
    }
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
    settings.authorizationStatus;
  }

  Future<void> saveTokenToDatabase(String token) async {
    String userId = FirebaseAuth.instance.currentUser!.uid;

    await FirebaseFirestore.instance.collection('users').doc(userId).update(
      {
        'tokens': FieldValue.arrayUnion([token]),
      },
    );
  }

  Future<void> setupToken() async {
    String? fcmToken = await FirebaseMessaging.instance.getToken();
    SharedPreferencesHelper.shared.setString(AppKeyName.token, fcmToken!);
    await saveTokenToDatabase(fcmToken);
    FirebaseMessaging.instance.onTokenRefresh.listen(saveTokenToDatabase);
  }

  Future<void> setupInteractedMessage() async {
    RemoteMessage? initialMessage =
        await FirebaseMessaging.instance.getInitialMessage();
    if (initialMessage != null) {
      print(initialMessage);
    }

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
        getIt.get<HomeBloc>().add(UpdateBadgeEvent(badgeCount: number));
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

  Future<void> createUser() async {
    User? currentUser = auth.currentUser;
    CollectionReference userCollection =
        firebaseFirestore.collection(AppCollection.users);
    DocumentReference userDocument = userCollection.doc(currentUser?.uid);
    final user = Users(
      uid: currentUser?.uid,
      displayName: currentUser?.displayName,
      email: currentUser?.email,
      photoUrl: currentUser?.photoURL,
    );
    await userDocument.set(user.toJson());
  }

  Stream<DocumentSnapshot> getUserByUid() {
    User? currentUser = auth.currentUser;
    CollectionReference userCollection =
        firebaseFirestore.collection(AppCollection.users);
    DocumentReference userDocument = userCollection.doc(currentUser?.uid);
    return userDocument.snapshots();
  }

  UploadTask? uploadImageFile(String destination, File imageFile) {
    try {
      final ref = firebaseStorage.ref(destination);
      return ref.putFile(imageFile);
    } on FirebaseException catch (e) {
      return null;
    }
  }
}
