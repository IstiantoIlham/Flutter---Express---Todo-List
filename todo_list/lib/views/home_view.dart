import 'package:d_method/d_method.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_list/bloc/todo_bloc/todo_bloc.dart';
import 'package:todo_list/models/todo_model.dart';
import 'package:todo_list/widgets/input_todo.dart';
import 'package:todo_list/widgets/todo_card.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    addTodo() {
      final title = TextEditingController();
      final description = TextEditingController();
      showDialog(
        context: context,
        builder: (context) {
          return SimpleDialog(
            contentPadding: const EdgeInsets.all(12),
            children: [
              InputTodo(
                  title: title,
                  description: description,
                  onSubmit: () {
                    TodoModel todo =
                        TodoModel(title: title.text, description: title.text);
                    context.read<TodoBloc>().add(OnCreateTodo(todo));
                    Navigator.pop(context);
                  },
                  actionText: "Tambah Todo")
            ],
          );
        },
      );
    }

    updateTodo(id, titleUpt, descriptionUpt) {
      DMethod.log(id);
      final title = TextEditingController();
      final description = TextEditingController();
      title.text = titleUpt;
      description.text = descriptionUpt;
      showDialog(
        context: context,
        builder: (context) {
          return SimpleDialog(
            contentPadding: const EdgeInsets.all(12),
            children: [
              InputTodo(
                  title: title,
                  description: description,
                  onSubmit: () {
                    TodoModel todo =
                        TodoModel(title: title.text, description: title.text);
                    context
                        .read<TodoBloc>()
                        .add(OnUpdateTodo(id: id, todo: todo));
                    Navigator.pop(context);
                  },
                  actionText: "Update Todo")
            ],
          );
        },
      );
    }

    deleteTodo(String id) {
      context.read<TodoBloc>().add(OnDeleteTodo(id));
      DMethod.log("Todo Telah dihapus");
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text("TodoApp"),
      ),
      body: BlocBuilder<TodoBloc, TodoState>(
        builder: (BuildContext context, TodoState state) {
          if (state is TodoInitial) {
            return const Center(
              child: Text("Todo Initial"),
            );
          }
          if (state is TodoLoading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          if (state is TodoLoad) {
            List<TodoModel> data = state.todos;
            return ListView.builder(
              itemCount: data.length,
              itemBuilder: (context, index) {
                final todo = data[index];
                return TodoCard(
                  title: todo.title,
                  subtitle: todo.description,
                  trailing: PopupMenuButton(
                    onSelected: (value) {
                      switch (value) {
                        case "delete":
                          deleteTodo(todo.id.toString());
                          break;

                        case "update":
                          updateTodo(todo.id.toString(), todo.title, todo.description);
                          break;
                      }
                    },
                    itemBuilder: (context) => [
                      const PopupMenuItem(
                        value: "update",
                        child: Text("Update"),
                      ),
                      const PopupMenuItem(
                        value: "delete",
                        child: Text("Delete"),
                      )
                    ],
                  ),
                  index: index,
                );
              },
            );
          }
          if (state is TodoDelete) {
            context.read<TodoBloc>().add(OnGetTodo());
          }
          if (state is TodoLoadFailure) {
            return Center(
              child: Text(state.message),
            );
          }
          return const Text("Error");
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: addTodo,
        child: const Icon(Icons.add),
      ),
    );
  }
}
