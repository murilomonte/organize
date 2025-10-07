import 'package:flutter/material.dart';
import 'package:organize/src/_core/widgets/organize_item_tile.dart';
import 'package:organize/src/models/group_model.dart';
import 'package:organize/src/view_models/group_view_model.dart';
import 'package:organize/src/views/group/group_view.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Organize')),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Center(
          child: Consumer<GroupViewModel>(
            builder: (context, value, child) {
              List<GroupModel> groupList = value.getGroupList();

              if (value.errorMsg.isNotEmpty) {
                return Center(child: Text(value.errorMsg));
              }

              if (value.isLoading) {
                return Center(child: CircularProgressIndicator());
              }

              if (groupList.isEmpty) {
                return Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [Text('There is no group yet'), Text('Add one!')],
                );
              }
              return ListView.builder(
                itemCount: groupList.length,
                itemBuilder: (context, index) {
                  return OrganizeItemTile(
                    id: groupList[index].id,
                    title: groupList[index].title,
                    description: groupList[index].description,
                    status: groupList[index].status,
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              GroupView(id: groupList[index].id),
                        ),
                      );
                    },
                  );
                },
              );
            },
          ),
        ),
      ),
    );
  }
}
