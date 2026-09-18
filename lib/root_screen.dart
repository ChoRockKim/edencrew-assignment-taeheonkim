import 'search_screen.dart';
import 'watchlist_screen.dart';
import 'package:flutter/material.dart';
import 'theme/theme.dart';

class RootScreen extends StatefulWidget {
  const RootScreen({super.key});

  @override
  State<RootScreen> createState() => _RootScreenState();
}

class _RootScreenState extends State<RootScreen> {
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: _currentIndex,
        children: [WatchlistScreen(), SearchScreen()],
      ),
      bottomNavigationBar: Container(
        height: context.dimens.tabBarHeight,
        color: context.colors.surfaceRaised,
        child: Row(
          children: [
            Expanded(child: _tabItem(Icons.star, '관심', 0)),
            Expanded(child: _tabItem(Icons.search, '검색', 0)),
          ],
        ),
      ),
    );
  }

  Widget _tabItem(IconData icon, String name, int index) {
    final bool selected = _currentIndex == index;
    final Color color = selected
        ? context.colors.navActive
        : context.colors.navInactive;

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(icon, size: context.dimens.iconMd, color: color),
        SizedBox(height: context.dimens.space1),
        Text(name, style: TextStyle(color: color, fontSize: 11)),
      ],
    );
  }
}
