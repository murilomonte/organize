import 'package:flutter/material.dart';
import 'package:organize/src/views/error/error_view.dart';
import 'package:organize/src/views/group/group_view.dart';
import 'package:organize/src/views/navigation.dart';
import 'package:organize/src/views/subtask/subtask_view.dart';
import 'package:organize/src/views/task/task_view.dart';

class Organize extends StatelessWidget {
  final bool isFirstLogin = false;

  const Organize({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: '/',
      onGenerateRoute: (settings) {
        if (settings.name == 'group') {
          int id = settings.arguments as int;
          return MaterialPageRoute(
            builder: (context) => GroupView(id: id),
            settings: settings,
          );
        }

        if (settings.name == 'task') {
          int id = settings.arguments as int;
          return MaterialPageRoute(
            builder: (context) => TaskView(id: id),
            settings: settings,
          );
        }

        if (settings.name == 'subtask') {
          int id = settings.arguments as int;
          return MaterialPageRoute(
            builder: (context) => SubtaskView(id: id),
            settings: settings,
          );
        }

        return null;
      },
      onUnknownRoute: (settings) {
        return MaterialPageRoute(
          builder: (context) => ErrorView(message: 'Unknown route.',)
        );
      },
      debugShowCheckedModeBanner: false,
      theme: ThemeData.light(),
      darkTheme: ThemeData.dark(),
      themeMode: ThemeMode.system,
      home: isFirstLogin ? Placeholder() : Navigation(),
    );
  }
}
