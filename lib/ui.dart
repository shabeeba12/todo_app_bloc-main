import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_app/bloc/task_bloc.dart';
import 'package:todo_app/bloc/task_event.dart';
import 'package:todo_app/bloc/task_state.dart';


class TodoScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final TodoBloc todoBloc = BlocProvider.of<TodoBloc>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text('Todo App'),
      ),
      body: BlocBuilder<TodoBloc, TodoState>(
        builder: (context, todoState) {
          return ListView.builder(
            itemCount: todoState.todos.length,
            itemBuilder: (context, index) {
              return ListTile(
                title: Text(todoState.todos[index].title),
                leading: Checkbox(
                  value: todoState.todos[index].isCompleted,
                  onChanged: (bool? value) {
                    todoBloc.add(ToggleTodoCompletionEvent(index));
                  },
                ),
                trailing: IconButton(
                  icon: Icon(Icons.delete),
                  onPressed: () {
                    todoBloc.add(DeleteTodoEvent(index));
                  },
                ),
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          final String? newTodo = await showDialog(
            context: context,
            builder: (context) {
              String todoTitle = '';
              return AlertDialog(
                title: Text('Add Todo'),
                content: TextField(
                  onChanged: (value) {
                    todoTitle = value;
                  },
                ),
                actions: [
                  TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: Text('Cancel'),
                  ),
                  TextButton(
                    onPressed: () {
                      Navigator.pop(context, todoTitle);
                    },
                    child: Text('Add'),
                  ),
                ],
              );
            },
          );
          if (newTodo != null && newTodo.isNotEmpty) {
            todoBloc.add(AddTodoEvent(newTodo));
          }
        },
        child: Icon(Icons.add),
      ),
    );
  }
}