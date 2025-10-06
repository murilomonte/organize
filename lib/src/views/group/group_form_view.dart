import 'package:flutter/material.dart';
import 'package:organize/src/_core/widgets/gap.dart';
import 'package:organize/src/models/group_model.dart';
import 'package:organize/src/view_models/group_view_model.dart';
import 'package:provider/provider.dart';

class GroupFormView extends StatefulWidget {
  final GroupModel? group;
  const GroupFormView({super.key, this.group});

  @override
  State<GroupFormView> createState() => _GroupFormViewState();
}

class _GroupFormViewState extends State<GroupFormView> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _titleController = TextEditingController();
  late TextEditingController _descriptionController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _titleController = TextEditingController(text: widget.group?.title ?? '');
    _descriptionController = TextEditingController(
      text: widget.group?.description ?? '',
    );
  }

  void _saveGroup() {
    if (_formKey.currentState!.validate()) {
      final title = _titleController.text;
      final description = _descriptionController.text;

      if (widget.group == null) {
        context.read<GroupViewModel>().createGroup(
          title: title,
          description: description,
        );
      } else {
        context.read<GroupViewModel>().updateGroup(
          id: widget.group!.id,
          title: title != widget.group!.title ? title : null,
          description: description != widget.group!.description
              ? description
              : null,
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: false,
      child: Scaffold(
        appBar: AppBar(title: Text('New group')),
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
                  _saveGroup();
                  Navigator.pop(context);
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
