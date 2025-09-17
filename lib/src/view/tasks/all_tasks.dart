import 'package:flutter/material.dart';
import 'package:organize/src/_core/widgets/tasks_group.dart';
import 'package:organize/src/utility/constraints.dart';

class AllTasks extends StatelessWidget {
  const AllTasks({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('All tasks')),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Center(
          child: ConstrainedBox(
            constraints: BoxConstraints(maxWidth: 800),
            child:
                1 == 1 // Provisorio
                ? ListView(
                    children: [
                      // Only in desktop
                      if (!isMobileLayout(context))
                        Align(
                          alignment: AlignmentGeometry.topRight,
                          child: TextButton.icon(
                            onPressed: () {},
                            label: Text('Add task'),
                            icon: Icon(Icons.add),
                            iconAlignment: IconAlignment.end,
                          ),
                        ),

                      TasksGroup(
                        title: 'Atividades domésticas',
                        description:
                            'Atividades que tenho que fazer antes que um monstro me pegue :O',
                        taskList: [],
                      ),
                      TasksGroup(title: 'O projeto la', taskList: []),
                      TasksGroup(
                        title: 'Trabalhos da escola',
                        description:
                            'Trabalhos que deverão ser concluídos para liberar o mais oculto aspecto do meu conhecimento >:)',
                        taskList: [],
                      ),
                    ],
                  )
                : Center(
                    child: Column(
                      spacing: 10,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Não há nenhum conjunto de tarefas ainda. ',
                          style: TextStyle(fontSize: 20),
                          textAlign: TextAlign.center,
                        ),
                        ElevatedButton(
                          style: TextButton.styleFrom(
                            backgroundColor: Theme.of(
                              context,
                            ).colorScheme.primary,
                            foregroundColor: Theme.of(
                              context,
                            ).colorScheme.onPrimary,
                          ),
                          onPressed: () {},
                          child: Padding(
                            padding: const EdgeInsets.all(15),
                            child: Text(
                              'Adicionar um conjunto',
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
          ),
        ),
      ),
    );
  }
}
