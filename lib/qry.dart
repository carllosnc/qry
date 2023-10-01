library qry;

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

typedef Adapter<T> = T Function(Map<String, dynamic> json);

/// Qry is a mixin that provides a function to make http requests
mixin QryGet<T extends StatefulWidget, Model> on State<T> {
  /// is true when the request is loading
  bool isLoading = true;

  /// is true when the request is successful
  bool isSuccess = false;

  /// is true when the request is unsuccessful
  bool hasError = false;

  /// is the status code of the response
  String? statusCode;

  /// is the error message of the response
  String? errorMessage;

  /// is the data of the response
  Model? data;

  /// is the list of data of the response
  List<Model>? dataList;

  // mapping error status code to error message
  String errorMapping(dynamic response) {
    switch (response.statusCode) {
      case 400:
        return 'Bad Request';
      case 401:
        return 'Unauthorized';
      case 403:
        return 'Forbidden';
      case 404:
        return 'Not Found';
      case 500:
        return 'Internal Server Error';
      case 502:
        return 'Bad Gateway';
      case 503:
        return 'Service Unavailable';
      case 504:
        return 'Gateway Timeout';
      default:
        return 'Something went wrong';
    }
  }

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
    var response = await http.get(Uri.parse(endpoint), headers: headers);
    var body = jsonDecode(response.body);
    bool isList = body is List;
    statusCode = response.statusCode.toString();
    List<Model> items = [];
    Model? item;

    if (response.statusCode != 200) {
      setState(() {
        isLoading = false;
        hasError = true;
        isSuccess = false;
        statusCode = response.statusCode.toString();
        errorMessage = errorMapping(response);
        data = null;
        dataList = null;
      });

      http.Client().close();

      return;
    }

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
      hasError = false;
      isLoading = false;
      isSuccess = true;
      errorMessage = null;
      statusCode = '200';
      data = item;
      dataList = items;
    });

    http.Client().close();
  }
}
