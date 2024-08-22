import 'package:flutter/material.dart';
import 'package:flutter_expandable_fab/flutter_expandable_fab.dart';

import 'widgets/widgets.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Home'),
          actions: const [
            TicketOverviewFilterButton(),
            TicketOverviewOptionsButton(),
          ],
        ),
        floatingActionButtonLocation: ExpandableFab.location,
        floatingActionButton: const HomeAddActionButton(),
        body: const HomeView(),
      );
  }
}



