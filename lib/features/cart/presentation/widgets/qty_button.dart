import 'package:flutter/material.dart';
import 'package:sodimac/core/theme/app_color.dart';

class QtyButton extends StatelessWidget {
  final IconData icon;
  final VoidCallback onPressed;
  const QtyButton({super.key, required this.icon, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return Material(
      color: AppColor.primaryColor.withValues(alpha: 0.08),
      shape: const CircleBorder(),
      child: InkWell(
        customBorder: const CircleBorder(),
        onTap: onPressed,
        child: SizedBox(
          width: 36,
          height: 36,
          child: Icon(icon, size: 20, color: AppColor.primaryColor),
        ),
      ),
    );
  }
}