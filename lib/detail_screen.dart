import 'package:edencrew_assignment_starter/favorites_store.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import 'theme/theme.dart';
import 'widgets/app_icon.dart';

class DetailScreen extends StatefulWidget {
  const DetailScreen({
    super.key,
    required this.name,
    required this.symbol,
    required this.market,
  });

  final String name;
  final String symbol;
  final String market;

  @override
  State<DetailScreen> createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {
  String _period = '1개월';
  @override
  Widget build(BuildContext context) {
    final AppDimens dimens = context.dimens;
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            _appBar(context),
            Expanded(
              child: SingleChildScrollView(
                padding: EdgeInsets.symmetric(horizontal: dimens.space4),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 14),
                    _currentPrice(context),
                    SizedBox(height: dimens.space4),
                    _periodTabs(context),
                    SizedBox(height: dimens.space5),
                    _summaryCard(context),
                    SizedBox(height: dimens.space5),
                    _dailyTable(context),
                    SizedBox(height: dimens.space5),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _appBar(BuildContext context) {
    final AppColors colors = context.colors;
    final AppDimens dimens = context.dimens;

    final String id = 'domestic:${widget.symbol}';
    final favorites = context.watch<FavoritesStore>();
    final bool isFavorite = favorites.isFavorite(id);

    return Container(
      padding: EdgeInsets.symmetric(horizontal: dimens.space4, vertical: 10),
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(
            color: colors.borderSubtle,
            width: dimens.borderHairline,
          ),
        ),
      ),
      child: Row(
        children: [
          GestureDetector(
            behavior: HitTestBehavior.opaque,
            onTap: () => Navigator.pop(context),
            child: AppIcon(
              'ico_back',
              size: dimens.iconMd,
              color: colors.textSecondary,
            ),
          ),
          SizedBox(width: dimens.space3),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  widget.name,
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: AppTypography.medium,
                    color: colors.textPrimary,
                    letterSpacing: -0.1,
                  ),
                ),
                const SizedBox(height: 1),
                Text(
                  '${widget.symbol} · ${widget.market}',
                  style: TextStyle(
                    fontSize: 11,
                    fontWeight: AppTypography.regular,
                    color: colors.textSecondary,
                  ),
                ),
              ],
            ),
          ),
          SizedBox(width: dimens.space3),
          GestureDetector(
            behavior: HitTestBehavior.opaque,
            onTap: () => context.read<FavoritesStore>().toggle(id),
            child: AppIcon(
              isFavorite ? 'ico_star_fill' : 'ico_star',
              size: dimens.iconLg,
              color: isFavorite
                  ? colors.favoriteActive
                  : colors.favoriteInactive,
            ),
          ),
        ],
      ),
    );
  }

  Widget _currentPrice(BuildContext context) {
    final AppColors colors = context.colors;
    final AppDimens dimens = context.dimens;

    return Row(
      crossAxisAlignment: CrossAxisAlignment.baseline,
      textBaseline: TextBaseline.alphabetic,
      children: [
        Text(
          '179,700',
          style: TextStyle(
            fontSize: 30,
            fontWeight: AppTypography.bold,
            color: colors.textPrimary,
            letterSpacing: -0.4,
          ),
        ),
        SizedBox(width: dimens.space2),
        Text(
          '▼ 400 (-0.22%)',
          style: TextStyle(
            fontSize: 15,
            fontWeight: AppTypography.medium,
            color: colors.priceDownText,
            letterSpacing: -0.1,
          ),
        ),
      ],
    );
  }

  Widget _periodTabs(BuildContext context) {
    const List<String> periods = ['1개월', '3개월', '6개월', '1년'];

    return Row(
      children: [
        for (int i = 0; i < periods.length; i++) ...[
          if (i > 0) SizedBox(width: context.dimens.space1),
          Expanded(child: _periodChip(context, periods[i])),
        ],
      ],
    );
  }

  Widget _periodChip(BuildContext context, String label) {
    final AppColors colors = context.colors;
    final AppDimens dimens = context.dimens;
    final bool selected = _period == label;

    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: () => setState(() => _period = label),
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: dimens.space3, vertical: 5),
        decoration: BoxDecoration(
          color: selected ? colors.accentBg : Colors.transparent,
          borderRadius: BorderRadius.circular(dimens.radiusMd),
        ),
        alignment: Alignment.center,
        child: Text(
          label,
          style: TextStyle(
            fontSize: 13,
            fontWeight: AppTypography.regular,
            color: selected ? colors.accentDefault : colors.textSecondary,
          ),
        ),
      ),
    );
  }

  Widget _summaryCard(BuildContext context) {
    final AppDimens dimens = context.dimens;

    return Column(
      children: [
        Row(
          children: [
            Expanded(child: _summaryCell(context, '시가', '172,100')),
            SizedBox(width: dimens.space2),
            Expanded(child: _summaryCell(context, '고가', '181,700')),
            SizedBox(width: dimens.space2),
            Expanded(child: _summaryCell(context, '저가', '172,000')),
          ],
        ),
        SizedBox(height: dimens.space2),
        Row(
          children: [
            Expanded(child: _summaryCell(context, '거래량', '29,113천')),
            SizedBox(width: dimens.space2),
            Expanded(child: _summaryCell(context, '시가총액', '1,063조')),
          ],
        ),
      ],
    );
  }

  Widget _summaryCell(BuildContext context, String label, String value) {
    final AppColors colors = context.colors;
    final AppDimens dimens = context.dimens;

    return Container(
      // 시안의 셀 안쪽 여백 10 / 9는 space 토큰(8 / 12)에 없는 값입니다.
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 9),
      decoration: BoxDecoration(
        color: colors.surfaceSunken,
        borderRadius: BorderRadius.circular(dimens.radiusMd),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            label,
            style: TextStyle(
              fontSize: 11,
              fontWeight: AppTypography.regular,
              color: colors.textSecondary,
            ),
          ),

          const SizedBox(height: 3),
          Text(
            value,
            style: TextStyle(
              fontSize: 15,
              fontWeight: AppTypography.medium,
              color: colors.textPrimary,
              letterSpacing: -0.1,
            ),
          ),
        ],
      ),
    );
  }

  static const List<List<Object>> _mockDaily = <List<Object>>[
    <Object>['03.27', 179700, -400, 29113466],
    <Object>['03.26', 180100, 1200, 32074131],
    <Object>['03.25', 178900, 900, 27441209],
    <Object>['03.24', 178000, 0, 31882540],
    <Object>['03.23', 178000, 0, 29780397],
  ];

  Widget _dailyTable(BuildContext context) {
    final AppColors colors = context.colors;
    final AppDimens dimens = context.dimens;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          '일별 시세',
          style: TextStyle(
            fontSize: 13,
            fontWeight: AppTypography.bold,
            color: colors.textPrimary,
          ),
        ),
        SizedBox(height: dimens.space1),
        _dailyHead(context),
        for (final List<Object> row in _mockDaily)
          _dailyRow(
            context,
            date: row[0] as String,
            close: row[1] as int,
            change: row[2] as int,
            volume: row[3] as int,
          ),
      ],
    );
  }

  Widget _dailyCells(
    BuildContext context, {
    required Widget date,
    required Widget close,
    required Widget change,
    required Widget volume,
  }) {
    final AppDimens dimens = context.dimens;

    return Row(
      children: <Widget>[
        SizedBox(width: 46, child: date),
        SizedBox(width: dimens.space2),
        Expanded(child: close),
        SizedBox(width: dimens.space2),
        Expanded(child: change),
        SizedBox(width: dimens.space2),
        Expanded(child: volume),
      ],
    );
  }

  Widget _dailyHead(BuildContext context) {
    final AppColors colors = context.colors;

    TextStyle style() => TextStyle(
      fontSize: 11,
      fontWeight: AppTypography.regular,
      color: colors.textSecondary,
    );

    return SizedBox(
      // 시안의 표 행 높이는 32로, dimens에 대응 토큰이 없습니다.
      height: 32,
      child: _dailyCells(
        context,
        date: Text('날짜', style: style()),
        close: Text('종가', textAlign: TextAlign.right, style: style()),
        change: Text('등락', textAlign: TextAlign.right, style: style()),
        volume: Text('거래량', textAlign: TextAlign.right, style: style()),
      ),
    );
  }

  Widget _dailyRow(
    BuildContext context, {
    required String date,
    required int close,
    required int change,
    required int volume,
  }) {
    final AppColors colors = context.colors;
    final AppDimens dimens = context.dimens;
    final NumberFormat number = NumberFormat('#,###');

    TextStyle style(Color color) => TextStyle(
      fontSize: 11,
      fontWeight: AppTypography.regular,
      color: color,
    );

    final String changeText =
        '${change > 0 ? '+' : ''}${number.format(change)}';
    final Color changeColor = change > 0
        ? colors.priceUpText
        : change < 0
        ? colors.priceDownText
        : colors.priceFlatText;

    return Container(
      height: 32,
      decoration: BoxDecoration(
        border: Border(
          top: BorderSide(
            color: colors.borderSubtle,
            width: dimens.borderHairline,
          ),
        ),
      ),
      child: _dailyCells(
        context,
        date: Text(date, style: style(colors.textSecondary)),
        close: Text(
          number.format(close),
          textAlign: TextAlign.right,
          style: style(colors.textPrimary),
        ),
        change: Text(
          changeText,
          textAlign: TextAlign.right,
          style: style(changeColor),
        ),
        volume: Text(
          number.format(volume),
          textAlign: TextAlign.right,
          style: style(colors.textSecondary),
        ),
      ),
    );
  }
}
