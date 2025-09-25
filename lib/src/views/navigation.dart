import 'package:flutter/material.dart';
import 'package:organize/src/utility/constraints.dart';
import 'package:organize/src/views/home/home_screen.dart';

class Navigation extends StatefulWidget {
  const Navigation({super.key});

  @override
  State<Navigation> createState() => _NavigationState();
}

class _NavigationState extends State<Navigation> {
  List destinations = [
    (
      icon: Icon(Icons.task_alt_outlined),
      selectedIcon: Icon(Icons.task_alt),
      label: 'Groups',
    ),
    (
      icon: Icon(Icons.show_chart_outlined),
      selectedIcon: Icon(Icons.show_chart),
      label: 'My progress',
    ),
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
    return LayoutBuilder(
      builder: (context, constraints) {
        if (constraints.maxWidth < mobileMaxWidth) {
          return Scaffold(
            bottomNavigationBar: NavigationBar(
              selectedIndex: _currentIndex,
              onDestinationSelected: _onDestinationSelected,
              destinations: destinations.map((e) {
                return NavigationDestination(
                  icon: e.icon,
                  selectedIcon: e.selectedIcon,
                  label: e.label,
                );
              }).toList(),
            ),
            body: views[_currentIndex],
            floatingActionButton: FloatingActionButton.extended(
              onPressed: () {},
              label: Text('Add task'),
              icon: Icon(Icons.add),
            ),
          );
        } else {
          return DefaultTabController(
            initialIndex: 0,
            length: 2,
            child: Scaffold(
              body: Column(
                children: [
                  Container(
                    decoration: BoxDecoration(
                      color: Theme.of(context).colorScheme.surfaceContainer,
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          IconButton(onPressed: () {}, icon: Icon(Icons.add)),
                          SizedBox(
                            width: 500,
                            child: TabBar(
                              enableFeedback: true,
                              dividerColor: Colors.transparent,
                              indicatorPadding: EdgeInsetsGeometry.symmetric(
                                vertical: 5,
                              ),
                              indicator: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: Theme.of(
                                  context,
                                ).colorScheme.surfaceBright,
                              ),
                              tabs: destinations.map((e) {
                                return Padding(
                                  padding: const EdgeInsets.symmetric(
                                    vertical: 15.0,
                                  ),
                                  child: Row(
                                    spacing: 10,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [e.icon, Text(e.label)],
                                  ),
                                );
                              }).toList(),
                            ),
                          ),
                          IconButton(onPressed: () {}, icon: Icon(Icons.menu)),
                        ],
                      ),
                    ),
                  ),
                  Expanded(child: TabBarView(children: views)),
                ],
              ),
            ),
          );
        }
      },
    );
  }
}
