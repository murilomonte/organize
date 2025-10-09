import 'dart:collection';

import 'package:flutter/material.dart';

enum Status {
  pending(label: 'Pending', icon: Icons.timer_off_outlined),
  inProgress(label: 'In progress', icon: Icons.timer_outlined),
  completed(label: 'Completed', icon: Icons.task_alt_outlined);

  const Status({required this.label, required this.icon});

  final String label;
  final IconData icon;

  static final List<DropdownMenuEntry<Status>> entries =
      UnmodifiableListView<DropdownMenuEntry<Status>>(
        values.map(
          (Status status) => DropdownMenuEntry(
            value: status,
            label: status.label,
            leadingIcon: Icon(status.icon),
          ),
        ),
      );
}
