import 'package:flutter/material.dart';
import 'package:qry/qry.dart';

import '../models/todo.dart';

class SingleData extends StatefulWidget {
  const SingleData({super.key});

  @override
  State<SingleData> createState() => _SingleDataState();
}

class _SingleDataState extends State<SingleData> with QryGet<SingleData, Todo> {
  @override
  void initState() {
    super.initState();

    getData(
      endpoint: 'https://jsonplaceholder.typicode.com/todos/3',
      adapter: Todo.fromJson,
    );
  }

  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      return const Scaffold(
        body: Center(
          child: CircularProgressIndicator(),
        ),
      );
    }

    if (hasError) {
      return Scaffold(
        body: Center(
          child: Text(error!.message),
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Home'),
      ),
      body: ListTile(
        leading: Text(data!.id.toString()),
        title: Text(data!.title),
      ),
    );
  }
}
