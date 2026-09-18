import 'search_screen.dart';
import 'watchlist_screen.dart';
import 'package:flutter/material.dart';
import 'theme/theme.dart';
import 'widgets/app_icon.dart';

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
            Expanded(child: _tabItem('ico_star_fill', '관심', 0)),
            Expanded(child: _tabItem('ico_search', '검색', 1)),
          ],
        ),
      ),
    );
  }

  Widget _tabItem(String icon, String name, int index) {
    final bool selected = _currentIndex == index;
    final Color color = selected
        ? context.colors.navActive
        : context.colors.navInactive;

    return GestureDetector(
      onTap: () => setState(() => _currentIndex = index),
      behavior: HitTestBehavior.opaque,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          AppIcon(icon, size: context.dimens.iconLg, color: color),
          SizedBox(height: context.dimens.space1),
          Text(name, style: TextStyle(color: color, fontSize: 11)),
        ],
      ),
    );
  }
}
