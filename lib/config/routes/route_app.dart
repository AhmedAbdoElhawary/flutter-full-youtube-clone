import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:youtube/presentation/layouts/base_layout.dart';
import 'package:youtube/presentation/pages/channel_profile/user_channel_page.dart';
import 'package:youtube/presentation/pages/home/views/home_page.dart';
import 'package:youtube/presentation/pages/library/library_page.dart';
import 'package:youtube/presentation/pages/search/search_page.dart';
import 'package:youtube/presentation/pages/search/searched_results_page.dart';
import 'package:youtube/presentation/pages/shorts/shorts_page.dart';
import 'package:youtube/presentation/pages/subscriptions/subscriptions_page.dart';

class Go<T> {
  final BuildContext context;
  Go(this.context);

  to(String routeName, {bool appearNavigationBar = true, T? arg}) {
    return Navigator.of(context, rootNavigator: !appearNavigationBar)
        .pushNamed(routeName, arguments: arg);
  }

  offAll(Widget page) => Navigator.of(context).pushAndRemoveUntil(
      CupertinoPageRoute(builder: (context) => page), (route) => false);

  offCurrent(String routeName, {bool appearNavigationBar = true, T? arg}) {
    return Navigator.of(context, rootNavigator: appearNavigationBar)
        .pushReplacementNamed(routeName, arguments: arg);
  }

  back() => Navigator.of(context).maybePop();
}

class Routes {
  /// [baseLayout] no parameters
  static const String baseLayout = "/";

  static const String homePage = "/homePage";
  static const String libraryPage = "/libraryPage";
  static const String subscriptionsPage = "/subscriptionsPage";

  /// [mostPopularVideosPage] no parameters
  static const String mostPopularVideosPage = "/mostPopularVideosPage";

  /// [userChannelPage] parameters are : channelId, channelDetailsItem
  static const String userChannelPage = "/userChannelPage";

  ///maybe [searchPage] has parameter : text

  static const String searchPage = "/searchPage";

  /// [userChannelPage] parameter is : videoDetailsItem

  static const String shortsPage = "/shortsPage";

  /// [searchedResultsPage] parameter is : text

  static const String searchedResultsPage = "/searchedResultsPage";
}

class RouteGenerator {
  static Route<dynamic> getRoute(RouteSettings routeSettings) {
    Object? arg = routeSettings.arguments;
    switch (routeSettings.name) {
      case Routes.baseLayout:
        return _material(const BaseLayout());
      case Routes.homePage:
        return _material(const HomePage());
      case Routes.mostPopularVideosPage:
      case Routes.libraryPage:
        return _material(const LibraryPage());
      case Routes.subscriptionsPage:
        return _material(const SubscriptionsPage());
      case Routes.userChannelPage:
        return _material(UserChannelPage(arg as UserChannelPageParameters));
      case Routes.searchPage:
        return _material(SearchPage(arg as SearchPageParameters));
      case Routes.shortsPage:
        return _material(ShortsPage(parameters: arg as ShortsPageParameters));
      case Routes.searchedResultsPage:
        return _material(
            SearchedResultsPage(arg as SearchedResultsPageParameter));

      default:
        return unDefinedRoute();
    }
  }

  static MaterialPageRoute<dynamic> _material(Widget page) =>
      MaterialPageRoute(builder: (_) => page);

  static Route<dynamic> unDefinedRoute() {
    return MaterialPageRoute(
        builder: (_) => Scaffold(
              appBar: AppBar(title: const Text("No route found")),
              body: const Center(child: Text("No route found")),
            ));
  }
}
