part of 'todo_bloc.dart';

@immutable
sealed class TodoState {}

final class TodoInitial extends TodoState {}

final class TodoLoading extends TodoState {}

final class TodoLoad extends TodoState {
  final List<TodoModel> todos;

  TodoLoad({required this.todos});
}

final class TodoLoadFailure extends TodoState {
  final String message;

  TodoLoadFailure({required this.message});
}

final class TodoCreate extends TodoState {
  final TodoModel todos;

  TodoCreate({required this.todos});
}

final class TodoUpdate extends TodoState {
  final TodoModel todos;
  final String id;

  TodoUpdate({required this.todos, required this.id});
}

final class TodoDelete extends TodoState {}
