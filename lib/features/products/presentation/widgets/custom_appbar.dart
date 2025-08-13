import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../../../core/core.dart';
import '../../../../core/theme/text_styles.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String? address;
  final VoidCallback? onBack;
  final VoidCallback? onCart;
  final TextEditingController controller;
  final double height;
  final FocusNode? focusNode;
  final void Function()? onSearchTap;

  const CustomAppBar({
    super.key,
    this.address,
    required this.controller,
    this.onBack,
    this.onCart,
    this.height = 150,
    this.focusNode,
    this.onSearchTap
  });

  @override
  Size get preferredSize => Size.fromHeight(height);

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle.light,
      child: Material(
        color: Colors.transparent,
        child: Container(
          height: preferredSize.height,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                AppColor.primaryColor,
                AppColor.onPrimaryColor,
              ],
            ),
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(22),
              bottomRight: Radius.circular(22),
            ),
          ),
          child: SafeArea(
            bottom: false,
            child: Padding(
              padding: const EdgeInsets.fromLTRB(8, 6, 8, 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      if (onBack != null)
                        IconButton(
                          onPressed: onBack,
                          icon: const Icon(
                            Icons.arrow_back,
                            color: Colors.white,
                          ),
                        ),
                      Expanded(
                        child: Container(
                          height: 46,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(16),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withValues(alpha: 0.08),
                                blurRadius: 10,
                                offset: const Offset(0, 4),
                              ),
                            ],
                          ),
                          child: Row(
                            children: [
                              const SizedBox(width: 10),
                              const Icon(
                                Icons.search,
                                color: Color(0xFF6F6F6F),
                              ),
                              const SizedBox(width: 6),
                              Expanded(
                                child: TextField(
                                  controller: controller,
                                  decoration: const InputDecoration(
                                    hintText: 'Buscar producto',
                                    border: InputBorder.none,
                                  ),
                                  style: TextStyles.regular15(),
                                  textInputAction: TextInputAction.search,
                                  readOnly: focusNode == null ? true : false,
                                  focusNode: focusNode,
                                  onTap: () {
                                    if (focusNode == null && onSearchTap != null) {
                                      onSearchTap!();
                                    }
                                  },
                                ),
                              ),
                              const SizedBox(width: 10),
                            ],
                          ),
                        ),
                      ),
                      onCart != null ? IconButton(
                        onPressed: onCart,
                        icon: const Icon(
                          Icons.shopping_cart_outlined,
                          color: Colors.white,
                        ),
                      ) : SizedBox(width: 24,),
                    ],
                  ),
                  if (address != null && address!.isNotEmpty)
                    Padding(
                      padding: const EdgeInsets.only(top: 8),
                      child: Row(
                        children: [
                          const SizedBox(width: 8),
                          const Icon(
                            Icons.location_on_outlined,
                            color: Colors.white,
                          ),
                          const SizedBox(width: 8),
                          Expanded(
                            child: Text(
                              address!,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyles.regular15(color: Colors.white),
                            ),
                          ),
                        ],
                      ),
                    ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
