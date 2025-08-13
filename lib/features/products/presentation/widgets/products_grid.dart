import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/theme/text_styles.dart';
import '../../../../injection_container.dart';
import '../../../cart/domain/entities/entities.dart';
import '../../../cart/presentation/bloc/cart_bloc.dart';
import '../bloc/products_bloc.dart';
import '../bloc/products_state.dart';
import 'widgets.dart';

class ProductsGrid extends StatefulWidget {
  final ProductsBloc bloc;
  const ProductsGrid({super.key, required this.bloc});

  @override
  State<ProductsGrid> createState() => _ProductsGridState();
}

class _ProductsGridState extends State<ProductsGrid> {
  final _scrollController = ScrollController();
  final CartBloc cartBloc = getIt<CartBloc>();

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
  }

  void _onScroll() {
    final pos = _scrollController.position;
    if (pos.extentAfter < 400) {
      widget.bloc.add(NextPageRequested());
    }
  }

  @override
  Widget build(BuildContext context) {
    const spacing = 16.0;
    return BlocBuilder<ProductsBloc, ProductsState>(
      builder: (_, state) {
        if (state.isIdle) {
          return Center(
            child: Text("Escribe algo en la búsqueda ↑", style: TextStyles.regular15(),),
          );
        }
        if (state.isLoadingFirstPage) {
          return const Center(child: CircularProgressIndicator(strokeWidth: 2));
        }
        if (state.isFailure && state.items.isEmpty) {
          return Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(state.error ?? "", style: TextStyles.regular15(),),
                const SizedBox(height: 8),
                OutlinedButton(
                  onPressed: () => widget.bloc.add(Refreshed()),
                  child: Text("Reintentar", style: TextStyles.regular15(),),
                ),
              ],
            ),
          );
        }
        final extra = (state.isLoadingMore || state.hasMore || state.error != null) ? 1 : 0;
        final count = state.items.length + extra;

        return RefreshIndicator(
          onRefresh: () async => widget.bloc.add(Refreshed()),
          child: GridView.builder(
            controller: _scrollController,
            padding: const EdgeInsets.only(bottom: 12),
            itemCount: count,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: spacing,
              mainAxisSpacing: spacing,
              mainAxisExtent: 240,
            ),
            itemBuilder: (_, i) {
              if (i >= state.items.length) {
                if (state.error != null && state.items.isNotEmpty && !state.isLoadingMore) {
                  return Center(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Icon(Icons.error_outline, color: Colors.redAccent),
                        const SizedBox(height: 6),
                        Text(state.error!, textAlign: TextAlign.center, style: TextStyles.regular15(),),
                        const SizedBox(height: 6),
                        OutlinedButton(
                          onPressed: () => widget.bloc.add(NextPageRequested()),
                          child: Text("Reintentar", style: TextStyles.regular15(),),
                        ),
                      ],
                    ),
                  );
                }
                return const Center(child: CircularProgressIndicator(strokeWidth: 2));
              }

              final p = state.items[i];
              return ProductCard(
                key: PageStorageKey('card_$i'),
                images: p.images!,
                desc: p.desc!,
                price: p.price?.price ?? "",
                rating: p.rating ?? "",
                onAdd: () {
                  cartBloc.add(
                    CartItemAddRequested(
                      item: CartItemEntity(
                        productId: p.productId ?? "",
                        description: p.desc ?? "",
                        imageUrl: p.images!.first,
                        priceValue: p.price?.price ?? "",
                        priceCurrency: p.price?.symbol ??""
                      ),
                    ),
                  );
                },
              );
            },
          ),
        );
      },
    );
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }
}