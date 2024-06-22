import 'dart:convert';

import 'package:d_method/d_method.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import 'package:todo_list/models/todo_model.dart';

class TodoApi {
  static String? baseUrl = dotenv.env['API_URL'];

  Future<TodoModel> createTodo(TodoModel todo) async {
    final response = await http.post(
      Uri.parse('$baseUrl/todos'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(todo.toJson()),
    );

    if (response.statusCode == 201) {
      final responseData = jsonDecode(response.body);
      return TodoModel.fromJson(responseData);
    } else {
      throw Exception('Failed to create todo: ${response.reasonPhrase}');
    }
  }

  Future<List<TodoModel>> getTodo() async {
    final response = await http.get(Uri.parse('${baseUrl!}todos'));
    if (response.statusCode == 200) {
      final Map<String, dynamic> data = jsonDecode(response.body);
      final List<dynamic> todo = data['data'];
      return todo.map((item) => TodoModel.fromJson(item)).toList();
    } else {
      throw Exception('Failed to fetch data');
    }
  }

  Future<TodoModel> updateTodo(TodoModel? todo, String id) async {
    String uri = '${baseUrl!}todos/$id';
    final response = await http.put(
      Uri.parse(uri),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(todo?.toJson()),
    );

    if (response.statusCode == 201) {
      final responseData = jsonDecode(response.body);
      return TodoModel.fromJson(responseData);
    } else {
      DMethod.log(uri);
      throw Exception('Failed to update data');
    }
  }

  Future<int> deleteTodo(String id) async {
    final response = await http.delete((Uri.parse('${baseUrl!}todos/$id')));
    if (response.statusCode == 200) {
      return response.statusCode;
    } else {
      throw Exception('Failed to delete todo');
    }
  }
}
