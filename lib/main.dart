import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'core/core.dart';
import 'core/theme/text_styles.dart';
import 'features/cart/presentation/bloc/cart_bloc.dart';
import 'injection_container.dart';

void main() async {
  await injectDependencies();
  runApp(const MyApp());
}

final messengerKey = GlobalKey<ScaffoldMessengerState>();

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final cartBloc = getIt<CartBloc>();
  @override
  void dispose() {
    getIt<AppDatabase>().close();
    super.dispose();
  }

  @override
  void initState() {
    cartBloc.add(const CartStarted());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      scaffoldMessengerKey: messengerKey,
      routerConfig: AppRouter.routes,
      title: 'Flutter Demo Sdimac',
      theme: ThemeData(primarySwatch: Colors.blue),
      builder: (context, child) {
        return BlocListener<CartBloc, CartState>(
          bloc: getIt<CartBloc>(),
          listenWhen: (prev, curr) => prev.actionError != curr.actionError || prev.actionSuccess != curr.actionSuccess,
          listener: (context, state) {
            final msg = state.actionError ?? state.actionSuccess;
            if (msg != null && msg.isNotEmpty) {
              messengerKey.currentState
                ?..clearSnackBars()
                ..showSnackBar(
                  SnackBar(
                    content: Text(
                      msg,
                      style: TextStyles.bold13(color: Colors.white),
                    ),
                  ),
                );
            }
          },
          child: child!,
        );
      },
    );
  }
}
