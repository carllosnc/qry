import 'package:flutter/material.dart';
import '/cases/error_components/not_found.dart';
import '/cases/error_components/unauthorized.dart';

class GetError extends StatefulWidget {
  const GetError({super.key});

  @override
  State<GetError> createState() => _GetErrorState();
}

class _GetErrorState extends State<GetError> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('GetError'),
      ),
      body: const Center(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          NotFound(),
          Unauthorized(),
        ],
      )),
    );
  }
}
