import 'package:sport_app/application/application.dart';
import 'package:sport_app/model/category.dart';
import 'package:sport_app/model/video.dart';
import 'package:sport_app/resource/resource.dart';

class AppStrings {
  static const String logo = "Hot News";
  static const String displayName = "Họ và tên";
  static const String displayNameInput = "Nhập tên";
  static const String email = "Email";
  static const String emailInput = "Nhập email";
  static const String phone = "Số điện thoại";
  static const String phoneInput = "Nhập số điện thoại";
  static const String password = "Mật khẩu";
  static const String passwordInput = "Nhập mật khẩu";
  static const String confirmPassword = "Xác nhận mật khẩu";
  static const String confirmPasswordInput = "Nhập lại mật khẩu";
  static const String login = "Đăng nhập";
  static const String signUp = "Đăng ký";
  static const String signOut = "Đăng xuất";
  static const String forgetPassword = "Quên mật khẩu?";
  static const String emailInvalid = "Email không đúng định dạng";
  static const String phoneInvalid = "Số điện thoại không đúng định dạng";
  static const String passwordInvalid = "Mật khẩu không đủ điều kiện";
  static const String passwordRequired = "Mật khẩu phải dài từ 8-16 kí tự";
  static const String noAccount = "Chưa có tài khoản?";
  static const String notification = "Thông báo";
  static const String setting = "Cài đặt";
  static const String logout = "Đăng xuất";
  static const String deleteAccount = "Xoá tài khoản";
  static const String edit = "Chỉnh sửa";
  static const String hello = "Xin chào";
  static const String or = 'OR';
  static const String send = "Gửi";
  static const String requestInputOTP = "Enter your 6 digit OTP";
  static const String sendOTPfail = "Didn't recieve code? ";
  static const String requestAgain = "Request again";
  static const String verifyPhone = "Verify Phone";
  static const String required = "Bắt buộc";
  static const String home = "Trang chủ";
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
  static const String profile = "Tài khoản";
  static const String avatar = "Ảnh đại diện";
  static const String nickName = "Biệt danh";
  static const String uploadImage = "Tải ảnh lên";
  static const String checkValidEmail = "Verify Your Email";
  static const String messCheckEmail = "Please check your email";
  static const String searchInput = "Tìm kiếm";
  static const String category = "Chuyên mục";
  static const String justForYou = "Dành cho bạn";
  static const String hotNews = "Tin nổi bật";
  static const String mostInterested = "Được quan tâm nhất";
  static const String hotVideos = "Video nổi bật";
  static const String seeMore = "Xem thêm";
  static const String yourCollections = "Bộ sưu tập của bạn";
  static const String showAll = "Hiển thị tất cả";
  static const String news = "Tin tức";
  static const String createNewArticle = "Tạo bài viết";
  static const String yourArticle = "Bài viết của bạn";
  static const String titleArticle = "Tiêu đề bài viết";
  static const String titleArticleInput = ".....";
  static const String descArticle = "Mô tả bài viết";
  static const String descArticleInput = "Bạn đang nghĩ gì đấy?";
  static const String postArticle = "Đăng";
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
  static const String favorites = "Mục yêu thích";
  static const String bookmark = "Bộ sưu tập của bạn";
  static const String deleteAllFavorite = "Xoá tất cả bộ sưu tập";
  static const String addFavorite = "Thêm vào bộ sưu tập";
  static const String isExistFavorite = "Đã tồn tại";
  static const String suggestionSearch = "Gợi ý tìm kiếm";
  static const String chooseColor = "Chọn màu";
  static const String error404 = "Bad Request";
  static const String error429 = "Too many request";
  static const String removeAll = "Xoá tất cả";
  static const String failed = "Thất bại";
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
      name:
          "Stocks making the biggest moves premarket: Eli Lilly, Cigna, Restaurant Brands and more - CNBC",
      videoUrl:
          "https://commondatastorage.googleapis.com/gtv-videos-bucket/sample/ElephantsDream.mp4",
      thumbnailUrl:
          "https://commondatastorage.googleapis.com/gtv-videos-bucket/sample/images/ElephantsDream.jpg",
      time: "10.53",
      description:
          "The hottest place on earth is soaked after record rainfall, trapping visitors, staff and cars for hours.",
    ),
    Video(
      id: 2,
      name:
          "BOE Raises Rates by Most Since 1995, Warns of Long Recession - Bloomberg",
      videoUrl:
          "https://commondatastorage.googleapis.com/gtv-videos-bucket/sample/BigBuckBunny.mp4",
      thumbnailUrl:
          "https://commondatastorage.googleapis.com/gtv-videos-bucket/sample/images/BigBuckBunny.jpg",
      time: "09:56",
      description:
          "WASHINGTON (AP) — The Senate parliamentarian on Saturday dealt a blow to Democrats’ plan for curbing drug prices but left the rest of their sprawling economic bill largely intact as party leaders prepared for first votes on a package containing many of Presid",
    ),
    Video(
      id: 3,
      name: "For Bigger Blazes",
      videoUrl:
          "https://commondatastorage.googleapis.com/gtv-videos-bucket/sample/ForBiggerBlazes.mp4",
      thumbnailUrl:
          "https://commondatastorage.googleapis.com/gtv-videos-bucket/sample/images/ForBiggerBlazes.jpg",
      time: "0:15",
      description:
          "Chelsea also survived a slog while Aston Villa disappointed for Steven Gerrard",
    ),
    Video(
      id: 4,
      name: "For Bigger Escape",
      videoUrl:
          "https://commondatastorage.googleapis.com/gtv-videos-bucket/sample/ForBiggerEscapes.mp4",
      thumbnailUrl:
          "https://commondatastorage.googleapis.com/gtv-videos-bucket/sample/images/ForBiggerEscapes.jpg",
      time: "0:15",
      description:
          "Some legal experts said they were surprised by his conduct and questioned whether it was a calculated risk to boost his appeal to fans.",
    ),
    Video(
      id: 5,
      name:
          "Restaurant Brands International earnings top estimates, fueled by stronger Tim Hortons, Burger King sales - CNBC",
      videoUrl:
          "https://commondatastorage.googleapis.com/gtv-videos-bucket/sample/ForBiggerFun.mp4",
      thumbnailUrl:
          "https://commondatastorage.googleapis.com/gtv-videos-bucket/sample/images/ForBiggerFun.jpg",
      time: "01:00",
      description:
          "Elon Musk’s latest shenanigans involve challenging Twitter CEO Parag Agrawal to a “public debate” about how many bots Twitter has on the platform.",
    ),
    Video(
      id: 6,
      name:
          "Alibaba shares pop 5% after earnings beat — but reports first flat revenue growth in history - CNBC",
      videoUrl:
          "https://commondatastorage.googleapis.com/gtv-videos-bucket/sample/ForBiggerJoyrides.mp4",
      thumbnailUrl:
          "https://commondatastorage.googleapis.com/gtv-videos-bucket/sample/images/ForBiggerJoyrides.jpg",
      time: "0:15",
      description:
          "Bryant Young received a standing ovation from fans at the Hall of Fame ceremony.",
    ),
  ];
}
