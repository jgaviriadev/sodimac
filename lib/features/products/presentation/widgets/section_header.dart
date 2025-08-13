import 'package:flutter/material.dart';

import '../../../../core/theme/text_styles.dart';

class SectionHeader extends StatelessWidget {
  final String title;
  final Widget? trailing;
  const SectionHeader({super.key, required this.title, this.trailing});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 12, 8, 8),
      child: Row(
        children: [
          Expanded(
            child: Text(
              title,
              style: TextStyles.regular15(),
            ),
          ),
          if (trailing != null) trailing!,
        ],
      ),
    );
  }
}