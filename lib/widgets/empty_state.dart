import 'package:flutter/material.dart';

import '../theme/theme.dart';
import 'app_icon.dart';

/// 관심 없음 · 검색 전 · 검색 결과 없음 세 화면이 공유하는 빈 상태.
///
/// 시안에서 세 프레임의 구성(아이콘 40 → 제목 → 안내 문구)과 간격이 동일해
/// 하나의 위젯으로 묶었습니다.
class EmptyState extends StatelessWidget {
  const EmptyState({
    super.key,
    required this.icon,
    required this.title,
    required this.message,
  });

  /// assets/icons/ 아래 파일 이름 (확장자 제외)
  final String icon;
  final String title;
  final String message;

  @override
  Widget build(BuildContext context) {
    final AppColors colors = context.colors;
    final AppDimens dimens = context.dimens;

    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // 빈 상태 아이콘은 시안에서 40으로, dimens의 icon 스케일(16/20/22)에
          // 해당하는 값이 없어 직접 지정합니다.
          AppIcon(icon, size: 40, color: colors.textDisabled),
          SizedBox(height: dimens.space3),
          Text(
            title,
            style: TextStyle(
              fontSize: 19,
              fontWeight: AppTypography.bold,
              color: colors.textSecondary,
              letterSpacing: -0.2,
            ),
          ),
          SizedBox(height: dimens.space3),
          Text(
            message,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 11,
              fontWeight: AppTypography.regular,
              color: colors.textTertiary,
            ),
          ),
        ],
      ),
    );
  }
}
