import 'package:flutter/material.dart';
import 'package:flutter_bottom_navigation_bar/color_detail_page.dart';
import 'package:flutter_bottom_navigation_bar/tab_item.dart';

class App extends StatefulWidget {
  const App({super.key});

  @override
  State<StatefulWidget> createState() => AppState();
}

class AppState extends State<App> {
  var _currentTab = TabItem.red;

  void _selectTab(TabItem tabItem) {
    setState(() => _currentTab = tabItem);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _buildBody(),
      bottomNavigationBar: BottomNavigation(
        currentTab: _currentTab,
        onSelectTab: _selectTab,
      ),
    );
  }

  Widget _buildBody() {
    return Container(
        color: activeTabColor[TabItem.red],
        alignment: Alignment.center,
        child: TextButton(
          onPressed: _push,
          child: const Text(
            'PUSH',
            style: TextStyle(fontSize: 32.0, color: Colors.white),
          ),
        ));
  }

  void _push() {
    Navigator.of(context).push(MaterialPageRoute(
      // we'll look at ColorDetailPage later
      builder: (context) => ColorDetailPage(
        color: activeTabColor[TabItem.red],
        title: tabName[TabItem.red],
      ),
    ));
  }
}

class BottomNavigation extends StatelessWidget {
  const BottomNavigation(
      {super.key, required this.currentTab, required this.onSelectTab});

  final TabItem currentTab;
  final ValueChanged<TabItem> onSelectTab;

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      type: BottomNavigationBarType.fixed,
      items: [
        _buildItem(TabItem.red),
        _buildItem(TabItem.green),
        _buildItem(TabItem.blue),
      ],
      onTap: (index) => onSelectTab(
        // TabItem.values で enum を配列で取得できる
        TabItem.values[index],
      ),
    );
  }

  BottomNavigationBarItem _buildItem(TabItem tabItem) {
    return BottomNavigationBarItem(
      icon: Icon(
        Icons.layers,
        color: _colorTabMatching(tabItem),
      ),
      label: tabName[tabItem],
    );
  }

  MaterialColor? _colorTabMatching(TabItem item) {
    return currentTab == item ? activeTabColor[item] : Colors.grey;
  }
}
