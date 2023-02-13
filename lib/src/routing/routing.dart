import 'package:demovideo/src/home/home_view.dart';
import 'package:demovideo/src/video/video_app.dart';
import 'package:flutter/material.dart';

class RouteNames {
  static const home = "/";
  static const video = "/video";
}

class Routing {
  static Route<dynamic>? onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case RouteNames.video:
        return CustomFadeRoute<void>(builder: (_) => const VideoApp());
      case RouteNames.home:
      default:
        return CustomFadeRoute<void>(builder: (_) => const HomeView());
    }
  }
}

class CustomFadeRoute<T> extends MaterialPageRoute<T> {
  CustomFadeRoute({required WidgetBuilder builder, RouteSettings? settings})
      : super(builder: builder, settings: settings);

  @override
  Widget buildTransitions(BuildContext context, Animation<double> animation,
      Animation<double> secondaryAnimation, Widget child) {
    return FadeTransition(opacity: animation, child: child);
  }
}
