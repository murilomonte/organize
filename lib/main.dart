import 'package:flutter/material.dart';
import 'package:organize/src/data/database/app_database.dart';
import 'package:organize/src/data/repositories/organize_repository.dart';
import 'package:organize/src/organize.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final db = AppDatabase();

  OrganizeRepository repo = OrganizeRepository(
    groupsDao: db.groupsDao,
    tasksDao: db.tasksDao,
    subtasksDao: db.subtasksDao,
    statusDao: db.statusDao
  );

  runApp(Organize());
}
