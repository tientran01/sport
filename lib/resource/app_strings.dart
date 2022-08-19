import 'package:sport_app/application/application.dart';
import 'package:sport_app/model/category.dart';
import 'package:sport_app/model/video.dart';
import 'package:sport_app/resource/resource.dart';

class AppStrings {
  static const String logo = "Hot News";
  
  static const String confirmPassword = "Xác nhận mật khẩu";
  static const String confirmPasswordInput = "Nhập lại mật khẩu";
  static const String forgetPassword = "Quên mật khẩu?";
  static const String emailInvalid = "Email không đúng định dạng";
  static const String phoneInvalid = "Số điện thoại không đúng định dạng";
  static const String passwordInvalid = "Mật khẩu không đủ điều kiện";
  static const String passwordRequired = "Mật khẩu phải dài từ 8-16 kí tự";
  static const String notification = "Thông báo";
  static const String send = "Gửi";
  static const String requestInputOTP = "Enter your 6 digit OTP";
  static const String sendOTPfail = "Didn't recieve code? ";
  static const String requestAgain = "Request again";
  static const String verifyPhone = "Verify Phone";
  static const String required = "Bắt buộc";
  static const String phoneGetOtp = "Code is sent to ";
  static const String loginFail = "Login Fail";
  static const String loginSuccess = "Login Success";
  static const String signInWithGoogle = "Sign in with google";
  static const String signInWithPhoneNumber = "Sign In With Phone Number";
  static const String resetPassword = "Reset Password";
  static const String createNewPassword = "Create New Password";
  static const String resendOtpCode = "Send OTP again in";
  static const String sec = "sec";
  static const String success = "Success";
  static const String loading = "Loading";
  static const String error = "Error";
  
  static const String checkValidEmail = "Verify Your Email";
  static const String messCheckEmail = "Please check your email";
  static const String searchInput = "Tìm kiếm";
  static const String hotNews = "Tin nổi bật";
  static const String mostInterested = "Được quan tâm nhất";
  
  static const String showAll = "Hiển thị tất cả";
  static const String news = "Tin tức";
  static const String createNewArticle = "Tạo bài viết";
  
  static const String channelDescription = "Channel Description";
  static const String channelId = "Channel Id";
  static const String channelName = "Channel Name";
  static const String showLocalNotification = "Show Local Notification";
  static const String showScheduledNotification = "Show Scheduled Notification";
  static const String showNotificationWithPayload =
      "Show Notification With Payload";
  static const String showPushNotification = "Show Push Notification";
  static const String localNotificationTitle = "Bloc Demo";
  static const String localNotificationBody = "Local Notification Body";
  static const String camera = "Máy ảnh";
  static const String gallery = "Bộ sưu tập";
  static const String cancel = "Huỷ bỏ";
  static const String done = "Xong";
  static const String editDisplayName = "Thay đổi tên hiển thị";
  static const String share = "Chia sẻ";
  static const String deleteAllFavorite = "Xoá tất cả bộ sưu tập";
  static const String addFavorite = "Thêm vào bộ sưu tập";
  static const String removeFavorite = "Xoá khỏi bộ sưu tập";
  static const String suggestionSearch = "Gợi ý tìm kiếm";
  static const String error404 = "Bad Request";
  static const String error429 = "Too many request";
  static const String removeAll = "Xoá tất cả";
  static const String failed = "Thất bại";
  static const String favorite = "Yêu thích";
  static const String author = "Tác giả";
  static const String deleteYourArticle = "Xoá bài viết";
  static const String areYouSureDelete = "Bạn muốn xoá bài viết?";
  static const String deleteNow = "Xoá ngay";

  static List<Category> categories = [
    Category(
      text: Application.top,
      color: AppColor.gargoyleGas,
    ),
    Category(
      text: Application.appleParamValue,
      color: AppColor.blue,
    ),
    Category(
      text: Application.bitcoinParamValue,
      color: AppColor.gainsboro,
    ),
    Category(
      text: Application.teslaParamValue,
      color: AppColor.jetStream,
    ),
  ];

  static List<Video> videos = [
    Video(
      id: 1,
      title:
          "Stocks making the biggest moves premarket: Eli Lilly, Cigna, Restaurant Brands and more - CNBC",
      videoUrl:
          "https://commondatastorage.googleapis.com/gtv-videos-bucket/sample/ElephantsDream.mp4",
      thumbnailUrl:
          "https://commondatastorage.googleapis.com/gtv-videos-bucket/sample/images/ElephantsDream.jpg",
      timeline: "10.53",
      describe:
          "The hottest place on earth is soaked after record rainfall, trapping visitors, staff and cars for hours.",
    ),
    Video(
      id: 2,
      title:
          "BOE Raises Rates by Most Since 1995, Warns of Long Recession - Bloomberg",
      videoUrl:
          "https://commondatastorage.googleapis.com/gtv-videos-bucket/sample/BigBuckBunny.mp4",
      thumbnailUrl:
          "https://commondatastorage.googleapis.com/gtv-videos-bucket/sample/images/BigBuckBunny.jpg",
      timeline: "09:56",
      describe:
          "WASHINGTON (AP) — The Senate parliamentarian on Saturday dealt a blow to Democrats’ plan for curbing drug prices but left the rest of their sprawling economic bill largely intact as party leaders prepared for first votes on a package containing many of Presid",
    ),
    Video(
      id: 3,
      title: "For Bigger Blazes",
      videoUrl:
          "https://commondatastorage.googleapis.com/gtv-videos-bucket/sample/ForBiggerBlazes.mp4",
      thumbnailUrl:
          "https://commondatastorage.googleapis.com/gtv-videos-bucket/sample/images/ForBiggerBlazes.jpg",
      timeline: "0:15",
      describe:
          "Chelsea also survived a slog while Aston Villa disappointed for Steven Gerrard",
    ),
    Video(
      id: 4,
      title: "For Bigger Escape",
      videoUrl:
          "https://commondatastorage.googleapis.com/gtv-videos-bucket/sample/ForBiggerEscapes.mp4",
      thumbnailUrl:
          "https://commondatastorage.googleapis.com/gtv-videos-bucket/sample/images/ForBiggerEscapes.jpg",
      timeline: "0:15",
      describe:
          "Some legal experts said they were surprised by his conduct and questioned whether it was a calculated risk to boost his appeal to fans.",
    ),
    Video(
      id: 5,
      title:
          "Restaurant Brands International earnings top estimates, fueled by stronger Tim Hortons, Burger King sales - CNBC",
      videoUrl:
          "https://commondatastorage.googleapis.com/gtv-videos-bucket/sample/ForBiggerFun.mp4",
      thumbnailUrl:
          "https://commondatastorage.googleapis.com/gtv-videos-bucket/sample/images/ForBiggerFun.jpg",
      timeline: "01:00",
      describe:
          "Elon Musk’s latest shenanigans involve challenging Twitter CEO Parag Agrawal to a “public debate” about how many bots Twitter has on the platform.",
    ),
    Video(
      id: 6,
      title:
          "Alibaba shares pop 5% after earnings beat — but reports first flat revenue growth in history - CNBC",
      videoUrl:
          "https://commondatastorage.googleapis.com/gtv-videos-bucket/sample/ForBiggerJoyrides.mp4",
      thumbnailUrl:
          "https://commondatastorage.googleapis.com/gtv-videos-bucket/sample/images/ForBiggerJoyrides.jpg",
      timeline: "0:15",
      describe:
          "Bryant Young received a standing ovation from fans at the Hall of Fame ceremony.",
    ),
  ];
}
