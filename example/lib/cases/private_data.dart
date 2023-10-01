import 'package:flutter/material.dart';
import 'package:qry/qry.dart';
import '../models/timezone.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class PrivateData extends StatefulWidget {
  const PrivateData({super.key});

  @override
  State<PrivateData> createState() => _PrivateDataState();
}

class _PrivateDataState extends State<PrivateData>
    with QryGet<PrivateData, Timezone> {
  @override
  void initState() {
    super.initState();

    getData(
      endpoint: "https://api.themoviedb.org/3/configuration/timezones",
      adapter: Timezone.fromJson,
      headers: {"Authorization": "Bearer ${dotenv.env['TMDB_API_KEY']}"},
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
        appBar: AppBar(
          title: const Text('Private Data'),
        ),
        body: Center(
          child: Text("${statusCode!} - ${errorMessage!}"),
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Private Data'),
      ),
      body: ListView.builder(
        itemCount: dataList!.length,
        itemBuilder: (context, index) {
          final item = dataList![index];

          return ListTile(
            title: Text(item.iso_3166_1),
            subtitle: Text(item.zones.join(", ")),
          );
        },
      ),
    );
  }
}
