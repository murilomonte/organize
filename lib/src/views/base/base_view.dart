import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:organize/src/_core/widgets/gap.dart';
import 'package:organize/src/data/database/status_enum.dart';

class BaseView extends StatelessWidget {
  final int id;
  final String title;
  final String? description;
  final Status status;
  final int? score;
  final DateTime createdAt;
  final DateTime updatedAt;

  final Widget dropdownStatus;
  final Widget dropdownMenu;
  final Widget? content;
  final Widget? floatingActionButton;

  const BaseView({
    super.key,
    required this.id,
    required this.title,
    this.description,
    required this.status,
    this.score,
    required this.createdAt,
    required this.updatedAt,
    required this.dropdownStatus,
    required this.dropdownMenu,
    this.content,
    this.floatingActionButton,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            floating: true,
            actionsPadding: EdgeInsets.all(10),
            actions: [
              if (score != null)
                Container(
                  padding: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                  decoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.primaryContainer,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Tooltip(
                    message: 'Points',
                    child: Row(
                      spacing: 2,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.diamond_outlined, size: 15),
                        Text(score!.toString(), style: TextStyle(fontSize: 13)),
                        Text('pts'),
                      ],
                    ),
                  ),
                ),
              Gap(10),
              dropdownMenu,
            ],
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: EdgeInsetsGeometry.symmetric(horizontal: 15),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(title, style: TextStyle(fontSize: 50, height: 1)),
                  Gap(5),
                  if (description != null && description != '')
                    Text(description!, style: TextStyle(fontSize: 16)),
                  if (description != null && description != '') Gap(10),
                  Text(
                    DateFormat("dd/MM/yyyy - HH:mm").format(createdAt),
                    style: TextStyle(
                      color: Theme.of(context).colorScheme.secondary,
                    ),
                  ),
                  Gap(10),
                  dropdownStatus,
                  Gap(20),
                ],
              ),
            ),
          ),
          if (content != null) content!,
        ],
      ),
      floatingActionButton: floatingActionButton,
    );
  }
}
