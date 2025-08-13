import 'package:flutter/material.dart';

import '../../../../core/theme/text_styles.dart';

class EmptyHint extends StatelessWidget {
  final String text;
  const EmptyHint({super.key, required this.text});
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Text(text, style: TextStyles.regular15()),
      ),
    );
  }
}