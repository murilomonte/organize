import 'package:flutter/material.dart';

class OrganizeAppBar extends StatelessWidget {
  final String? title;
  final List<Widget>? actions;
  
  const OrganizeAppBar({super.key, this.title, this.actions});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SizedBox(
        height: kToolbarHeight,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            spacing: 10,
            children: [
              Row(
                children: [
                  IconButton(
                    icon: Icon(
                      Icons.arrow_back,
                      color: Theme.of(context).colorScheme.onSurface,
                    ),
                    onPressed: () => Navigator.of(context).pop(),
                  ),
                  if (title != null)
                    Text(
                      title!,
                      style: TextStyle(
                        color: Theme.of(context).colorScheme.onSurface,
                        fontSize: 18,
                      ),
                    ),
                ],
              ),
              if (actions != null) Row(
                spacing: 10,
                children: actions!),
            ],
          ),
        ),
      ),
    );
  }
}
