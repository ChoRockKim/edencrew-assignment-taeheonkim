import 'package:edencrew_assignment_starter/theme/app_theme.dart';
import 'package:edencrew_assignment_starter/theme/app_typography.dart';
import 'package:edencrew_assignment_starter/widgets/stock_row.dart';
import 'package:flutter/material.dart';

import 'widgets/app_icon.dart';

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

  List<Map<String, Object>> get _sortedStocks {
    // final list = [...WatchlistScreen._mockStocks]; 복사본
    final list = [];

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
    // return list;
    return [];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.symmetric(
                horizontal: context.dimens.space4,
                vertical: context.dimens.space3,
              ),
              child: Row(
                children: [
                  Text(
                    '관심',
                    style: TextStyle(
                      color: context.colors.textPrimary,
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
                            color: context.colors.textSecondary,
                          ),
                        ),
                        AppIcon(
                          'ico_align',
                          size: context.dimens.iconMd,
                          color: context.colors.textSecondary,
                        ),
                      ],
                    ),
                  ),
                  SizedBox(width: context.dimens.space4),
                  AppIcon(
                    'ico_refresh',
                    size: context.dimens.iconMd,
                    color: context.colors.textSecondary,
                  ),
                ],
              ),
            ),
            // 임시 값
            Expanded(
              child: _sortedStocks.isEmpty
                  ? _emptyState(context)
                  : ListView.builder(
                      itemCount: _sortedStocks.length,
                      itemBuilder: (context, index) {
                        final s = _sortedStocks[index];
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
      builder: (context) => Container(
        decoration: BoxDecoration(
          color: context.colors.surfaceOverlay,
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
                  SizedBox(width: context.dimens.space6),
                  Text(
                    '정렬',
                    style: TextStyle(
                      fontSize: 19,
                      fontWeight: AppTypography.bold,
                      color: context.colors.textPrimary,
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
      ),
    );
  }

  Widget _sortOption(BuildContext context, String label) {
    final bool selected = _sortLabel == label;

    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: () {
        setState(() => _sortLabel = label);
        Navigator.pop(context);
      },
      child: SizedBox(
        height: context.dimens.rowMinHeight,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: context.dimens.space6),
          child: Row(
            children: [
              Text(
                label,
                style: TextStyle(
                  fontSize: 15,
                  fontWeight: AppTypography.medium,
                  letterSpacing: -0.1,
                  color: selected
                      ? context.colors.textPrimary
                      : context.colors.textSecondary,
                ),
              ),
              const Spacer(),
              if (selected)
                AppIcon(
                  'ico_check',
                  size: 24,
                  color: context.colors.textPrimary,
                ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _emptyState(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          AppIcon('ico_star', size: 40, color: context.colors.textDisabled),
          SizedBox(height: context.dimens.space3),
          Text(
            '관심 종목이 없습니다',
            style: TextStyle(
              fontSize: 19,
              fontWeight: AppTypography.bold,
              color: context.colors.textSecondary,
              letterSpacing: -0.2,
            ),
          ),
          SizedBox(height: context.dimens.space3),
          Text(
            '검색 탭에서 종목을 찾아\n별 아이콘을 눌러 추가해주세요.',
            style: TextStyle(
              fontSize: 11,
              fontWeight: AppTypography.regular,
              color: context.colors.textTertiary,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
