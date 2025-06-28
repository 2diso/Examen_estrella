import 'package:flutter/material.dart';

class SWListScreen extends StatefulWidget {
  const SWListScreen({super.key}); // buena práctica: incluye key

  @override
  State<SWListScreen> createState() => _SWListScreenState();
}

class _SWListScreenState extends State<SWListScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Star Wars App')),
      body: Center(child: Text('Lista')),
    );
  }
}
