import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'http_status_code.dart';
import 'qry_exception.dart';
import 'http_message.dart';
import 'typedef.dart';

mixin QryGet<T extends StatefulWidget, Model> on State<T> {
  /// is true when the request is loading
  bool isLoading = false;

  /// is true when the request is successful
  bool isSuccess = false;

  /// is true when the request is unsuccessful
  bool hasError = false;

  /// is the status code of the response
  String? statusCode;

  /// is the error message of the response
  QryException? error;

  /// is the data of the response
  Model? data;

  /// is the list of data of the response
  List<Model>? dataList;

  /// getData is a function that makes a get request to an endpoint and returns the response
  ///
  /// It takes 3 parameters:
  ///
  /// [endpoint] is the url of the endpoint
  ///
  /// [adapter] is a function that converts the json response to a model, e.g. Todo.fromJson
  ///
  /// [headers] is a map of headers to be sent with the request
  Future<void> getData({
    required String endpoint,
    required Adapter<Model> adapter,
    Map<String, String> headers = const {},
  }) async {
    try {
      setState(() {
        isLoading = true;
      });

      final response = await http.get(Uri.parse(endpoint), headers: headers);

      // throw an exception if the request is not successful
      if (!successRange.contains(response.statusCode)) {
        throw QryException(
          message: httpErrorMessage(response),
          statusCode: response.statusCode.toString(),
          description: jsonDecode(response.body),
        );
      }

      var body = jsonDecode(response.body);
      bool isList = body is List;
      statusCode = response.statusCode.toString();
      List<Model> items = [];
      Model? item;

      //check if body is a list
      if (isList) {
        // if it is, loop through it and add each element to the elements list
        for (var element in body) {
          items.add(adapter(element));
        }
      } else {
        // if body is not a list, then it is a single element
        item = adapter(body);
      }

      setState(() {
        isLoading = false;
        isSuccess = true;
        hasError = false;
        error = null;
        statusCode = response.statusCode.toString();
        data = item;
        dataList = items;
      });
    } on QryException catch (e) {
      setState(() {
        isLoading = false;
        isSuccess = false;
        hasError = true;
        error = e;
        statusCode = null;
        data = null;
        dataList = null;
      });
    }
  }
}
