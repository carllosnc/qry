import 'package:flutter/material.dart';
import 'package:qry/qry.dart';
import '../models/post.dart';

class SuccessPost extends StatefulWidget {
  const SuccessPost({super.key});

  @override
  State<SuccessPost> createState() => _SuccessPostState();
}

class _SuccessPostState extends State<SuccessPost> with QryPost {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: FilledButton(
        onPressed: () {
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
        },
        child: isLoading
            ? const SizedBox(
                width: 12,
                height: 12,
                child: CircularProgressIndicator(
                  color: Colors.white,
                  strokeWidth: 2,
                ),
              )
            : const Text('Send Data: success'),
      ),
    );
  }
}

class ErrorPost extends StatefulWidget {
  const ErrorPost({super.key});

  @override
  State<ErrorPost> createState() => _ErrorPostState();
}

class _ErrorPostState extends State<ErrorPost> with QryPost {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: FilledButton(
        onPressed: () {
          Post post = Post(
            userId: 1,
            id: 1,
            title: "title",
            body: "content",
          );

          postData(
            endpoint: 'https://jsonplaceholder.typicode.com/pos',
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
        },
        child: isLoading
            ? const SizedBox(
                width: 12,
                height: 12,
                child: CircularProgressIndicator(
                  color: Colors.white,
                  strokeWidth: 2,
                ),
              )
            : const Text('Send data: error'),
      ),
    );
  }
}

// Examples

class SendData extends StatefulWidget {
  const SendData({super.key});

  @override
  State<SendData> createState() => _SendDataState();
}

class _SendDataState extends State<SendData> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Send data'),
      ),
      body: const Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SuccessPost(),
          SizedBox(height: 12),
          ErrorPost(),
        ],
      ),
    );
  }
}
