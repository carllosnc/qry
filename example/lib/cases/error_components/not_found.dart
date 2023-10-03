import 'package:flutter/material.dart';
import 'package:qry/qry.dart';
import '/models/todo.dart';

class NotFound extends StatefulWidget {
  const NotFound({super.key});

  @override
  State<NotFound> createState() => _NotFoundState();
}

class _NotFoundState extends State<NotFound> with QryGet<NotFound, Todo> {
  @override
  void initState() {
    super.initState();

    getData(
      endpoint: "https://jsonplaceholder.typicode.com/tod",
      adapter: Todo.fromJson,
    );
  }

  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      return const Center(
        child: CircularProgressIndicator(),
      );
    }

    if (hasError) {
      return Container(
        padding: const EdgeInsets.all(10),
        color: Colors.red[200],
        child: Center(
          child: Text("${error!.statusCode} - ${error!.message}"),
        ),
      );
    }

    return Container(
      color: Colors.green,
      child: const Text(
        "Hello world!",
      ),
    );
  }
}
