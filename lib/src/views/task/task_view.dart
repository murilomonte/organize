import 'package:flutter/material.dart';
import 'package:organize/src/_core/widgets/description_button.dart';
import 'package:organize/src/_core/widgets/organize_item_tile.dart';
import 'package:organize/src/_core/widgets/organize_menu_anchor.dart';
import 'package:organize/src/data/database/status_enum.dart';
import 'package:organize/src/models/group_model.dart';
import 'package:organize/src/models/subtask_model.dart';
import 'package:organize/src/models/task_model.dart';
import 'package:organize/src/view_models/group_view_model.dart';
import 'package:organize/src/views/base/base_view.dart';
import 'package:organize/src/views/group/group_form_view.dart';
import 'package:organize/src/views/subtask/subtask_form_view.dart';
import 'package:organize/src/views/subtask/subtask_view.dart';
import 'package:organize/src/views/task/task_form_view.dart';
import 'package:provider/provider.dart';

class TaskView extends StatelessWidget {
  final int id;
  final String title;
  final String? description;
  final Status status;
  final int score;
  final DateTime createdAt;
  final DateTime updatedAt;

  const TaskView({
    super.key,
    required this.id,
    required this.title,
    this.description,
    required this.status,
    required this.createdAt,
    required this.updatedAt,
    required this.score,
  });

  @override
  Widget build(BuildContext context) {
    return BaseView(
      id: id,
      title: title,
      description: description,
      status: status,
      score: score,
      createdAt: createdAt,
      updatedAt: updatedAt,
      dropdownStatus: DropdownMenu(
        width: 160,
        enableSearch: false,
        initialSelection: status,
        dropdownMenuEntries: Status.entries,
        onSelected: (value) {
          context.read<GroupViewModel>().updateTask(id: id, status: value);
        },
      ),
      dropdownMenu: OrganizeMenuAnchor(
        menuChildren: [
          MenuItemButton(
            onPressed: () {
              // Navigator.push(
              //   context,
              //   MaterialPageRoute(
              //     builder: (context) => TaskFormView(
              //       task: TaskModel(
              //         id: id,
              //         score: score,
              //         groupId: id,
              //         title: title,
              //         description: description,
              //         status: status,
              //         createdAt: createdAt,
              //         updatedAt: updatedAt,
              //       ),
              //     ),
              //   ),
              // );
            },
            leadingIcon: Icon(Icons.edit_outlined),
            child: Text('Edit'),
          ),
          MenuItemButton(
            onPressed: () {},
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
                child: DescriptionButton(
                  description: 'There is no subtask yet',
                  buttonText: 'Add',
                  onTap: () {
                    showGeneralDialog(
                      context: context,
                      barrierDismissible: true,
                      barrierLabel: "Close",
                      pageBuilder: (context, animation, secondaryAnimation) {
                        return SubtaskFormView(taskId: id);
                      },
                    );
                  },
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
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => SubtaskView(
                          id: subtaskList[index].id,
                          title: subtaskList[index].title,
                          description: subtaskList[index].description,
                          status: subtaskList[index].status,
                          score: subtaskList[index].score,
                          createdAt: subtaskList[index].createdAt,
                          updatedAt: subtaskList[index].updatedAt,
                        ),
                      ),
                    );
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
}
