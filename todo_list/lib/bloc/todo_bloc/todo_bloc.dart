import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_list/models/todo_model.dart';
import 'package:todo_list/repositories/todo_repository.dart';
import 'package:d_method/d_method.dart';

part 'todo_event.dart';

part 'todo_state.dart';

class TodoBloc extends Bloc<TodoEvent, TodoState> {
  final TodoRepository todoRepository = TodoRepository();

  TodoBloc() : super(TodoInitial()) {
    on<OnGetTodo>((event, emit) async {
      emit(TodoLoading());
      try {
        final List<TodoModel> data = await todoRepository.getTodo();
        emit(TodoLoad(todos: data));
      } catch (e) {
        DMethod.log(e.toString());
        emit(TodoLoadFailure(message: e.toString()));
      }
    });
    on<OnCreateTodo>((event, emit) async {
      emit(TodoLoading());
      try {
        await todoRepository.createTodo(event.todo);
        final List<TodoModel> data = await todoRepository.getTodo();
        emit(TodoLoad(todos: data));
      } catch (e) {
        DMethod.log(e.toString());
        emit(TodoLoadFailure(message: e.toString()));
      }
    });
    on<OnUpdateTodo>((event, emit) async {
      emit(TodoLoading());
      try {
        await todoRepository.updateTodo(event.todo, event.id);
        final List<TodoModel> data = await todoRepository.getTodo();
        emit(TodoLoad(todos: data));
      } catch (e) {
        DMethod.log(e.toString());
        emit(TodoLoadFailure(message: e.toString()));
      }
    });
    on<OnDeleteTodo>((event, emit) async {
      emit(TodoLoading());
      try {
        await todoRepository.deleteTodo(event.id);
        emit(TodoDelete());
      } catch (e) {
        emit(TodoLoadFailure(message: e.toString()));
      }
    });
  }
}
