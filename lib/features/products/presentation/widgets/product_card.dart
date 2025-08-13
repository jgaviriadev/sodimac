import 'package:flutter/material.dart';

import '../../../../core/core.dart';
import '../../../../core/theme/text_styles.dart';
import 'widgets.dart';

class ProductCard extends StatelessWidget {
  final String desc;
  final List<String> images;
  final String price;
  final String rating;
  final bool isFavorite;
  final VoidCallback? onAdd;

  const ProductCard({
    super.key,
    required this.desc,
    required this.images,
    required this.price,
    required this.rating,
    this.isFavorite = false,
    this.onAdd,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: const Color(0xFFF8FAFC),
        borderRadius: BorderRadius.circular(18),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.06),
            blurRadius: 14,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      clipBehavior: Clip.antiAlias,
      child: Stack(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 12),
              ImageCarousel(images: images),
              const SizedBox(height: 12),
              Padding(
                padding: const EdgeInsets.all(8),
                child: Column(
                  children: [
                    Text(
                      desc,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyles.regular11()
                    ),
                    const SizedBox(height: 12),
                    Row(
                      children: [
                        Text(
                          "\$ $price",
                          style: TextStyles.bold15(color: AppColor.primaryColor)
                        ),
                        const Spacer(),
                        ElevatedButton(
                          onPressed: onAdd,
                          style: ElevatedButton.styleFrom(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 18,
                              vertical: 10,
                            ),
                            elevation: 0,
                            backgroundColor: const Color(0xFFE7F3FF),
                            foregroundColor: Colors.black87,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(22),
                            ),
                          ),
                          child: const Icon(Icons.shopping_cart_outlined),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
          if(rating.isNotEmpty) Positioned(
            top: 0,
            left: 16,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [AppColor.primaryColor, AppColor.onPrimaryColor],
                ),
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(8),
                  bottomRight: Radius.circular(8),
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.20),
                    blurRadius: 8,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: Text(
                "★ ${oneDecimal(rating)}",
                style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
