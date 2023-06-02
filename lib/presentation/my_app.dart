import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:youtube/config/themes/app_theme.dart';
import 'package:youtube/config/themes/theme_service.dart';
import 'package:youtube/core/helpers/auth_service.dart';
import 'package:youtube/core/helpers/binding.dart';
import 'package:youtube/core/resources/assets_manager.dart';
import 'package:youtube/core/resources/color_manager.dart';
import 'package:youtube/core/translations/app_lang.dart';
import 'package:youtube/core/translations/translations.dart';
import 'package:youtube/core/utility/constants.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:youtube/core/utility/injector.dart';
import 'package:youtube/presentation/cubit/channel/channel_details_cubit.dart';
import 'package:youtube/presentation/cubit/channel/channel_videos/channel_videos_cubit.dart';
import 'package:youtube/presentation/cubit/channel/playlist/play_list_cubit.dart';
import 'package:youtube/presentation/cubit/search/search_cubit.dart';
import 'package:youtube/presentation/cubit/single_video/single_video_cubit.dart';
import 'package:youtube/presentation/cubit/videos/popular_videos/popular_videos_cubit.dart';
import 'package:youtube/presentation/cubit/videos/videos_details_cubit.dart';
import 'package:youtube/presentation/layouts/base_layout.dart';
part 'common_widgets/multi_bloc_provider.dart';

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return const MultiBlocs(_GetBuilder());
  }
}

class _GetBuilder extends StatelessWidget {
  const _GetBuilder();

  @override
  Widget build(BuildContext context) {
    defineThePlatform(context);

    return ScreenUtilInit(
      designSize: const Size(360, 690),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) {
        return GetBuilder<AppLanguage>(
          init: AppLanguage(),
          builder: (controller) {
            return GetMaterialApp(
              initialBinding: GetXBinding(),
              title: 'Youtube',
              theme: AppTheme.light,
              translations: Translation(),
              locale: Locale(controller.appLang),
              fallbackLocale: const Locale('en'),
              darkTheme: AppTheme.dark,
              themeMode: ThemeOfApp().theme,
              debugShowCheckedModeBanner: false,
              home: const SplashScreen(),
            );
          },
        );
      },
    );
  }

  defineThePlatform(BuildContext context) {
    TargetPlatform platform = Theme.of(context).platform;
    isThatMobile =
        platform == TargetPlatform.iOS || platform == TargetPlatform.android;
    isThatAndroid = platform == TargetPlatform.android;
  }
}

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return AnimatedSplashScreen.withScreenFunction(
      screenFunction: screenFunction,
      centered: true,
      splash: IconsAssets.splashIcon,
      backgroundColor: BaseColorManager.white,
      splashIconSize: 90.r,
    );
  }

  Future<Widget> screenFunction() async {
    await GetStorage.init();
    await initializeDependencies();

    await AuthService.signInWithGoogle();

    return  const BaseLayout();
  }
}
