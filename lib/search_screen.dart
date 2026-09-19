import 'package:edencrew_assignment_starter/favorites_store.dart';
import 'package:edencrew_assignment_starter/widgets/search_result_row.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'favorites_store.dart';
import 'theme/theme.dart';
import 'widgets/app_icon.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final TextEditingController _controller = TextEditingController();
  String _query = '';

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  static const _allStocks = [
    {'name': '삼성전자', 'symbol': '005930', 'market': '코스피'},
    {'name': '삼성전기', 'symbol': '009150', 'market': '코스피'},
    {'name': '삼성SDI', 'symbol': '006400', 'market': '코스피'},
    {'name': 'SK하이닉스', 'symbol': '000660', 'market': '코스피'},
    {'name': '카카오', 'symbol': '035720', 'market': '코스피'},
    {'name': '에코프로비엠', 'symbol': '247540', 'market': '코스닥'},
    {'name': 'LG에너지솔루션', 'symbol': '373220', 'market': '코스피'},
  ];

  // 필터링
  List<Map<String, String>> get _results {
    if (_query.isEmpty) return [];

    return _allStocks.where((s) {
      final name = s['name']!.toLowerCase();
      final symbol = s['symbol']!;
      final q = _query.toLowerCase();
      return name.contains(q) || symbol.contains(q);
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            _searchBar(context),
            Expanded(child: _body(context)),
          ],
        ),
      ),
    );
  }

  Widget _searchBar(BuildContext context) {
    final AppColors colors = context.colors;
    final AppDimens dimens = context.dimens;

    return Padding(
      padding: EdgeInsets.only(
        left: dimens.space4,
        right: dimens.space4,
        top: dimens.space2,
        bottom: dimens.space3,
      ),
      child: Container(
        height: dimens.fieldHeight,
        padding: EdgeInsets.symmetric(horizontal: dimens.space3),
        decoration: BoxDecoration(
          color: colors.surfaceSunken,
          borderRadius: BorderRadius.circular(dimens.radiusMd),
          border: Border.all(
            color: colors.borderStrong,
            width: dimens.borderHairline,
          ),
        ),
        child: Row(
          children: [
            AppIcon(
              'ico_search',
              size: dimens.iconSm,
              color: colors.textTertiary,
            ),
            SizedBox(width: dimens.space2),
            Expanded(
              child: TextField(
                controller: _controller,
                onChanged: (value) => setState(() => _query = value),
                style: TextStyle(
                  color: colors.textPrimary,
                  fontSize: 15,
                  fontWeight: AppTypography.medium,
                  letterSpacing: -0.1,
                  height: 20 / 15,
                ),
                cursorColor: colors.accentDefault,
                decoration: InputDecoration(
                  border: InputBorder.none,
                  isDense: true,
                  contentPadding: EdgeInsets.zero,
                  hintText: '종목명 또는 종목코드',
                  hintStyle: TextStyle(
                    color: colors.textTertiary,
                    fontSize: 15,
                    fontWeight: AppTypography.medium,
                    letterSpacing: -0.1,
                    height: 20 / 15,
                  ),
                ),
              ),
            ),
            SizedBox(width: dimens.space2),
            GestureDetector(
              behavior: HitTestBehavior.opaque,
              onTap: () {
                _controller.clear();
                setState(() => _query = "");
              },
              child: AppIcon(
                'ico_x',
                size: dimens.iconSm,
                color: colors.textTertiary,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _body(BuildContext context) {
    if (_query.isEmpty) {
      return const Center(child: Text('빈 상태'));
    }
    if (_results.isEmpty) {
      return const Center(child: Text('결과없음'));
    }

    return ListView.builder(
      itemCount: _results.length,
      itemBuilder: (context, index) {
        final s = _results[index];
        final String id = 'domestic:${s['symbol']}';
        final favorites = context.watch<FavoritesStore>();
        return SearchResultRow(
          name: s['name']!,
          symbol: s['symbol']!,
          market: s['market']!,
          isFavorite: favorites.isFavorite(id),
          query: _query,
          onTapStar: () => context.read<FavoritesStore>().toggle(id),
        );
      },
    );
  }
}
