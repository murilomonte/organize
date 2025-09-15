import 'package:flutter/material.dart';
import 'package:organize/src/utility/constraints.dart';

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
      label: 'Tasks',
    ),
    (
      icon: Icon(Icons.show_chart_outlined),
      selectedIcon: Icon(Icons.show_chart),
      label: 'My progress',
    ),
  ];

  List<Widget> views = [
    Center(child: Text('Home')),
    Center(child: Text('Progress')),
  ];

  void _onDestinationSelected(value) {
    setState(() {
      _currentIndex = value;
    });
  }

  int _currentIndex = 0;
  @override
  Widget build(BuildContext context) {
    if (isMobileLayout(context)) {
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
      );
    } else {
      return Scaffold(
        body: Row(
          children: [
            SafeArea(
              child: NavigationRail(
                minExtendedWidth: 200,
                backgroundColor: Theme.of(context).colorScheme.surfaceContainer,
                extended: true,
                destinations: destinations.map((e) {
                  return NavigationRailDestination(
                    icon: e.icon,
                    selectedIcon: e.selectedIcon,
                    label: Text(e.label),
                  );
                }).toList(),
                selectedIndex: _currentIndex,
                onDestinationSelected: _onDestinationSelected,
              ),
            ),
            Expanded(child: views[_currentIndex]),
          ],
        ),
      );
    }
  }
}
