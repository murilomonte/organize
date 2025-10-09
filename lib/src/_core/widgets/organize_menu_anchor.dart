
import 'package:flutter/material.dart';

class OrganizeMenuAnchor extends StatelessWidget {
  final List<MenuItemButton> menuChildren;

  const OrganizeMenuAnchor({super.key, required this.menuChildren});

  @override
  Widget build(BuildContext context) {
    return MenuAnchor(
      style: MenuStyle(
        padding: WidgetStatePropertyAll(EdgeInsets.symmetric(vertical: 10)),
        visualDensity: VisualDensity(horizontal: .5),
      ),
      menuChildren: menuChildren,
      builder: (context, controller, child) {
        return IconButton(
          onPressed: () {
            if (controller.isOpen) {
              controller.close();
            } else {
              controller.open();
            }
          },
          icon: Icon(Icons.more_vert),
        );
      },
    );
  }
}
