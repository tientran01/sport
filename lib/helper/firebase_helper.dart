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
import 'package:sport_app/model/your_article.dart';
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
      Loading.show(msg: AppStrings.loading);
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
    Loading.show(msg: AppStrings.loading);
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
        final userInformation = UserInformation(
          email: user?.email,
          displayName: user?.displayName,
          photoUrl: user?.photoURL,
          phoneNumber: user?.phoneNumber,
        );
        SharedPreferencesHelper.shared
            .setString(AppKeyName.uid, user?.uid ?? "");
        createUserInformation(userInformation);
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
      Loading.show(msg: AppStrings.loading);
      facebookAuthCredential = FacebookAuthProvider.credential(
        loginResult.accessToken?.token ?? "",
      );
      UserCredential userCredential = await FirebaseAuth.instance
          .signInWithCredential(facebookAuthCredential);
      User? user = userCredential.user;
      if (user != null) {
        Loading.showSuccess(AppStrings.success);
        SharedPreferencesHelper.shared.setString(AppKeyName.uid, user.uid);
        final userInformation = UserInformation(
          email: user.email,
          displayName: user.displayName,
          photoUrl: user.photoURL,
          phoneNumber: user.phoneNumber,
        );
        await FirebaseHelper.shared.createUserInformation(userInformation);
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
    // ignore: avoid_print
    print("Authorization status: ${settings.authorizationStatus}");
  }

  Future<void> setupToken() async {
    String? fcmToken = await FirebaseMessaging.instance.getToken();
    String userId = FirebaseAuth.instance.currentUser?.uid ?? "";

    await FirebaseFirestore.instance
        .collection(AppCollection.userInformation)
        .doc(userId)
        .update(
      {
        AppFieldName.tokens: fcmToken,
      },
    );
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

  Future<void> createUserInformation(UserInformation? userInformation) async {
    User? currentUser = auth.currentUser;
    CollectionReference userCollection =
        firebaseFirestore.collection(AppCollection.userInformation);
    DocumentReference userDocument = userCollection.doc(currentUser?.uid);
    final user = UserInformation(
        uid: currentUser?.uid ?? userInformation?.uid,
        displayName: currentUser?.displayName ?? userInformation?.displayName,
        email: currentUser?.email ?? userInformation?.email,
        photoUrl: currentUser?.photoURL ?? userInformation?.photoUrl,
        phoneNumber: currentUser?.phoneNumber ?? userInformation?.phoneNumber);
    await userDocument.set(user.toJson());
  }

  Future<UserInformation?> getUserByUid() async {
    User? currentUser = auth.currentUser;
    CollectionReference userCollection =
        firebaseFirestore.collection(AppCollection.userInformation);
    UserInformation? user;
    DocumentReference userDocument = userCollection.doc(currentUser?.uid);
    await userDocument.get().then((DocumentSnapshot doc) {
      user = UserInformation.fromJson(doc.data() as Map<String, dynamic>);
    });
    return user;
  }

  Future<void> uploadImageUser({String? imagePath}) async {
    User? currentUser = FirebaseHelper.shared.auth.currentUser;
    CollectionReference userCollection = FirebaseHelper.firebaseFirestore
        .collection(AppCollection.userInformation);
    DocumentReference userDocument = userCollection.doc(currentUser?.uid);
    Reference imageReference =
        FirebaseHelper.firebaseStorage.ref().child(AppFolder.imageUser);
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
    userDocument.update({
      AppFieldName.displayName: displayName,
    });
  }

  Future<String> getImage({String? imagePath, String? folderPath}) async {
    Reference imageReference = FirebaseHelper.firebaseStorage
        .ref()
        .child(folderPath ?? AppFolder.imageArticle);
    UploadTask uploadTask =
        imageReference.child("${DateTime.now()}.png").putFile(
              File(imagePath ?? ""),
            );
    var imageUrl = await (await uploadTask).ref.getDownloadURL();
    return imageUrl;
  }

  Future<void> createYourArticle({YourArticle? yourArticle}) async {
    User? currentUser = FirebaseHelper.shared.auth.currentUser;
    CollectionReference yourArticleCollection = FirebaseHelper.firebaseFirestore
        .collection(AppCollection.yourArticleCollection);
    DocumentReference articleDocument =
        yourArticleCollection.doc("${currentUser?.uid}${DateTime.now()}");
    final newYourArticle = yourArticle;
    await articleDocument.set(newYourArticle?.toJson());
  }

  Future<YourArticle?> getYourArticle() async {
    CollectionReference articleCollection =
        firebaseFirestore.collection(AppCollection.yourArticleCollection);
    YourArticle? yourArticle;
    DocumentReference articleDocument =
        articleCollection.doc("2OB1mADhcMFnixwPh1xc");
    await articleDocument.get().then((DocumentSnapshot doc) {
      yourArticle = YourArticle.fromJson(doc.data() as Map<String, dynamic>);
    });
    return yourArticle;
  }
}
