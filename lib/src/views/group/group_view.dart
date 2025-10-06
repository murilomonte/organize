import 'package:flutter/material.dart';
import 'package:organize/src/_core/widgets/description_button.dart';
import 'package:organize/src/_core/widgets/organize_item_tile.dart';
import 'package:organize/src/_core/widgets/organize_menu_anchor.dart';
import 'package:organize/src/data/database/status_enum.dart';
import 'package:organize/src/models/group_model.dart';
import 'package:organize/src/models/task_model.dart';
import 'package:organize/src/view_models/group_view_model.dart';
import 'package:organize/src/views/base/base_view.dart';
import 'package:organize/src/views/group/group_form_view.dart';
import 'package:organize/src/views/task/task_form_view.dart';
import 'package:organize/src/views/task/task_view.dart';
import 'package:provider/provider.dart';

class GroupView extends StatelessWidget {
  final int id;
  final String title;
  final String? description;
  final Status status;
  final int? score;
  final DateTime createdAt;
  final DateTime updatedAt;

  const GroupView({
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
          context.read<GroupViewModel>().updateGroup(id: id, status: value);
        },
      ),
      dropdownMenu: OrganizeMenuAnchor(
        menuChildren: [
          MenuItemButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => GroupFormView(
                    group: GroupModel(
                      id: id,
                      title: title,
                      description: description,
                      status: status,
                      createdAt: createdAt,
                      updatedAt: updatedAt,
                    ),
                  ),
                ),
              );
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
          List<TaskModel> taskList = value.getTaskList(id);

          if (taskList.isEmpty) {
            return SliverFillRemaining(
              hasScrollBody: false,
              child: Center(
                child: DescriptionButton(
                  description: 'There is no task yet',
                  buttonText: 'Add',
                  onTap: () {
                    showGeneralDialog(
                      context: context,
                      barrierDismissible: true,
                      barrierLabel: "Close",
                      pageBuilder: (context, animation, secondaryAnimation) {
                        return TaskFormView(groupId: id);
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
                  id: taskList[index].id,
                  title: taskList[index].title,
                  description: taskList[index].description,
                  status: taskList[index].status,
                  score: taskList[index].score,
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => TaskView(
                          id: taskList[index].id,
                          title: taskList[index].title,
                          score: taskList[index].score,
                          description: taskList[index].description,
                          status: taskList[index].status,
                          createdAt: taskList[index].createdAt,
                          updatedAt: taskList[index].updatedAt,
                        ),
                      ),
                    );
                  },
                );
              }, childCount: taskList.length),
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => TaskFormView(groupId: id)),
          );
        },
        label: Text('Add task'),
        icon: Icon(Icons.add),
      ),
    );
  }
}