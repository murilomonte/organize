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
  final _createGroupForm = GlobalKey<FormState>();
  final _groupTitleController = TextEditingController();
  final _groupDescriptionController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return OrganizeModal(
      title: 'Create group',
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
            if (_createGroupForm.currentState!.validate()) {
              context.read<GroupViewModel>().createGroup(
                title: _groupTitleController.text,
                description: _groupDescriptionController.text,
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
          label: Text('Add group'),
          icon: Icon(Icons.add),
        ),
      ],
      children: [
        Form(
          key: _createGroupForm,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextFormField(
                controller: _groupTitleController,
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
                controller: _groupDescriptionController,
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
