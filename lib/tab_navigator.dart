// Scaffold オブジェクトのボディを新しい Navigator で包む。
import 'package:flutter/material.dart';
import 'package:flutter_bottom_navigation_bar/color_detail_page.dart';
import 'package:flutter_bottom_navigation_bar/colors_list_page.dart';
import 'package:flutter_bottom_navigation_bar/tab_item.dart';

class TabNavigatorRoutes {
  static const String root = '/';
  static const String detail = '/detail';
}

class TabNavigator extends StatelessWidget {
  const TabNavigator(
      {super.key, required this.navigatorKey, required this.tabItem});
  // navigatorKey は GlobalKey<NavigatorState> 型。アプリ全体でナビゲータを一意に識別するために、このキーが必要。
  final GlobalKey<NavigatorState> navigatorKey;
  final TabItem tabItem;

  // _routeBuilders は、定義した2つのルートにそれぞれ WidgetBuilder を関連付ける、
  Map<String, WidgetBuilder> _routeBuilders(BuildContext context,
      {int materialIndex = 500}) {
    return {
      TabNavigatorRoutes.root: (context) => ColorsListPage(
            color: tabItem.color,
            title: tabItem.name,
            onPush: (materialIndex) =>
                _push(context, materialIndex: materialIndex),
          ),
      TabNavigatorRoutes.detail: (context) => ColorDetailPage(
            color: tabItem.color,
            title: tabItem.name,
            materialIndex: materialIndex,
          ),
    };
  }

  // 新しい Navigator オブジェクトを返す build() メソッド
  // This takes a key and an initialRoute parameter.
  @override
  Widget build(BuildContext context) {
    final routeBuilders = _routeBuilders(context);
    return Navigator(
      key: navigatorKey,
      initialRoute: TabNavigatorRoutes.root,
      onGenerateRoute: (routeSettings) {
        // _routeBuilders() メソッドを利用するために onGenerateRoute を呼び出す。
        return MaterialPageRoute(
          // プッシュされる新しいルートの作成
          builder: (context) => routeBuilders[routeSettings.name!]!(context),
        );
      },
    );
  }

  void _push(BuildContext context, {int materialIndex = 500}) {
    var routeBuilders = _routeBuilders(context, materialIndex: materialIndex);

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) =>
            routeBuilders[TabNavigatorRoutes.detail]!(context),
      ),
    );
  }
}
