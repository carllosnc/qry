import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'http_status_code.dart';
import 'qry_exception.dart';
import 'http_message.dart';
import 'typedef.dart';

mixin QryPost<T extends StatefulWidget, Model> on State<T> {
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
  ///
  /// [payload] is the data to be sent with the request
  ///
  /// [onSuccess] is a function that is called when the request is successful
  Future<void> postData({
    required String endpoint,
    required Adapter<Model> adapter,
    required Object payload,
    OnSuccess? onSuccess,
    OnError? onError,
    Map<String, String> headers = const {},
  }) async {
    try {
      setState(() {
        isLoading = true;
      });

      final response = await http.post(
        Uri.parse(endpoint),
        body: json.encode(payload),
        headers: {
          'Content-type': 'application/json; charset=UTF-8',
          'Accept': '*/*',
          ...headers,
        },
      );

      // throw an exception if the request is not successful
      if (!successRange.contains(response.statusCode)) {
        var error = QryException(
          message: httpErrorMessage(response),
          statusCode: response.statusCode.toString(),
          description: jsonDecode(response.body),
        );

        onError?.call(error);

        throw error;
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
        // if it is not, convert it to a model
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

      // call the onSucess function when the request is successful
      if (onSuccess != null) {
        onSuccess(data ?? dataList);
      }
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
