import 'package:flutter/material.dart';
import 'package:qry/qry.dart';
import '/models/timezone.dart';

class Unauthorized extends StatefulWidget {
  const Unauthorized({super.key});

  @override
  State<Unauthorized> createState() => _UnauthorizedState();
}

class _UnauthorizedState extends State<Unauthorized>
    with QryGet<Unauthorized, Timezone> {
  @override
  void initState() {
    getData(
      endpoint: "https://api.themoviedb.org/3/configuration/timezones",
      adapter: Timezone.fromJson,
    );

    super.initState();
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
        color: Colors.red[500],
        child: Center(
          child: Text("${error!.statusCode} - ${error!.message}"),
        ),
      );
    }

    return Container(
      color: Colors.green[300],
      child: const Center(
        child: Text("Hello world"),
      ),
    );
  }
}
