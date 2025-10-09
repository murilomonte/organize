import 'package:flutter/material.dart';
import 'package:organize/src/_core/widgets/organize_app_bar.dart';
import 'package:organize/src/utility/constraints.dart';

class OrganizeModal extends StatelessWidget {
  final List<Widget> children;
  final double? maxWidth;
  final double? maxHeight;

  // Appbar
  final String? title;
  final List<Widget>? actions;

  // BottomBar
  final Widget? bottomBar;

  const OrganizeModal({
    super.key,
    required this.children,
    this.maxWidth,
    this.maxHeight,
    this.title,
    this.actions, this.bottomBar,
  });

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        if (constraints.maxWidth < mobileMaxWidth) {
          return Material(
            child: Column(
              children: [
                OrganizeAppBar(title: title, actions: actions),
                Expanded(
                  child: SizedBox(
                    width: double.infinity,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: children,
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(10),
                  child: bottomBar
                ),
              ],
            ),
          );
        } else {
          return Dialog(
            backgroundColor: Theme.of(context).colorScheme.surface,
            child: ConstrainedBox(
              constraints: BoxConstraints(
                maxWidth: maxWidth ?? 800,
                maxHeight: maxHeight ?? double.infinity,
              ),
              child: Column(
                children: [
                  OrganizeAppBar(title: title, actions: actions),
                  Expanded(
                    child: SizedBox(
                      width: double.infinity,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: children,
                        ),
                      ),
                    ),
                  ),
                  Padding(
                  padding: const EdgeInsets.all(10),
                  child: bottomBar
                ),
                ],
              ),
            ),
          );
        }
      },
    );
  }
}
