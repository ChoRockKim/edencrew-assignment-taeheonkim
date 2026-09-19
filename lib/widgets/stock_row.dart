import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../theme/theme.dart';

class StockRow extends StatelessWidget {
  const StockRow({
    super.key,
    required this.name,
    required this.symbol,
    required this.market,
    required this.price,
    required this.change,
    required this.changeRate,
  });

  final String name; // 삼성전자
  final String symbol; // 005930
  final String market; // 코스피
  final int price; // 260000
  final int change; // 7500
  final double changeRate; // 2.97

  /// 260000 -> 260,000
  String get _priceText => NumberFormat('#,###').format(price);

  /// 7500, 2.97 -> +7,500 (+2.97%)
  /// 음수는 숫자 자체에 부호가 붙으므로 양수일 때만 '+'를 덧붙입니다.
  String get _changeText {
    final String sign = change > 0 ? '+' : '';
    final String amount = NumberFormat('#,###').format(change);
    final String rate = changeRate.toStringAsFixed(2);
    return '$sign$amount ($sign$rate%)';
  }

  Color _changeColor(BuildContext context) {
    final AppColors colors = context.colors;

    if (change > 0) return colors.priceUpText;
    if (change < 0) return colors.priceDownText;
    return colors.priceFlatText;
  }

  @override
  Widget build(BuildContext context) {
    final AppColors colors = context.colors;
    final AppDimens dimens = context.dimens;

    return Container(
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(
            width: dimens.borderHairline,
            color: colors.borderSubtle,
          ),
        ),
      ),
      padding: EdgeInsets.symmetric(
        vertical: dimens.space3,
        horizontal: dimens.space4,
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  name,
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: AppTypography.medium,
                    color: colors.textPrimary,
                    letterSpacing: -0.1,
                  ),
                ),
                SizedBox(height: 2),
                Text(
                  '$symbol · $market',
                  style: TextStyle(fontSize: 11, color: colors.textSecondary),
                ),
              ],
            ),
          ),
          SizedBox(width: dimens.space3),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                _priceText,
                style: TextStyle(
                  fontSize: 15,
                  color: colors.textPrimary,
                  letterSpacing: -0.1,
                  fontWeight: AppTypography.medium,
                ),
              ),
              SizedBox(height: 2),
              Text(
                _changeText,
                style: TextStyle(fontSize: 11, color: _changeColor(context)),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
