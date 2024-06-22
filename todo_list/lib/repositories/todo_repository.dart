import 'package:todo_list/api/todo_api.dart';
import 'package:todo_list/models/todo_model.dart';

class TodoRepository {
  final TodoApi todoApi = TodoApi();

  Future<TodoModel> createTodo(TodoModel todo) async {
    return await todoApi.createTodo(todo);
  }

  Future<List<TodoModel>> getTodo() async {
    return await todoApi.getTodo();
  }

  Future<int> deleteTodo(String id) async {
    return await todoApi.deleteTodo(id);
  }

  Future<TodoModel> updateTodo(TodoModel todo, String id) async {
    return await todoApi.updateTodo(todo, id);
  }
}
