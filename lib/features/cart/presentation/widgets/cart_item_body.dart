import 'package:flutter/material.dart';
import 'package:sodimac/core/core.dart';

import '../../../../core/theme/text_styles.dart';
import '../../domain/entities/entities.dart';
import '../bloc/cart_bloc.dart';
import 'widgets.dart';

class CartItemBody extends StatelessWidget {
  final CartItemEntity item;
  final CartBloc bloc;
  const CartItemBody({super.key, required this.item, required this.bloc});

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ProductThumb(url: item.imageUrl),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                item.description ?? "",
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: TextStyles.regular15(),
              ),
              const SizedBox(height: 6),
              Text(
                item.priceValue ?? "",
                style: TextStyles.bold15(color: AppColor.primaryColor),
              ),
              const SizedBox(height: 10),
              Row(
                children: [
                  QtyButton(
                    icon: Icons.remove,
                    onPressed: () => bloc.add(CartItemDecremented(item.productId)),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 12),
                    child: Text(
                      '${item.qty}',
                      style: TextStyles.bold15(),
                    ),
                  ),
                  QtyButton(
                    icon: Icons.add,
                    onPressed: () => bloc.add(CartItemIncremented(item.productId)),
                  ),
                  const Spacer(),
                ],
              ),
              const SizedBox(height: 8),
              InkWell(
                onTap: () => bloc.add(CartItemRemoveRequested(productId: item.productId)),
                child: Text(
                  'Eliminar',
                  style: TextStyles.regular13(color: Colors.redAccent),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
