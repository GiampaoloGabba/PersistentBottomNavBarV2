part of persistent_bottom_nav_bar_v2;

@optionalTypeArgs
Future<T?> pushScreen<T extends Object?>(
  BuildContext context, {
  required Widget screen,
  bool withNavBar = true,
  PageTransitionAnimation pageTransitionAnimation =
      PageTransitionAnimation.cupertino,
  PageRoute? customPageRoute,
  RouteSettings? settings,
}) {
  return Navigator.of(context, rootNavigator: !withNavBar)
      .push<T>(customPageRoute as Route<T>? ??
          getPageRoute(
            pageTransitionAnimation,
            enterPage: screen,
            settings: settings,
          ));
}

@optionalTypeArgs
Future<T?> pushWithNavBar<T>(BuildContext context, Route<T> route) {
  return Navigator.of(context, rootNavigator: false).push<T>(route);
}

@optionalTypeArgs
Future<T?> pushWithoutNavBar<T>(BuildContext context, Route<T> route) {
  return Navigator.of(context, rootNavigator: false).push<T>(route);
}