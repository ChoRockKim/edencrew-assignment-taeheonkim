import 'package:flutter/material.dart';

import 'theme/theme.dart';
import 'widgets/app_icon.dart';

class SearchScreen extends StatelessWidget {
  const SearchScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            _searchBar(context),
            const Expanded(child: Center(child: Text('검색 결과'))),
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
            AppIcon('ico_x', size: dimens.iconSm, color: colors.textTertiary),
          ],
        ),
      ),
    );
  }
}
