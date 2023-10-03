# Qry

>Do HTTP requests based on mixins

- ✅ **QryGet**: get data
- ✅ **QryPost**: send data
- 🚧 **QryPut**: update data
- 🚧 **QryDelete**: delete data

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
          child: Text(error!.message),
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

## Examples
- [Get a list of Todos](https://github.com/C4co/qry/blob/master/example/lib/cases/list_of_data.dart)
- [Get a single Todo](https://github.com/C4co/qry/blob/master/example/lib/cases/single_data.dart)
- [Get private data](https://github.com/C4co/qry/blob/master/example/lib/cases/private_data.dart)
- [Show error messages: not found](https://github.com/C4co/qry/blob/master/example/lib/cases/error_components/not_found.dart)
- [Show error messages: unauthorized](https://github.com/C4co/qry/blob/master/example/lib/cases/error_components/unauthorized.dart)

## QryGet: getData()
> getData is a function that makes a get request to an endpoint

**Parameters:**

| Name       | Type                  | Default | Description                                                                  |
| ---------- | --------------------- | ------- | ---------------------------------------------------------------------------- |
| `endpoint` | `string`              | `null`  | url of the endpoint                                                          |
| `adapter`  | `Function`            | `null`  | is a function that converts the json response to a model, e.g. Todo.fromJson |
| `headers`  | `Map<String, String>` | `null`  | map of headers to be sent with the request                                   |


```dart
@override
void initState() {
  super.initState();

  getData(
    endpoint: "https://api.themoviedb.org/3/configuration/timezones",
    adapter: Timezone.fromJson,
    headers: {"Authorization": "Bearer ${dotenv.env['TMDB_API_KEY']}"},
  );
}
```

## QryPost: postData()
> postData is a function that makes a post request to an endpoint

**Parameters:**

| Name        | Type                  | Default | Description                                                                  |
| ----------- | --------------------- | ------- | ---------------------------------------------------------------------------- |
| `endpoint`  | `string`              | `null`  | url of the endpoint                                                          |
| `body`      | `dynamic`             | `null`  | body of the request                                                          |
| `adapter`   | `Function`            | `null`  | is a function that converts the json response to a model, e.g. Todo.fromJson |
| `headers`   | `Map<String, String>` | `null`  | map of headers to be sent with the request                                   |
| `onSuccess` | `Function(dynamic)`   | `null`  | is a function that is called when the request is successful                  |
| `onError`   | `Function(dynamic)`   | `null`  | is a function that is called when the request is unsuccessful                |


```dart
Post post = Post(
  userId: 1,
  id: 1,
  title: "title",
  body: "content",
);

postData(
  endpoint: 'https://jsonplaceholder.typicode.com/posts',
  adapter: Post.fromJson,
  payload: post,
  onError: (error) {
    SnackBar snackBar = SnackBar(
      content: Text(error.message),
    );

    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  },
  onSuccess: (dynamic result) {
    SnackBar snackBar = const SnackBar(
      content: Text('Post created successfully'),
    );

    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  },
);
```

## States

| Name         | Type           | Default | Description                                     |
| ------------ | -------------- | ------- | ----------------------------------------------- |
| `isloading`  | `bool`         | `false` | is true when request is loading                 |
| `hasError`   | `bool`         | `false` | is true when request is completed with error    |
| `isSuccess`  | `bool`         | `false` | is true when request is completed with success  |
| `statusCode` | `String`       | `null`  | http status code, ex: 200, 400, 404             |
| `error`      | `QryException` | `null`  | error message, status code and description      |
| `data`       | `dynamic`      | `null`  | body of response                                |
| `dataList`   | `dynamic`      | `null`  | lits of objects when body of response is a list |

---

Carlos Costa @ 2023
