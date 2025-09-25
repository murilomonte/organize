import 'package:flutter/material.dart';
import 'package:organize/src/_core/widgets/organize_modal.dart';
import 'package:organize/src/data/database/status_enum.dart';

class SubtaskModal extends StatelessWidget {
  final int id;
  final String title;
  final String? description;
  final Status status;
  final DateTime createdAt;
  final DateTime updatedAt;

  const SubtaskModal({
    super.key,
    required this.id,
    required this.title,
    this.description,
    required this.status,
    required this.createdAt,
    required this.updatedAt,
  });

  @override
  Widget build(BuildContext context) {
    return OrganizeModal(
      maxHeight: 500,
      children: [
        Text(title, style: TextStyle(fontSize: 30)),
        if (description != null) Text(description!),
        Row(spacing: 20, children: [Text('$createdAt'), Text('$updatedAt')]),
        SizedBox(height: 20),
      ],
    );
  }
}
