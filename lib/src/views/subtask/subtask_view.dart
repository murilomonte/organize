import 'package:flutter/material.dart';
import 'package:organize/src/_core/widgets/organize_menu_anchor.dart';
import 'package:organize/src/data/database/status_enum.dart';
import 'package:organize/src/models/subtask_model.dart';
import 'package:organize/src/view_models/group_view_model.dart';
import 'package:organize/src/views/base/base_view.dart';
import 'package:organize/src/views/error/error_view.dart';
import 'package:organize/src/views/subtask/subtask_form_view.dart';
import 'package:provider/provider.dart';

class SubtaskView extends StatelessWidget {
  final int id;
  const SubtaskView({super.key, required this.id});

  @override
  Widget build(BuildContext context) {
    return Consumer<GroupViewModel>(
      builder: (context, value, child) {
        List<SubtaskModel> subtaskList = value.getSubtask(id);
        if (subtaskList.isNotEmpty) {
          SubtaskModel subtask = subtaskList[0];
          return BaseView(
            id: id,
            title: subtask.title,
            description: subtask.description,
            score: subtask.score,
            status: subtask.status,
            createdAt: subtask.createdAt,
            updatedAt: subtask.updatedAt,
            dropdownStatus: DropdownMenu(
              width: 160,
              enableSearch: false,
              initialSelection: subtask.status,
              dropdownMenuEntries: Status.entries,
              onSelected: (value) {
                context.read<GroupViewModel>().updateSubtask(
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
                        builder: (context) => SubtaskFormView(
                          subtask: SubtaskModel(
                            id: id,
                            score: subtask.score,
                            taskId: subtask.taskId,
                            title: subtask.title,
                            description: subtask.description,
                            status: subtask.status,
                            createdAt: subtask.createdAt,
                            updatedAt: subtask.updatedAt,
                          ),
                          taskId: subtask.taskId,
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
                          title: Text('Delete subtask?'),
                          content: Text(
                            'This action is irreversible.\nYou will lose all points earned with this subtask.',
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
                                  'task',
                                  (route) => route.settings.name == '/',
                                  arguments: subtask.taskId,
                                );
                                context.read<GroupViewModel>().deleteSubtask(
                                  id,
                                );
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
            floatingActionButton: FloatingActionButton.extended(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => SubtaskFormView(
                      subtask: SubtaskModel(
                        id: id,
                        score: subtask.score,
                        taskId: subtask.taskId,
                        title: subtask.title,
                        description: subtask.description,
                        status: subtask.status,
                        createdAt: subtask.createdAt,
                        updatedAt: subtask.updatedAt,
                      ),
                      taskId: subtask.taskId,
                    ),
                  ),
                );
              },
              label: Text('Edit subtask'),
              icon: Icon(Icons.edit_outlined, size: 15),
            ),
          );
        }
        return ErrorView(message: "Task doesn't exists.");
      },
    );
  }
}
