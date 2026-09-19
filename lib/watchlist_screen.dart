import 'package:edencrew_assignment_starter/favorites_store.dart';
import 'package:edencrew_assignment_starter/widgets/stock_row.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'widgets/app_icon.dart';
import 'widgets/empty_state.dart';

import 'theme/theme.dart';

class WatchlistScreen extends StatefulWidget {
  const WatchlistScreen({super.key});

  static const _mockStocks = [
    {
      'name': '삼성전자',
      'symbol': '005930',
      'market': '코스피',
      'price': 260000,
      'change': 7500,
      'rate': 2.97,
    },
    {
      'name': 'SK하이닉스',
      'symbol': '000660',
      'market': '코스피',
      'price': 1849000,
      'change': 104000,
      'rate': 5.96,
    },
    {
      'name': '카카오',
      'symbol': '035720',
      'market': '코스피',
      'price': 33600,
      'change': 100,
      'rate': 0.30,
    },
    {
      'name': '에코프로비엠',
      'symbol': '247540',
      'market': '코스닥',
      'price': 105300,
      'change': 2600,
      'rate': 2.53,
    },
    {
      'name': 'LG에너지솔루션',
      'symbol': '373220',
      'market': '코스피',
      'price': 363500,
      'change': -1500,
      'rate': -0.41,
    },
  ];

  @override
  State<WatchlistScreen> createState() => _WatchlistScreenState();
}

class _WatchlistScreenState extends State<WatchlistScreen> {
  String _sortLabel = '가나다순';

  /// 관심 등록된 종목만 골라 현재 정렬 기준으로 정렬한 목록.
  List<Map<String, Object>> _visibleStocks(FavoritesStore favorites) {
    final list = WatchlistScreen._mockStocks
        .where((s) => favorites.isFavorite('domestic:${s['symbol']}'))
        .toList();

    switch (_sortLabel) {
      case '현재가순':
        list.sort((a, b) => (b['price'] as int).compareTo(a['price'] as int));
      case '등락률순':
        list.sort(
          (a, b) => (b['rate'] as double).compareTo(a['rate'] as double),
        );
      case '가나다순':
        list.sort(
          (a, b) => (a['name'] as String).compareTo(b['name'] as String),
        );
    }
    return list;
  }

  @override
  Widget build(BuildContext context) {
    final AppColors colors = context.colors;
    final AppDimens dimens = context.dimens;

    final favorites = context.watch<FavoritesStore>();
    final stocks = _visibleStocks(favorites);
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.symmetric(
                horizontal: dimens.space4,
                vertical: dimens.space3,
              ),
              child: Row(
                children: [
                  Text(
                    '관심',
                    style: TextStyle(
                      color: colors.textPrimary,
                      fontSize: 19,
                      fontWeight: AppTypography.bold,
                      letterSpacing: -0.2,
                    ),
                  ),
                  const Spacer(),
                  GestureDetector(
                    behavior: HitTestBehavior.opaque,
                    onTap: () => _openSortSheet(),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          _sortLabel,
                          style: TextStyle(
                            fontSize: 13,
                            fontWeight: AppTypography.bold,
                            color: colors.textSecondary,
                          ),
                        ),
                        AppIcon(
                          'ico_align',
                          size: dimens.iconMd,
                          color: colors.textSecondary,
                        ),
                      ],
                    ),
                  ),
                  SizedBox(width: dimens.space4),
                  AppIcon(
                    'ico_refresh',
                    size: dimens.iconMd,
                    color: colors.textSecondary,
                  ),
                ],
              ),
            ),
            // 임시 값
            Expanded(
              child: stocks.isEmpty
                  ? const EmptyState(
                      icon: 'ico_star',
                      title: '관심 종목이 없습니다',
                      message: '검색 탭에서 종목을 찾아\n별 아이콘을 눌러 추가해 주세요.',
                    )
                  : ListView.builder(
                      itemCount: stocks.length,
                      itemBuilder: (context, index) {
                        final s = stocks[index];
                        return StockRow(
                          name: s['name'] as String,
                          symbol: s['symbol'] as String,
                          market: s['market'] as String,
                          price: s['price'] as int,
                          change: s['change'] as int,
                          changeRate: s['rate'] as double,
                        );
                      },
                    ),
            ),
          ],
        ),
      ),
    );
  }

  void _openSortSheet() {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (context) {
        final AppColors colors = context.colors;
        final AppDimens dimens = context.dimens;

        return Container(
          decoration: BoxDecoration(
            color: colors.surfaceOverlay,
            borderRadius: const BorderRadius.vertical(top: Radius.circular(16)),
          ),
          padding: const EdgeInsets.only(bottom: 34),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              SizedBox(
                height: 64,
                child: Row(
                  children: [
                    SizedBox(width: dimens.space6),
                    Text(
                      '정렬',
                      style: TextStyle(
                        fontSize: 19,
                        fontWeight: AppTypography.bold,
                        color: colors.textPrimary,
                        letterSpacing: -0.2,
                      ),
                    ),
                  ],
                ),
              ),
              _sortOption(context, '현재가순'),
              _sortOption(context, '등락률순'),
              _sortOption(context, '가나다순'),
            ],
          ),
        );
      },
    );
  }

  Widget _sortOption(BuildContext context, String label) {
    final bool selected = _sortLabel == label;

    final AppColors colors = context.colors;
    final AppDimens dimens = context.dimens;

    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: () {
        setState(() => _sortLabel = label);
        Navigator.pop(context);
      },
      child: SizedBox(
        height: dimens.rowMinHeight,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: dimens.space6),
          child: Row(
            children: [
              Text(
                label,
                style: TextStyle(
                  fontSize: 15,
                  fontWeight: AppTypography.medium,
                  letterSpacing: -0.1,
                  color: selected ? colors.textPrimary : colors.textSecondary,
                ),
              ),
              const Spacer(),
              if (selected)
                AppIcon('ico_check', size: 24, color: colors.textPrimary),
            ],
          ),
        ),
      ),
    );
  }
}
