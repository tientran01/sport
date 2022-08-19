import 'package:sport_app/component/app_bar/custom_app_bar.dart';
import 'package:sport_app/component/custom_text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sport_app/component/text_view.dart';
import 'package:sport_app/l10n/lang.dart';
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
      appBar: const CustomAppBar(
        title: AppStrings.signInWithPhoneNumber,
      ),
      body: BlocBuilder<PhoneAuthBloc, PhoneAuthState>(
        builder: (_, state) {
          return Container(
            padding: EdgeInsets.symmetric(horizontal: Constants.size30),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(height: Constants.size30),
                CustomTextField(
                  type: TextFieldType.phoneNumber,
                  hintText: AppLocalizations.of(context).phoneNumber,
                  onChanged: (String phoneNumber) =>
                      getIt.get<PhoneAuthBloc>().add(
                            GetPhoneFromFieldAndValidateEvent(
                              phoneNumber: phoneNumber,
                            ),
                          ),
                  prefix: const TextView(
                    text: "+84 ",
                    textColor: AppColor.black,
                  ),
                  suffixIcon: InkWell(
                    onTap: () => getIt.get<PhoneAuthBloc>().add(
                          const SendOtpToPhoneAuthEvent(),
                        ),
                    customBorder: const CircleBorder(),
                    splashColor: AppColor.arsenic,
                    child: Container(
                      padding:
                          EdgeInsets.symmetric(horizontal: Constants.size20),
                      child: Image.asset(
                        AppResource.send,
                        width: Constants.size27,
                        height: Constants.size27,
                      ),
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
