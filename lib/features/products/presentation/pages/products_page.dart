import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/theme/text_styles.dart';
import '../../../../injection_container.dart';
import '../../../cart/presentation/pages/cart_page.dart';
import '../bloc/products_bloc.dart';
import '../bloc/products_state.dart';
import '../widgets/widgets.dart';
import 'product_search_page.dart';

class ProductsPage extends StatefulWidget {
  static const String routeName = "products";
  const ProductsPage({super.key});

  @override
  State<ProductsPage> createState() => _ProductsPageState();
}

class _ProductsPageState extends State<ProductsPage> {
  static const double padding = 16;
  final TextEditingController controller = TextEditingController();
  final ProductsBloc authBloc = getIt<ProductsBloc>();

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: authBloc,
      child: Builder(
        builder: (context) {
          return Scaffold(
            appBar: CustomAppBar(
              address: '123 Main St, Springfield',
              controller: controller,
              onSearchTap: () {
                context.pushNamed(
                  ProductSearchPage.routeName,
                  extra: {
                    "bloc": authBloc,
                    "controller": controller,
                  },
                );
              },
              onCart: () {
                context.pushNamed(CartPage.routeName);
              },
            ),
            body: Padding(
              padding: const EdgeInsets.only(
                right: padding,
                left: padding,
                top: padding,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  BlocSelector<ProductsBloc, ProductsState, int>(
                    selector: (s) => s.totalCount,
                    builder: (_, total) {
                      if (total == 0) return const SizedBox.shrink();
                      return Text(
                        "Productos $total",
                        style: TextStyles.bold13(),
                      );
                    },
                  ),
                  const SizedBox(height: 12),
                  Expanded(
                    child: ProductsGrid(
                      bloc: authBloc,
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
