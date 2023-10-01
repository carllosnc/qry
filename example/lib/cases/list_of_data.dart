import 'package:flutter/material.dart';
import 'package:qry/qry.dart';
import '../models/todo.dart';

class ListOfData extends StatefulWidget {
  const ListOfData({super.key});

  @override
  State<ListOfData> createState() => _ListOfDataState();
}

class _ListOfDataState extends State<ListOfData> with QryGet<ListOfData, Todo> {
  @override
  void initState() {
    super.initState();

    getData(
      endpoint: 'https://jsonplaceholder.typicode.com/todos',
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
          child: Text(errorMessage!),
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Home'),
      ),
      body: ListView.builder(
        itemCount: dataList!.length,
        itemBuilder: (context, index) {
          Todo todo = dataList![index];

          return ListTile(
            leading: Text(todo.id.toString()),
            title: Text(todo.title),
          );
        },
      ),
    );
  }
}
