import 'package:edencrew_assignment_starter/favorites_store.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'theme/theme.dart';
import 'widgets/app_icon.dart';

class DetailScreen extends StatelessWidget {
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
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            _appBar(context),
            const Expanded(child: Center(child: Text('본문'))),
          ],
        ),
      ),
    );
  }

  Widget _appBar(BuildContext context) {
    final AppColors colors = context.colors;
    final AppDimens dimens = context.dimens;

    final String id = 'domestic:$symbol';
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
                  name,
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: AppTypography.medium,
                    color: colors.textPrimary,
                    letterSpacing: -0.1,
                  ),
                ),
                const SizedBox(height: 1),
                Text(
                  '$symbol · $market',
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
}
