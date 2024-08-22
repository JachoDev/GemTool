import 'package:flutter/material.dart';

import 'widgets/widgets.dart';

class TicketGenerationScreen extends StatelessWidget {
  const TicketGenerationScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Generating new ticket'),
      ),
      body: const TicketGenerationView(),
    );
  }
}
