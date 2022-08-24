import 'package:sport_app/component/custom_text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sport_app/component/text_view.dart';
import 'package:sport_app/l10n/s.dart';
import 'package:sport_app/pages/base/base_view.dart';
import 'package:sport_app/resource/resource.dart';
import '../../../bloc/phone_auth/bloc/phone_auth_bloc.dart';
import '../../../bloc/phone_auth/bloc/phone_auth_event.dart';
import '../../../bloc/phone_auth/bloc/phone_auth_state.dart';
import '../../../main.dart';

class PhoneInputScreen extends StatefulWidget {
  const PhoneInputScreen({Key? key}) : super(key: key);

  @override
  State<PhoneInputScreen> createState() => _PhoneInputScreenState();
}

class _PhoneInputScreenState extends State<PhoneInputScreen> with BaseView {
  @override
  String? get titleAppBar => S.of(context).signInWithPhoneNumber;

  @override
  Widget get body {
    return BlocBuilder<PhoneAuthBloc, PhoneAuthState>(
      builder: (_, state) {
        return Container(
          padding: EdgeInsets.symmetric(horizontal: Constants.size30),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(height: Constants.size30),
              CustomTextField(
                type: TextFieldType.phoneNumber,
                hintText: S.of(context).phoneNumber,
                onChanged: (String phoneNumber) {
                  getIt.get<PhoneAuthBloc>().add(
                        GetPhoneFromFieldAndValidateEvent(
                          phoneNumber: phoneNumber,
                        ),
                      );
                },
                prefix: Padding(
                  padding: EdgeInsets.only(
                    top: Constants.size20,
                    left: Constants.size10,
                    bottom: Constants.size20,
                  ),
                  child: const TextView(
                    text: "+84 ",
                    textColor: AppColor.black,
                    fontWeight: FontWeight.w800,
                  ),
                ),
                suffixIcon: InkWell(
                  onTap: () => getIt.get<PhoneAuthBloc>().add(
                        const SendOtpToPhoneAuthEvent(),
                      ),
                  customBorder: const CircleBorder(),
                  splashColor: AppColor.arsenic,
                  child: Container(
                    padding: EdgeInsets.symmetric(
                      horizontal: Constants.size20,
                    ),
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
    );
  }
}
