import 'package:flutter/material.dart';
import 'package:organize/src/_core/widgets/description_button.dart';
import 'package:organize/src/_core/widgets/organize_item_tile.dart';
import 'package:organize/src/_core/widgets/organize_modal.dart';
import 'package:organize/src/data/database/status_enum.dart';
import 'package:organize/src/models/subtask_model.dart';
import 'package:organize/src/views/subtask/subtask_modal.dart';

class TasksModal extends StatelessWidget {
  final int id;
  final String title;
  final String? description;
  final Status status;
  final DateTime createdAt;
  final DateTime updatedAt;
  final List<SubtaskModel> subtaskList;

  const TasksModal({
    super.key,
    required this.id,
    required this.title,
    this.description,
    required this.status,
    required this.createdAt,
    required this.updatedAt,
    required this.subtaskList,
  });

  @override
  Widget build(BuildContext context) {
    return OrganizeModal(
      children: [
        Text(title, style: TextStyle(fontSize: 30)),
        if (description != null) Text(description!),
        Row(spacing: 20, children: [Text('$createdAt'), Text('$updatedAt')]),
        SizedBox(height: 20),
        if (subtaskList.isEmpty)
          DescriptionButton(
            description: 'There is no subtask yet',
            buttonText: 'Add',
            onTap: () {},
          ),

        if (subtaskList.isNotEmpty)
          Expanded(
            child: ListView.builder(
              itemCount: subtaskList.length,
              itemBuilder: (context, index) {
                return OrganizeItemTile(
                  id: subtaskList[index].id,
                  title: subtaskList[index].title,
                  description: subtaskList[index].description,
                  status: subtaskList[index].status,
                  internalList: [],
                  onTap: () {
                    showGeneralDialog(
                      context: context,
                      fullscreenDialog: false,
                      barrierDismissible: true,
                      barrierLabel: "Close",
                      pageBuilder: (context, animation, secondaryAnimation) {
                        return SubtaskModal(
                          id: subtaskList[index].id,
                          title: subtaskList[index].title,
                          status: subtaskList[index].status,
                          createdAt: subtaskList[index].createdAt,
                          updatedAt: subtaskList[index].updatedAt,
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
