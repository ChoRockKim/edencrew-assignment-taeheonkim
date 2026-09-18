import 'package:edencrew_assignment_starter/theme/app_theme.dart';
import 'package:edencrew_assignment_starter/theme/app_typography.dart';
import 'package:flutter/material.dart';

import 'widgets/app_icon.dart';

class WatchlistScreen extends StatelessWidget {
  const WatchlistScreen({super.key});

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
            const Expanded(child: Center(child: Text('관심 종목'))),
          ],
        ),
      ),
    );
  }
}
