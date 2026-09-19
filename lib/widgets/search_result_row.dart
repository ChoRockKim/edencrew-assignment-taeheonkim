import 'package:flutter/material.dart';

import '../theme/theme.dart';
import 'app_icon.dart';

class SearchResultRow extends StatelessWidget {
  const SearchResultRow({
    super.key,
    required this.name,
    required this.symbol,
    required this.market,
    required this.isFavorite,
    required this.query,
    required this.onTapStar,
    required this.onTap,
  });

  final String name;
  final String symbol;
  final String market;
  final bool isFavorite;
  final String query;
  final VoidCallback onTapStar;
  final VoidCallback onTap;

  List<TextSpan> _highlightSpans(BuildContext context) {
    final AppColors colors = context.colors;

    if (query.isEmpty) return [TextSpan(text: name)];

    final int index = name.toLowerCase().indexOf(query.toLowerCase());
    if (index < 0) return [TextSpan(text: name)];

    return [
      TextSpan(text: name.substring(0, index)),
      TextSpan(
        text: name.substring(index, index + query.length),
        style: TextStyle(color: colors.searchHighlight),
      ),
      TextSpan(text: name.substring(index + query.length)),
    ];
  }

  @override
  Widget build(BuildContext context) {
    final AppColors colors = context.colors;
    final AppDimens dimens = context.dimens;

    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: onTap,
      child: Container(
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
                  RichText(
                    text: TextSpan(
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: AppTypography.medium,
                        color: colors.textPrimary,
                        letterSpacing: -0.1,
                      ),
                      children: _highlightSpans(context),
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

            GestureDetector(
              behavior: HitTestBehavior.opaque,
              onTap: onTapStar,
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
      ),
    );
  }
}
