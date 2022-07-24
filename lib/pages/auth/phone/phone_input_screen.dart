import 'package:sport_app/component/custom_app_bar.dart';
import 'package:sport_app/component/custom_text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sport_app/resource/resource.dart';
import '../../../bloc/phone_auth/bloc/phone_auth_bloc.dart';
import '../../../bloc/phone_auth/bloc/phone_auth_event.dart';
import '../../../bloc/phone_auth/bloc/phone_auth_state.dart';
import '../../../main.dart';

class PhoneInputScreen extends StatelessWidget {
  const PhoneInputScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(),
      body: BlocBuilder<PhoneAuthBloc, PhoneAuthState>(
        builder: (_, state) {
          return Container(
            padding: EdgeInsets.symmetric(horizontal: Constants.size30),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  AppStrings.signInWithPhoneNumber.toUpperCase(),
                  style: AppStyle.darkText()
                ),
                SizedBox(height: Constants.size30),
                CustomTextField(
                  type: TextFieldType.phoneNumber,
                  hintText: AppStrings.phoneInput,
                  onChanged: (String phoneNumber) =>
                      getIt.get<PhoneAuthBloc>().add(
                            GetPhoneFromFieldAndValidateEvent(
                                phoneNumber: phoneNumber),
                          ),
                  suffixIcon: InkWell(
                    onTap: () => getIt.get<PhoneAuthBloc>().add(
                          const SendOtpToPhoneAuthEvent(),
                        ),
                    customBorder: const CircleBorder(),
                    splashColor: AppColor.h413F42,
                    child: Image.asset(
                      AppResource.sendIcon,
                      width: 10.0,
                      height: 10.0,
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
