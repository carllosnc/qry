import 'package:flutter/material.dart';
import 'package:qry_example/home.dart';
import './cases/list_of_data.dart';
import './cases/single_data.dart';
import './cases/private_data.dart';
import './cases/get_error.dart';
import './cases/send_data.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'MyApp',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(useMaterial3: true),
      home: const Home(),
      routes: {
        '/home': (context) => const Home(),
        '/list-of-data': (context) => const ListOfData(),
        '/single-data': (context) => const SingleData(),
        '/private-data': (context) => const PrivateData(),
        '/get-error': (context) => const GetError(),
        '/send-data': (context) => const SendData(),
      },
    );
  }
}
