import 'dart:async';
import 'package:sport_app/bloc/verify_otp_bloc/bloc/verify_otp_bloc.dart';
import 'package:sport_app/bloc/verify_otp_bloc/bloc/verify_otp_event.dart';
import 'package:sport_app/bloc/verify_otp_bloc/bloc/verify_otp_state.dart';
import 'package:sport_app/component/custom_app_bar.dart';
import 'package:sport_app/component/custom_button.dart';
import 'package:sport_app/component/custom_otp_field.dart';
import 'package:sport_app/resource/app_color.dart';
import 'package:sport_app/resource/app_style.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../main.dart';
import '../../../resource/app_strings.dart';
import '../../../resource/constants.dart';

class PhoneOTPScreen extends StatefulWidget {
  const PhoneOTPScreen({Key? key}) : super(key: key);

  @override
  State<PhoneOTPScreen> createState() => _PhoneOTPScreenState();
}

class _PhoneOTPScreenState extends State<PhoneOTPScreen> {
  final pinController = TextEditingController();
  int max = 30;
  String? time;
  bool ignoring = false;
  Timer? timer;
  @override
  void initState() {
    setStatus(!ignoring);
    super.initState();
    startTimer();
  }

  void startTimer() {
    timer = Timer.periodic(const Duration(seconds: 1), (Timer timer) {
      if (timer.tick >= max) {
        setState(() {
          time = '00:00';
        });
        timer.cancel();
        setStatus(!ignoring);
      } else {
        setState(() {
          time = '${((max - timer.tick) ~/ 60).toString().padLeft(2, '0')}:'
              '${((max - timer.tick) % 60).toString().padLeft(2, '0')}';
        });
      }
    });
  }

  void setStatus(bool newValue) {
    setState(() {
      ignoring = newValue;
    });
  }

  @override
  Widget build(BuildContext context) {
    String phoneNumber = ModalRoute.of(context)?.settings.arguments as String;
    return Scaffold(
      appBar: const CustomAppBar(
        title: AppStrings.verifyPhone,
      ),
      body: BlocBuilder<VerifyOtpBloc, VerifyOtpState>(
        builder: (_, state) {
          return Container(
            padding: EdgeInsets.symmetric(
              horizontal: Constants.size30,
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "${AppStrings.phoneGetOtp} $phoneNumber",
                  style: AppStyle.title,
                ),
                SizedBox(height: Constants.size30),
                Container(
                  alignment: Alignment.center,
                  child: CustomOTPField(
                    textEditingController: pinController,
                    onChanged: (String otpCode) {
                      getIt.get<VerifyOtpBloc>().add(
                            GetOtpFormFieldEvent(otpCode: otpCode),
                          );
                    },
                  ),
                ),
                SizedBox(
                  height: Constants.size30,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      AppStrings.sendOTPfail,
                      style: AppStyle.lightTitle,
                    ),
                    IgnorePointer(
                      ignoring: ignoring,
                      child: GestureDetector(
                        onTap: () {
                          pinController.clear();
                          getIt.get<VerifyOtpBloc>().add(
                                ResendOtpCodeEvent(
                                  phoneNumber: phoneNumber,
                                ),
                              );
                          startTimer();
                        },
                        child: Text(
                          AppStrings.requestAgain,
                          style: AppStyle.title.copyWith(
                            color: ignoring
                                ? AppColor.hDDDDDD.withOpacity(0.6)
                                : AppColor.h413F42,
                          ),
                        ),
                      ),
                    )
                  ],
                ),
                SizedBox(height: Constants.size30),
                CustomButton(
                  text: AppStrings.signUp,
                  bgColor: AppColor.h413F42,
                  onTap: () => getIt
                      .get<VerifyOtpBloc>()
                      .add(SignUpWithPhoneNumberEvent()),
                ),
                SizedBox(height: Constants.size30),
                RichText(
                  text: TextSpan(
                    children: [
                      TextSpan(
                        text: AppStrings.resendOtpCode,
                        style: AppStyle.title,
                      ),
                      TextSpan(
                        text: time,
                        style: AppStyle.title.copyWith(
                          color: AppColor.hEB4747,
                        ),
                      ),
                      TextSpan(
                        text: AppStrings.sec,
                        style: AppStyle.title,
                      )
                    ],
                  ),
                )
              ],
            ),
          );
        },
      ),
    );
  }
}
