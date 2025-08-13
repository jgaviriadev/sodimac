import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import '../../../../core/core.dart';

class ProductThumb extends StatelessWidget {
  final String? url;
  const ProductThumb({super.key, this.url});

  @override
  Widget build(BuildContext context) {
    final placeholder = Container(
      width: 56,
      height: 56,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        color: AppColor.onPrimaryColor.withValues(alpha: 0.02),
      ),
      child: const Icon(Icons.image, size: 20),
    );

    if (url == null || url!.isEmpty) return placeholder;

    return ClipRRect(
      borderRadius: BorderRadius.circular(8),
      child: CachedNetworkImage(
        imageUrl: url!,
        width: 56,
        height: 56,
        fit: BoxFit.cover,
        placeholder: (_, __) => placeholder,
        errorWidget: (_, __, ___) => placeholder,
        fadeInDuration: const Duration(milliseconds: 200),
        memCacheWidth: 112,
        memCacheHeight: 112,
      ),
    );
  }
}