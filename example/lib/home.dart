import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Qry'),
      ),
      body: ListView(
        children: [
          ListTile(
            title: const Text('List of Data'),
            onTap: () {
              Navigator.pushNamed(context, '/list-of-data');
            },
          ),
          ListTile(
            title: const Text('Single Data'),
            onTap: () {
              Navigator.pushNamed(context, '/single-data');
            },
          ),
          ListTile(
            title: const Text('Private Data'),
            onTap: () {
              Navigator.pushNamed(context, '/private-data');
            },
          ),
        ],
      ),
    );
  }
}
