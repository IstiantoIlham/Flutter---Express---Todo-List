part of 'todo_bloc.dart';

@immutable
sealed class TodoEvent {}

final class OnGetTodo extends TodoEvent {}

final class OnCreateTodo extends TodoEvent {
  final TodoModel todo;

  OnCreateTodo(this.todo);
}

final class OnUpdateTodo extends TodoEvent {
  final String id;
  final TodoModel todo;

  OnUpdateTodo({required this.id, required this.todo});
}

final class OnDeleteTodo extends TodoEvent {
  final String id;

  OnDeleteTodo(this.id);
}
