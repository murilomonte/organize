import 'package:flutter/material.dart';
import 'package:organize/src/views/home/home_screen.dart';

class Navigation extends StatefulWidget {
  const Navigation({super.key});

  @override
  State<Navigation> createState() => _NavigationState();
}

class _NavigationState extends State<Navigation> {
  List<Map<String, dynamic>> destinations = [
    {
      'icon': Icon(Icons.task_alt_outlined),
      'selectedIcon': Icon(Icons.task_alt),
      'label': 'Groups',
    },
    {
      'icon': Icon(Icons.show_chart_outlined),
      'selectedIcon': Icon(Icons.show_chart),
      'label': 'My progress',
    },
  ];

  List<Widget> views = [HomeScreen(), Center(child: Text('Progress'))];

  void _onDestinationSelected(int value) {
    setState(() {
      _currentIndex = value;
    });
  }

  int _currentIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: NavigationBar(
        backgroundColor: Colors.transparent,
        selectedIndex: _currentIndex,
        onDestinationSelected: _onDestinationSelected,
        destinations: destinations.map((e) {
          return NavigationDestination(
            icon: e['icon']!,
            selectedIcon: e['selectedIcon'],
            label: e['label'],
          );
        }).toList(),
      ),
      body: views[_currentIndex],
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => Scaffold(
                appBar: AppBar(),
                body: Center(child: Text('Form')),
              ),
            ),
          );
        },
        label: Text('Add Group'),
        icon: Icon(Icons.add),
      ),
    );
  }
}
