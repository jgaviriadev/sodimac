import 'dart:async';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/theme/text_styles.dart';
import '../bloc/products_bloc.dart';
import '../widgets/widgets.dart';

class ProductSearchPage extends StatefulWidget {
  static const String routeName = "product-search";

  final TextEditingController controller;
  final ProductsBloc bloc;

  const ProductSearchPage({
    super.key,
    required this.controller,
    required this.bloc
  });

  @override
  State<ProductSearchPage> createState() => _ProductSearchPageState();
}

class _ProductSearchPageState extends State<ProductSearchPage> {
  final FocusNode _focusNode = FocusNode();
  
  static const List<String> _allSuggestions = <String>[
    'Taladros',
    'Humedad',
    'Cascos',
    'botas de seguridad',
    'tornillos',
  ];

  final List<String> _recent = <String>[
    
  ];

  List<String> _results = <String>[];
  bool _loading = false;
  Timer? _debounce;

  @override
  void initState() { 
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      FocusScope.of(context).requestFocus(_focusNode);
      _search(widget.controller.text);
    });
    widget.controller.addListener(_onQueryChanged);
  }

   void _onQueryChanged() {
    final query = widget.controller.text;
    _debounce?.cancel();
    _debounce = Timer(const Duration(milliseconds: 250), () {
      _search(query);
    });
  }

  Future<void> _search(String query) async {
    if (!mounted) return;
    if (query.trim().isEmpty) {
      setState(() {
        _results = <String>[];
        _loading = false;
      });
      return;
    }

    setState(() => _loading = true);

    await Future.delayed(const Duration(milliseconds: 300));

    final q = query.toLowerCase();
    final filtered = _allSuggestions
        .where((s) => s.toLowerCase().contains(q))
        .toList();

    if (!mounted) return;
    setState(() {
      _results = filtered;
      _loading = false;
    });
  }

  void _submit(String value) {
    final cleaned = value.trim().toLowerCase();
    if (cleaned .isEmpty) return;
    setState(() {
      _recent.removeWhere((e) => e.toLowerCase() == cleaned );
      _recent.insert(0, cleaned );
    });
    widget.controller.text = cleaned;
    widget.bloc.add(QuerySubmitted(cleaned ));
    context.pop();
  }

   void _removeRecent(int index) {
    setState(() => _recent.removeAt(index));
  }

  void _clearAllRecents() {
    setState(() => _recent.clear());
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        onBack: () => context.pop(),
        controller: widget.controller,
        focusNode: _focusNode,
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (widget.controller.text.isEmpty) ...[
            SectionHeader(
              title: 'Búsquedas recientes',
              trailing: _recent.isNotEmpty
                  ? TextButton(
                      onPressed: _clearAllRecents,
                      child: Text('Borrar todo', style: TextStyles.regular15(),),
                    )
                  : null,
            ),
            Expanded(
              child: _recent.isEmpty
                  ? const EmptyHint(text: 'No hay búsquedas recientes')
                  : ListView.separated(
                      itemCount: _recent.length,
                      separatorBuilder: (_, __) => const Divider(height: 1),
                      itemBuilder: (context, i) {
                        final term = _recent[i];
                        return ListTile(
                          leading: const Icon(Icons.history),
                          title: Text(term, style: TextStyles.regular15(),),
                          onTap: () {
                            widget.controller.text = term;
                            widget.controller.selection = TextSelection.fromPosition(
                              TextPosition(offset: term.length),
                            );
                            _submit(term);
                          },
                          trailing: IconButton(
                            icon: const Icon(Icons.close),
                            onPressed: () => _removeRecent(i),
                          ),
                        );
                      },
                    ),
            ),
          ] else ...[
            SectionHeader(title: 'Sugerencias'),
            if (_loading)
              const LinearProgressIndicator(minHeight: 2),
            Expanded(
              child: _results.isEmpty && !_loading
                  ? const EmptyHint(text: 'Sin resultados')
                  : ListView.separated(
                      itemCount: _results.length,
                      separatorBuilder: (_, __) => const Divider(height: 1),
                      itemBuilder: (context, i) {
                        final s = _results[i];
                        return ListTile(
                          leading: const Icon(Icons.search),
                          title: Text(s, style: TextStyles.regular15(),),
                          onTap: () {
                            widget.controller.text = s;
                            widget.controller.selection = TextSelection.fromPosition(
                              TextPosition(offset: s.length),
                            );
                            _submit(s);
                          },
                        );
                      },
                    ),
            ),
          ],
        ],
      )
    );
  }
  @override
  void dispose() {
    _focusNode.dispose();
    super.dispose();
  }
}