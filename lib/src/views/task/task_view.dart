import 'package:flutter/material.dart';
import 'package:organize/src/_core/widgets/organize_item_tile.dart';
import 'package:organize/src/_core/widgets/organize_menu_anchor.dart';
import 'package:organize/src/data/database/status_enum.dart';
import 'package:organize/src/models/subtask_model.dart';
import 'package:organize/src/models/task_model.dart';
import 'package:organize/src/view_models/group_view_model.dart';
import 'package:organize/src/views/base/base_view.dart';
import 'package:organize/src/views/error/error_view.dart';
import 'package:organize/src/views/subtask/subtask_form_view.dart';
import 'package:organize/src/views/task/task_form_view.dart';
import 'package:provider/provider.dart';

class TaskView extends StatelessWidget {
  final int id;
  const TaskView({super.key, required this.id});

  @override
  Widget build(BuildContext context) {
    return Consumer<GroupViewModel>(
      builder: (context, value, child) {
        List<TaskModel> taskList = value.getTask(id);
        if (taskList.isNotEmpty) {
          TaskModel task = taskList[0];
          return BaseView(
            id: id,
            title: task.title,
            description: task.description,
            status: task.status,
            score: task.score,
            createdAt: task.createdAt,
            updatedAt: task.updatedAt,
            dropdownStatus: DropdownMenu(
              width: 160,
              enableSearch: false,
              initialSelection: task.status,
              dropdownMenuEntries: Status.entries,
              onSelected: (value) {
                context.read<GroupViewModel>().updateTask(
                  id: id,
                  status: value,
                );
              },
            ),
            dropdownMenu: OrganizeMenuAnchor(
              menuChildren: [
                MenuItemButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => TaskFormView(
                          task: TaskModel(
                            id: id,
                            score: task.score,
                            groupId: task.groupId,
                            title: task.title,
                            description: task.description,
                            status: task.status,
                            createdAt: task.createdAt,
                            updatedAt: task.updatedAt,
                          ),
                          groupId: task.groupId,
                        ),
                      ),
                    );
                  },
                  leadingIcon: Icon(Icons.edit_outlined),
                  child: Text('Edit'),
                ),
                MenuItemButton(
                  onPressed: () {
                    showDialog(
                      context: context,
                      builder: (context) {
                        return AlertDialog(
                          title: Text('Delete task?'),
                          content: Text(
                            'This action is irreversible.\nYou will lose all points earned with this task.',
                          ),
                          actions: [
                            TextButton(
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              child: const Text('Cancel'),
                            ),
                            TextButton(
                              onPressed: () {
                                Navigator.pushNamedAndRemoveUntil(
                                  context,
                                  'group',
                                  (route) => route.settings.name == '/',
                                  arguments: task.groupId,
                                );
                                context.read<GroupViewModel>().deleteTask(id);
                              },
                              child: const Text('Delete'),
                            ),
                          ],
                        );
                      },
                    );
                  },
                  leadingIcon: Icon(Icons.delete_outlined),
                  child: Text('Delete'),
                ),
              ],
            ),
            content: Consumer<GroupViewModel>(
              builder: (context, value, child) {
                List<SubtaskModel> subtaskList = value.getSubtaskList(id);
                if (value.errorMsg.isNotEmpty) {
                  return SliverFillRemaining(
                    hasScrollBody: false,
                    child: Center(child: Text(value.errorMsg)),
                  );
                }

                if (value.isLoading) {
                  return SliverFillRemaining(
                    hasScrollBody: false,
                    child: Center(child: CircularProgressIndicator()),
                  );
                }
                if (subtaskList.isEmpty) {
                  return SliverFillRemaining(
                    hasScrollBody: false,
                    child: Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text('There is no task yet'),
                          Text('Add one!'),
                        ],
                      ),
                    ),
                  );
                }

                return SliverPadding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  sliver: SliverList(
                    delegate: SliverChildBuilderDelegate((context, index) {
                      return OrganizeItemTile(
                        id: subtaskList[index].id,
                        title: subtaskList[index].title,
                        description: subtaskList[index].description,
                        status: subtaskList[index].status,
                        onTap: () {
                          Navigator.pushNamed(
                            context,
                            'subtask',
                            arguments: subtaskList[index].id,
                          );
                          // Navigator.push(
                          //   context,
                          //   MaterialPageRoute(
                          //     builder: (context) =>
                          //         SubtaskView(id: subtaskList[index].id),
                          //   ),
                          // );
                        },
                      );
                    }, childCount: subtaskList.length),
                  ),
                );
              },
            ),
            floatingActionButton: FloatingActionButton.extended(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => SubtaskFormView(taskId: id),
                  ),
                );
              },
              label: Text('Add subtask'),
              icon: Icon(Icons.add),
            ),
          );
        }
        return ErrorView(message: "Task doesn't exists.");
      },
    );
  }
}
