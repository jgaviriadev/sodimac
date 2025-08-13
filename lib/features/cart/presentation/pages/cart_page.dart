import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/theme/text_styles.dart';
import '../../../../injection_container.dart';
import '../bloc/cart_bloc.dart';
import '../widgets/widgets.dart';

class CartPage extends StatefulWidget {
  static const String routeName = 'cart';
  const CartPage({super.key});

  @override
  State<CartPage> createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  final CartBloc cartBloc = getIt<CartBloc>();

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: cartBloc,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Carrito'),
          actions: [
            BlocSelector<CartBloc, CartState, bool>(
              selector: (state) => state.isClearing,
              builder: (context, isClearing) {
                return IconButton(
                  tooltip: 'Vaciar carrito',
                  icon: isClearing
                      ? const SizedBox(
                          width: 20,
                          height: 20,
                          child: CircularProgressIndicator(strokeWidth: 2),
                        )
                      : const Icon(Icons.delete_outline),
                  onPressed: isClearing ? null : () => cartBloc.add(const CartCleared()),
                );
              },
            ),
          ],
        ),
        body: BlocConsumer<CartBloc, CartState>(
          listenWhen: (prev, curr) => prev.actionError != curr.actionError,
          listener: (context, state) {},
          builder: (context, state) {
            if (state.status == CartStatus.loading) {
              return const Center(child: CircularProgressIndicator());
            }
            if (state.status == CartStatus.failure) {
              return Center(child: Text(state.error ?? 'Error'));
            }
            final items = state.items;
            if (items.isEmpty) {
              return Center(child: Text('Tu carrito está vacío', style: TextStyles.regular15(),));
            }
            return ListView.separated(
              padding: const EdgeInsets.all(16),
              itemCount: items.length + 1,
              separatorBuilder: (context, index) => index == 0
                  ? const SizedBox(height: 8)
                  : Padding(
                      padding: const EdgeInsets.symmetric(vertical: 12),
                      child: Divider(height: 1, color: Colors.grey),
                    ),
              itemBuilder: (context, index) {
                if (index == 0) {
                  return Card(
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                      side: BorderSide(color: Colors.grey),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
                      child: Text(
                        'Artículos (${items.length})',
                        style: TextStyles.regular15(),
                      ),
                    ),
                  );
                }
                final item = items[index - 1];
                return Card(
                  elevation: 0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                    side: BorderSide(color: Theme.of(context).dividerColor),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
                    child: CartItemBody(
                      item: item,
                      bloc: cartBloc,
                    ),
                  ),
                );
              },
            );
          },
        ),
      ),
    );
  }
}
