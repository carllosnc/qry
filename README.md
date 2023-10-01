# Qry

>Do HTTP requests using mixins

```dart
class ListOfData extends StatefulWidget {
  const ListOfData({super.key});

  @override
  State<ListOfData> createState() => _ListOfDataState();
}

//use mixin and pass the data type
class _ListOfDataState extends State<ListOfData> with QryGet<ListOfData, Todo> {
  @override
  void initState() {
    super.initState();

    //call get data function passing the endpoint and a function to adapter the data
    getData(
      endpoint: 'https://jsonplaceholder.typicode.com/todos',
      adapter: Todo.fromJson,
    );
  }

  //control widget with state provided by Qry
  @override
  Widget build(BuildContext context) {

    //check is request is loading
    if (isLoading) {
      return const Scaffold(
        body: Center(
          child: CircularProgressIndicator(),
        ),
      );
    }

    //check if has error
    if (hasError) {
      return Scaffold(
        body: Center(
          child: Text(errorMessage!),
        ),
      );
    }

    //show data
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
```

---

Carlos Costa @ 2023
