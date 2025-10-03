import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:organize/src/_core/widgets/description_button.dart';
import 'package:organize/src/_core/widgets/gap.dart';
import 'package:organize/src/_core/widgets/organize_item_tile.dart';
import 'package:organize/src/data/database/status_enum.dart';
import 'package:organize/src/models/task_model.dart';
import 'package:organize/src/view_models/group_view_model.dart';
import 'package:organize/src/views/task/create_task_modal.dart';
import 'package:organize/src/views/task/task_view.dart';
import 'package:provider/provider.dart';

class GroupView extends StatelessWidget {
  final int id;
  final String title;
  final String? description;
  final Status status;
  final DateTime createdAt;
  final DateTime updatedAt;

  const GroupView({
    super.key,
    required this.id,
    required this.title,
    this.description,
    required this.status,
    required this.createdAt,
    required this.updatedAt,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Group'),
        titleSpacing: 0,
        actions: [
          TextButton.icon(
            onPressed: () {
              showGeneralDialog(
                context: context,
                fullscreenDialog: false,
                barrierDismissible: true,
                barrierLabel: "Close",
                pageBuilder: (context, animation, secondaryAnimation) {
                  return CreateTaskModal(groupId: id);
                },
              );
            },
            label: Text('Add task'),
            icon: Icon(Icons.add),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(title, style: TextStyle(fontSize: 50)),
            Gap(5),
            if (description != null)
              Text(description!, style: TextStyle(fontSize: 16)),
            if (description != null) Gap(10),
            Text(
              DateFormat("dd/MM/yyyy - HH:mm").format(createdAt),
              style: TextStyle(color: Theme.of(context).colorScheme.secondary),
            ),
            Gap(10),
            DropdownMenu(
              // TODO: separar em um widget
              width: 160,
              enableSearch: false,
              initialSelection: status,
              dropdownMenuEntries: Status.entries,
              onSelected: (value) {
                // Metodo para mudar somente o status
              },
            ),
            Gap(20),
            Consumer<GroupViewModel>(
              builder: (context, value, child) {
                List<TaskModel> taskList = value.getTaskList(id);

                if (taskList.isEmpty) {
                  return DescriptionButton(
                    description: 'There is no task yet',
                    buttonText: 'Add',
                    onTap: () {
                      showGeneralDialog(
                        context: context,
                        fullscreenDialog: false,
                        barrierDismissible: true,
                        barrierLabel: "Close",
                        pageBuilder: (context, animation, secondaryAnimation) {
                          return CreateTaskModal(groupId: id);
                        },
                      );
                    },
                  );
                }

                return Expanded(
                  child: ListView.builder(
                    itemCount: taskList.length,
                    itemBuilder: (context, index) {
                      return OrganizeItemTile(
                        id: taskList[index].id,
                        title: taskList[index].title,
                        description: taskList[index].description,
                        status: taskList[index].status,
                        onTap: () {
                          print(taskList[index].description);
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => TaskView(
                                id: taskList[index].id,
                                title: taskList[index].title,
                                description: taskList[index].description,
                                status: taskList[index].status,
                                createdAt: taskList[index].createdAt,
                                updatedAt: taskList[index].updatedAt,
                              ),
                            ),
                          );
                        },
                      );
                    },
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
