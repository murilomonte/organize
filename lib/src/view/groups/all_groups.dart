import 'package:flutter/material.dart';
import 'package:organize/src/_core/widgets/group_item.dart';
import 'package:organize/src/utility/constraints.dart';
import 'package:organize/src/view_models/group_view_model.dart';
import 'package:provider/provider.dart';

class AllGroups extends StatelessWidget {
  const AllGroups({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: isMobileLayout(context) ? AppBar(title: Text('All tasks')) : null,
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Center(
          child: ConstrainedBox(
            constraints: BoxConstraints(maxWidth: 800),
            child: Consumer<GroupViewModel>(
              builder: (context, value, child) {
                if (value.isLoading) {
                  return Center(child: CircularProgressIndicator());
                }

                if (value.groupList.isEmpty) {
                  return Center(
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
                  );
                }
                return ListView.builder(
                  itemCount: value.groupList.length,
                  itemBuilder: (context, index) {
                    return GroupItem(
                      title: value.groupList[index].title,
                      description: value.groupList[index].description,
                      taskList: value.groupList[index].tasks,
                    );
                  },
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
