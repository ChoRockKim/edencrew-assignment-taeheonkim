import 'package:edencrew_assignment_starter/theme/app_theme.dart';
import 'package:edencrew_assignment_starter/theme/app_typography.dart';
import 'package:edencrew_assignment_starter/widgets/app_icon.dart';
import 'package:flutter/material.dart';

class SearchResultRow extends StatelessWidget {
  const SearchResultRow({
    super.key,
    required this.name,
    required this.symbol,
    required this.market,
    required this.isFavorite,
    required this.query,
  });

  final String name;
  final String symbol;
  final String market;
  final bool isFavorite;
  final String query;

  List<TextSpan> _highlightSpans(BuildContext context) {
    if (query.isEmpty) return [TextSpan(text: name)];

    final int index = name.toLowerCase().indexOf(query.toLowerCase());
    if (index < 0) return [TextSpan(text: name)];

    return [
      TextSpan(text: name.substring(0, index)),
      TextSpan(
        text: name.substring(index, index + query.length),
        style: TextStyle(color: context.colors.searchHighlight),
      ),
      TextSpan(text: name.substring(index + query.length)),
    ];
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
                RichText(
                  text: TextSpan(
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: AppTypography.medium,
                      color: context.colors.textPrimary,
                      letterSpacing: -0.1,
                    ),
                    children: _highlightSpans(context),
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

          AppIcon(
            isFavorite ? 'ico_star_fill' : 'ico_star',
            size: context.dimens.iconLg,
            color: isFavorite
                ? context.colors.favoriteActive
                : context.colors.favoriteInactive,
          ),
        ],
      ),
    );
  }
}
