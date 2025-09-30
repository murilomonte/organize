import 'package:flutter/material.dart';
import 'package:organize/src/_core/widgets/description_button.dart';
import 'package:organize/src/_core/widgets/organize_item_tile.dart';
import 'package:organize/src/_core/widgets/organize_modal.dart';
import 'package:organize/src/data/database/status_enum.dart';
import 'package:organize/src/models/task_model.dart';
import 'package:organize/src/views/task/task_modal.dart';

class GroupModal extends StatelessWidget {
  final int id;
  final String title;
  final String? description;
  final Status status;
  final DateTime createdAt;
  final DateTime updatedAt;
  final List<TaskModel> taskList;

  const GroupModal({
    super.key,
    required this.id,
    required this.title,
    this.description,
    required this.status,
    required this.createdAt,
    required this.updatedAt,
    required this.taskList,
  });

  @override
  Widget build(BuildContext context) {
    return OrganizeModal(
      children: [
        Text(title, style: TextStyle(fontSize: 30)),
        if (description != null) Text(description!),
        Row(spacing: 20, children: [Text('$createdAt'), Text('$updatedAt')]),
        SizedBox(height: 20),
        if (taskList.isEmpty)
          DescriptionButton(
            description: 'There is no task yet',
            buttonText: 'Add',
            onTap: () {},
          ),

        if (taskList.isNotEmpty)
          Expanded(
            child: ListView.builder(
              itemCount: taskList.length,
              itemBuilder: (context, index) {
                return OrganizeItemTile(
                  id: taskList[index].id,
                  title: taskList[index].title,
                  description: taskList[index].description,
                  status: taskList[index].status,
                  internalList: taskList[index].subtasks,
                  onTap: () {
                    showGeneralDialog(
                      context: context,
                      fullscreenDialog: false,
                      barrierDismissible: true,
                      barrierLabel: "Close",
                      pageBuilder: (context, animation, secondaryAnimation) {
                        return TasksModal(
                          id: taskList[index].id,
                          title: taskList[index].title,
                          description: taskList[index].description,
                          status: taskList[index].status,
                          subtaskList: taskList[index].subtasks,
                          createdAt: taskList[index].createdAt,
                          updatedAt: taskList[index].updatedAt,
                        );
                      },
                    );
                  },
                );
              },
            ),
          ),
      ],
    );
  }
}
