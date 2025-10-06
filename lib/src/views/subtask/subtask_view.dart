import 'package:flutter/material.dart';
import 'package:organize/src/_core/widgets/organize_menu_anchor.dart';
import 'package:organize/src/data/database/status_enum.dart';
import 'package:organize/src/models/subtask_model.dart';
import 'package:organize/src/view_models/group_view_model.dart';
import 'package:organize/src/views/base/base_view.dart';
import 'package:organize/src/views/subtask/subtask_form_view.dart';
import 'package:provider/provider.dart';

class SubtaskView extends StatelessWidget {
  final int id;
  const SubtaskView({super.key, required this.id});

  @override
  Widget build(BuildContext context) {
    return Consumer<GroupViewModel>(
      builder: (context, value, child) {
        SubtaskModel subtask = value.getSubtask(id);
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
                onPressed: () {},
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
      },
    );
  }
}
