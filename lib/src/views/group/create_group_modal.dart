import 'package:flutter/material.dart';
import 'package:organize/src/_core/widgets/gap.dart';
import 'package:organize/src/_core/widgets/organize_modal.dart';
import 'package:organize/src/view_models/group_view_model.dart';
import 'package:provider/provider.dart';

class CreateGroupModal extends StatefulWidget {
  const CreateGroupModal({super.key});

  @override
  State<CreateGroupModal> createState() => _CreateGroupModalState();
}

class _CreateGroupModalState extends State<CreateGroupModal> {
  final _formKey = GlobalKey<FormState>();
  final _titleController = TextEditingController();
  final _descriptionController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return OrganizeModal(
      title: 'Create group',
      maxHeight: 300,
      bottomBar: Row(
        spacing: 10,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          TextButton.icon(
            style: ButtonStyle(
              padding: WidgetStatePropertyAll(
                EdgeInsets.symmetric(horizontal: 30, vertical: 20),
              ),
            ),
            onPressed: () {
              Navigator.of(context).pop();
            },
            label: Text('Cancel'),
            icon: Icon(Icons.cancel_outlined),
          ),
          TextButton.icon(
            style: ButtonStyle(
              padding: WidgetStatePropertyAll(
                EdgeInsets.symmetric(horizontal: 30, vertical: 20),
              ),
            ),
            onPressed: () {
              if (_formKey.currentState!.validate()) {
                context.read<GroupViewModel>().createGroup(
                  title: _titleController.text,
                  description: _descriptionController.text,
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
            label: Text('Add'),
            icon: Icon(Icons.add_box_outlined),
          ),
        ],
      ),
      children: [
        Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
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
                controller: _descriptionController,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  label: Text('Description'),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
