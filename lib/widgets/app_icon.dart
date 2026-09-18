import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

/// Figma 시안에서 내려받은 SVG 아이콘을 그립니다.
///
/// SVG 파일에는 색이 박혀 있어서, [color]로 덮어쓰기 위해
/// [ColorFilter]를 씌웁니다.
class AppIcon extends StatelessWidget {
  const AppIcon(
    this.name, {
    super.key,
    required this.size,
    required this.color,
  });

  /// assets/icons/ 아래 파일 이름 (확장자 제외)
  final String name;
  final double size;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: size,
      height: size,
      child: SvgPicture.asset(
        'assets/icons/$name.svg',
        fit: BoxFit.contain,
        colorFilter: ColorFilter.mode(color, BlendMode.srcIn),
      ),
    );
  }
}
