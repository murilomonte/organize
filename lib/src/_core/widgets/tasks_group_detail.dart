import 'package:flutter/material.dart';
import 'package:organize/src/_core/widgets/organize_app_bar.dart';
import 'package:organize/src/utility/constraints.dart';

class TasksGroupDetail extends StatelessWidget {
  final String title;
  final String? description;
  final List taskList;
  const TasksGroupDetail({
    super.key,
    required this.title,
    required this.taskList,
    required this.description,
  });

  @override
  Widget build(BuildContext context) {
    if (isMobileLayout(context)) {
      return Material(
        child: Column(
          children: [
            OrganizeAppBar(),
            Expanded(
              child: SizedBox(
                width: double.infinity,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(title, style: TextStyle(fontSize: 30)),
                      if (description != null)
                      Text(description!)
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      );
    } else {
      return Dialog(
        backgroundColor: Theme.of(context).colorScheme.surface,
        child: ConstrainedBox(
          constraints: BoxConstraints(maxWidth: 800),
          child: Column(
            children: [
              OrganizeAppBar(),
              Expanded(
                child: SizedBox(
                  width: double.infinity,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [Text(title, style: TextStyle(fontSize: 30))],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      );
    }
  }
}
