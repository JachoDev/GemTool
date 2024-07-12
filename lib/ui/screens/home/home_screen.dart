import 'package:flutter/material.dart';
import 'package:gemtool/ui/screens/home/widgets/home_view.dart';
import 'package:go_router/go_router.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _counter = 0;
  String? _text = '';

  Future<void> _incrementCounter() async {
    final String? response = 'This is the first resolution';
    setState(() {
      _counter++;
      _text = response;
    });
    context.go('/camera');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text('Home'),
      ),
      body: HomeView(text: _text, counter: _counter),
      floatingActionButton: HomeActionButton(),

    );
  }

  FloatingActionButton HomeActionButton() {
    return FloatingActionButton(
      onPressed: _incrementCounter,
      tooltip: 'Increment',
      child: const Icon(Icons.add),
    );
  }

}
