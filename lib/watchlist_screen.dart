import 'package:edencrew_assignment_starter/theme/app_theme.dart';
import 'package:edencrew_assignment_starter/theme/app_typography.dart';
import 'package:edencrew_assignment_starter/widgets/stock_row.dart';
import 'package:flutter/material.dart';

import 'widgets/app_icon.dart';

class WatchlistScreen extends StatelessWidget {
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
              child: ListView.builder(
                itemCount: _mockStocks.length,
                itemBuilder: (context, index) {
                  final s = _mockStocks[index];
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
}
