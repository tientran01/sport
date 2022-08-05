import 'dart:async';
import 'package:sport_app/bloc/verify_otp_bloc/bloc/verify_otp_bloc.dart';
import 'package:sport_app/bloc/verify_otp_bloc/bloc/verify_otp_event.dart';
import 'package:sport_app/bloc/verify_otp_bloc/bloc/verify_otp_state.dart';
import 'package:sport_app/component/custom_app_bar.dart';
import 'package:sport_app/component/button.dart';
import 'package:sport_app/pages/auth/phone/components/custom_otp_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sport_app/component/text_view.dart';
import 'package:sport_app/resource/resource.dart';
import '../../../main.dart';

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
                TextView(
                  text: "${AppStrings.phoneGetOtp} (+84) $phoneNumber",
                ),
                SizedBox(height: Constants.size30),
                Container(
                  alignment: Alignment.center,
                  child: CustomOTPField(
                    textEditingController: pinController,
                    onChanged: (String otpCode) {
                      getIt.get<VerifyOtpBloc>().add(
                            GetOtpFormFieldEvent(
                              otpCode: otpCode,
                            ),
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
                    const TextView(
                      text: AppStrings.sendOTPfail,
                      textColor: AppColor.gainsboro,
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
                        child: TextView(
                          text: AppStrings.requestAgain,
                          textColor: ignoring
                              ? AppColor.gainsboro.withOpacity(0.6)
                              : AppColor.arsenic,
                        ),
                      ),
                    )
                  ],
                ),
                SizedBox(height: Constants.size30),
                Button(
                  text: AppStrings.signUp,
                  textColor: AppColor.white,
                  onTap: () => getIt
                      .get<VerifyOtpBloc>()
                      .add(SignUpWithPhoneNumberEvent()),
                ),
                SizedBox(height: Constants.size30),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const TextView(
                      text: AppStrings.resendOtpCode,
                    ),
                    TextView(
                      text: time,
                      textColor: AppColor.carminePink,
                    ),
                    const TextView(
                      text: AppStrings.sec,
                    ),
                  ],
                )
              ],
            ),
          );
        },
      ),
    );
  }
}
