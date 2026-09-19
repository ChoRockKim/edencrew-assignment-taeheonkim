import 'dart:async';
import 'package:edencrew_assignment_starter/detail_screen.dart';
import 'package:edencrew_assignment_starter/widgets/search_result_row.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'favorites_store.dart';
import 'theme/theme.dart';
import 'widgets/app_icon.dart';
import 'widgets/empty_state.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final TextEditingController _controller = TextEditingController();
  String _query = '';
  String? _toastMessage;
  bool _toastIsAdd = false;
  Timer? _toastTimer;

  @override
  void dispose() {
    _toastTimer?.cancel();
    _controller.dispose();
    super.dispose();
  }

  void _showToast({required bool isAdd}) {
    _toastTimer?.cancel();

    setState(() {
      _toastIsAdd = isAdd;
      _toastMessage = isAdd ? '관심이 등록되었습니다' : '관심이 해제되었습니다';
    });

    _toastTimer = Timer(const Duration(seconds: 2), () {
      if (mounted) setState(() => _toastMessage = null);
    });
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
    final AppDimens dimens = context.dimens;

    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            Column(
              children: [
                _searchBar(context),
                Expanded(child: _body(context)),
              ],
            ),
            if (_toastMessage != null)
              Positioned(
                left: dimens.space4,
                right: dimens.space4,
                bottom: dimens.space4,
                child: _toast(context),
              ),
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
      return const EmptyState(
        icon: 'ico_search',
        title: '종목을 검색해 보세요',
        message: '종목명 또는 종목코드 6자리로\n검색하실 수 있습니다.',
      );
    }
    if (_results.isEmpty) {
      return EmptyState(
        icon: 'ico_search',
        title: '검색 결과가 없습니다',
        message: "'$_query'와 일치하는 검색 결과를 찾지 못했습니다.",
      );
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
          onTapStar: () {
            final store = context.read<FavoritesStore>();
            final bool willAdd = !store.isFavorite(id);
            store.toggle(id);
            _showToast(isAdd: willAdd);
          },
          onTap: () => Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => DetailScreen(
                name: s['name']!,
                symbol: s['symbol']!,
                market: s['market']!,
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _toast(BuildContext context) {
    final AppColors colors = context.colors;
    final AppDimens dimens = context.dimens;

    return Container(
      padding: EdgeInsets.symmetric(horizontal: dimens.space4, vertical: 14),
      decoration: BoxDecoration(
        color: colors.surfaceOverlay,
        borderRadius: BorderRadius.circular(dimens.radiusLg),
        border: Border.all(
          color: colors.borderSubtle,
          width: dimens.borderHairline,
        ),
      ),
      child: Row(
        children: [
          AppIcon(
            _toastIsAdd ? 'ico_star_fill' : 'ico_star',
            size: 18,
            color: colors.favoriteActive,
          ),
          SizedBox(width: dimens.space2),
          Text(
            _toastMessage!,
            style: TextStyle(
              fontSize: 13,
              fontWeight: AppTypography.bold,
              color: colors.textPrimary,
            ),
          ),
        ],
      ),
    );
  }
}
