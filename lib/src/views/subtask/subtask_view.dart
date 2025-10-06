import 'package:flutter/material.dart';
import 'package:organize/src/data/database/status_enum.dart';
import 'package:organize/src/views/base/base_view.dart';

class SubtaskView extends StatelessWidget {
  final int id;
  final String title;
  final String? description;
  final Status status;
  final int? score;
  final DateTime createdAt;
  final DateTime updatedAt;

  const SubtaskView({
    super.key,
    required this.id,
    required this.title,
    this.description,
    required this.status,
    this.score,
    required this.createdAt,
    required this.updatedAt,
  });

  @override
  Widget build(BuildContext context) {
    return BaseView(
      id: id,
      title: title,
      description: description,
      score: score,
      status: status,
      createdAt: createdAt,
      updatedAt: updatedAt,
      dropdownStatus: DropdownMenu(
        width: 160,
        enableSearch: false,
        initialSelection: status,
        dropdownMenuEntries: Status.entries,
        onSelected: (value) {},
      ),
      dropdownMenu: IconButton(onPressed: () {}, icon: Icon(Icons.menu)),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => Scaffold(
                appBar: AppBar(),
                body: Center(child: Text('Form')),
              ),
            ),
          );
        },
        label: Text('Edit subtask'),
        icon: Icon(Icons.edit_outlined, size: 15),
      ),
    );
  }
}
