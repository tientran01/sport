import 'package:sport_app/bloc/home/bloc/home_bloc.dart';
import 'package:sport_app/bloc/home/bloc/home_event.dart';
import 'package:sport_app/bloc/home/bloc/home_state.dart';
import 'package:sport_app/component/home/custom_name_section.dart';
import 'package:sport_app/component/home/custom_search.dart';
import 'package:sport_app/component/home/custom_slider.dart';
import 'package:sport_app/component/home/header_app_bar.dart';
import 'package:sport_app/helper/shared_preferences_helper.dart';
import 'package:sport_app/main.dart';
import 'package:sport_app/pages/product/widgets/custom_product_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sport_app/resource/resource.dart';
import '../../router/navigation_service.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late HomeBloc homeBloc;
  @override
  void initState() {
    super.initState();
    getIt.get<HomeBloc>().add(const UpdateBadgeEvent());
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeBloc, HomeState>(
      bloc: getIt<HomeBloc>(),
      builder: (_, state) {
        return Scaffold(
          backgroundColor: AppColor.hF9F9F9,
          appBar: HeaderAppBar(
            displayName: SharedPreferencesHelper.shared.getString(AppKeyName.displayName),
            email: SharedPreferencesHelper.shared.getString(AppKeyName.email),
            notificationCount: state.badge,
            onTap: () => NavigationService.navigatorKey.currentState?.pushNamed(AppRouteName.notification),
          ),
          body: LayoutBuilder(
            builder: (context, constraint) {
              return SingleChildScrollView(
                child: ConstrainedBox(
                  constraints: BoxConstraints(
                    minHeight: constraint.maxHeight,
                  ),
                  child: Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: Constants.size15,
                    ),
                    child: Column(
                      children: [
                        const CustomSlider(),
                        SizedBox(height: Constants.size20),
                        const CustomSearch(),
                        SizedBox(height: Constants.size20),
                        const CustomNameSection(
                          nameSection: AppStrings.category,
                        ),
                        const CustomNameSection(
                          nameSection: AppStrings.popularFood,
                        ),
                        SizedBox(
                          height: Constants.size200,
                          child: ListView.builder(
                            itemCount: 5,
                            scrollDirection: Axis.horizontal,
                            itemBuilder: (context, index) =>
                                const CustomProductItem(),
                          ),
                        ),
                        SizedBox(height: Constants.size20),
                      ],
                    ),
                  ),
                ),
              );
            },
          ),
        );
      },
    );
  }
}
