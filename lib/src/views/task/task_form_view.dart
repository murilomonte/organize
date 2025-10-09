import 'package:flutter/material.dart';
import 'package:organize/src/_core/widgets/gap.dart';
import 'package:organize/src/models/task_model.dart';
import 'package:organize/src/view_models/group_view_model.dart';
import 'package:provider/provider.dart';

class TaskFormView extends StatefulWidget {
  final TaskModel? task;
  final int groupId;
  const TaskFormView({super.key, this.task, required this.groupId});

  @override
  State<TaskFormView> createState() => _TaskFormViewState();
}

class _TaskFormViewState extends State<TaskFormView> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _titleController = TextEditingController();
  late TextEditingController _descriptionController = TextEditingController();

  double _points = 0;

  @override
  void initState() {
    super.initState();
    _titleController = TextEditingController(text: widget.task?.title ?? '');
    _descriptionController = TextEditingController(
      text: widget.task?.description ?? '',
    );
    _points = widget.task?.score.toDouble() ?? 0;
  }

  void _save(BuildContext context) {
    if (_formKey.currentState!.validate()) {
      final title = _titleController.text;
      final description = _descriptionController.text;
      final points = _points.toInt();

      if (widget.task == null) {
        context.read<GroupViewModel>().createTask(
          groupId: widget.groupId,
          title: title,
          score: _points.toInt(),
          description: description,
        );
      } else {
        context.read<GroupViewModel>().updateTask(
          id: widget.task!.id,
          title: title != widget.task!.title ? title : null,
          description: description != widget.task!.description
              ? description
              : null,
          score: points != widget.task!.score ? points : null,
        );
      }
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: false,
      child: Scaffold(
        appBar: AppBar(
          title: Text(widget.task == null ? 'New task' : 'Edit task'),
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  TextFormField(
                    controller: _titleController,
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
                    maxLines: 10,
                    controller: _descriptionController,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      label: Text('Description'),
                    ),
                  ),
                  Gap(10),
                  Row(
                    spacing: 30,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
          ),
        ),
        bottomSheet: BottomAppBar(
          elevation: 0,
          color: Colors.transparent,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              TextButton.icon(
                style: ButtonStyle(
                  padding: WidgetStatePropertyAll(
                    EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  ),
                ),
                onPressed: () {
                  Navigator.pop(context);
                },
                icon: Icon(Icons.close),
                label: Text(
                  'Cancel',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
              TextButton.icon(
                style: ButtonStyle(
                  padding: WidgetStatePropertyAll(
                    EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  ),
                ),
                onPressed: () {
                  _save(context);
                },
                icon: Icon(Icons.add),
                label: Text(
                  'Add',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
