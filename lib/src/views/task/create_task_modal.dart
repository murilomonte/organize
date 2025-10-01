import 'package:flutter/material.dart';
import 'package:organize/src/_core/widgets/gap.dart';
import 'package:organize/src/_core/widgets/organize_modal.dart';
import 'package:organize/src/view_models/group_view_model.dart';
import 'package:provider/provider.dart';

class CreateTaskModal extends StatefulWidget {
  final int groupId;
  const CreateTaskModal({super.key, required this.groupId});

  @override
  State<CreateTaskModal> createState() => _CreateTaskModalState();
}

class _CreateTaskModalState extends State<CreateTaskModal> {
  final _createTaskFrom = GlobalKey<FormState>();
  final _taskTitleController = TextEditingController();
  final _taskDescriptionController = TextEditingController();

  double _points = 0;

  @override
  Widget build(BuildContext context) {
    return OrganizeModal(
      title: 'Create task',
      maxHeight: 300,
      maxWidth: 500,
      actions: [
        TextButton.icon(
          style: ButtonStyle(
            padding: WidgetStatePropertyAll(
              EdgeInsets.symmetric(horizontal: 30, vertical: 20),
            ),
          ),
          onPressed: () {
            if (_createTaskFrom.currentState!.validate()) {
              context.read<GroupViewModel>().createTask(
                groupId: widget.groupId,
                title: _taskTitleController.text,
                description: _taskDescriptionController.text,
                score: _points.toInt(),
              );
              Navigator.of(context).pop();
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  duration: Duration(seconds: 2),
                  content: Text('Adding group...'),
                ),
              );
            }
          },
          label: Text('Add task'),
          icon: Icon(Icons.add),
        ),
      ],
      children: [
        Form(
          key: _createTaskFrom,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextFormField(
                controller: _taskTitleController,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  label: Text('Title'),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'The title cannot be empty';
                  }
                  return null;
                },
              ),
              Gap(10),
              TextFormField(
                controller: _taskDescriptionController,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  label: Text('Description'),
                ),
              ),
              Gap(10),
              Text('Score'),
              Row(
                spacing: 30,
                children: [
                  Expanded(
                    flex: 8,
                    child: Slider(
                      padding: EdgeInsets.all(0),
                      // ignore: deprecated_member_use
                      year2023: false,
                      value: _points,
                      divisions: 10,
                      max: 100,
                      label: _points.round().toString(),
                      onChanged: (value) {
                        setState(() {
                          _points = value;
                        });
                      },
                    ),
                  ),
                  Expanded(
                    flex: 2,
                    child: Text(
                      '${_points.toInt()} pts',
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }
}
