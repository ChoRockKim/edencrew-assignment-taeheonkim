import 'package:edencrew_assignment_starter/theme/app_theme.dart';
import 'package:edencrew_assignment_starter/theme/app_typography.dart';
import 'package:flutter/material.dart';

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

  Color _changeColor(BuildContext context) {
    if (change > 0) return context.colors.priceUpText;
    if (change < 0) return context.colors.priceDownText;
    return context.colors.priceFlatText;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(
            width: context.dimens.borderHairline,
            color: context.colors.borderSubtle,
          ),
        ),
      ),
      padding: EdgeInsets.symmetric(
        vertical: context.dimens.space3,
        horizontal: context.dimens.space4,
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
                    color: context.colors.textPrimary,
                    letterSpacing: -0.1,
                  ),
                ),
                SizedBox(height: 2),
                Text(
                  '$symbol · $market',
                  style: TextStyle(
                    fontSize: 11,
                    color: context.colors.textSecondary,
                  ),
                ),
              ],
            ),
          ),
          SizedBox(width: context.dimens.space3),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                '$price',
                style: TextStyle(
                  fontSize: 15,
                  color: context.colors.textPrimary,
                  letterSpacing: -0.1,
                  fontWeight: AppTypography.medium,
                ),
              ),
              SizedBox(height: 2),
              Text(
                '$change ($changeRate%)',
                style: TextStyle(fontSize: 11, color: _changeColor(context)),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
