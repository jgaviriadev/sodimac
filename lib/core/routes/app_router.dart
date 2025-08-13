import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../features/cart/presentation/pages/cart_page.dart';
import '../../features/products/presentation/bloc/products_bloc.dart';
import '../../features/products/presentation/pages/pages.dart';

class AppRouter {
  AppRouter._();

  static final GoRouter routes = GoRouter(
    initialLocation: "/products",
    routes: <RouteBase>[
      GoRoute(
        name: ProductsPage.routeName,
        path: "/products",
        builder: (BuildContext context, GoRouterState state) {
          return ProductsPage();
        },
        routes: [
          GoRoute(
            name: ProductSearchPage.routeName,
            path: "product-search",
            pageBuilder: (BuildContext context, GoRouterState state) {
              final args = state.extra as Map<String, dynamic>;
              return NoTransitionPage(
                key: state.pageKey,
                child: ProductSearchPage(
                  bloc: args['bloc'] as ProductsBloc,
                  controller: args['controller'] as TextEditingController,
                ),
              );
            },
          ),
          GoRoute(
            name: CartPage.routeName,
            path: "cart",
            builder: (BuildContext context, GoRouterState state) {
              return CartPage();
            },
          ),
        ],
      ),
    ],
  );
}
