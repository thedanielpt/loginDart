import 'package:flutter/material.dart';
import '../../theme/app_colors.dart';

class AppBackground extends StatelessWidget {
  final String asset;
  final Widget child;

  const AppBackground({
    super.key,
    required this.asset,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Positioned.fill(
          child: Image.asset(asset, fit: BoxFit.cover),
        ),
        Positioned.fill(
          child: Container(color: AppColors.overlayBlack),
        ),
        child,
      ],
    );
  }
}
