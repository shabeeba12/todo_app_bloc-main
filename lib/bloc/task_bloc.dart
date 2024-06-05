import 'package:bloc/bloc.dart';
import 'package:todo_app/bloc/task_event.dart';
import 'package:todo_app/bloc/task_state.dart';
import 'package:todo_app/main.dart';
import 'package:todo_app/model.dart';



class TodoBloc extends Bloc<TodoEvent, TodoState> {
  TodoBloc() : super(TodoState([])) {
    on<AddTodoEvent>(_addTodo);
    on<ToggleTodoCompletionEvent>(_toggleTodoCompletion);
    on<DeleteTodoEvent>(_deleteTodo);
  }

  void _addTodo(AddTodoEvent event, Emitter<TodoState> emit) {
    List<Todo> updatedTodos = List.from(state.todos);
    updatedTodos.add(Todo(title: event.title));
    emit(TodoState(updatedTodos));
  }

  void _toggleTodoCompletion(
      ToggleTodoCompletionEvent event, Emitter<TodoState> emit) {
    List<Todo> updatedTodos = List.from(state.todos);
    updatedTodos[event.index] = Todo(
      title: updatedTodos[event.index].title,
      isCompleted: !updatedTodos[event.index].isCompleted,
    );
    emit(TodoState(updatedTodos));
  }

  void _deleteTodo(DeleteTodoEvent event, Emitter<TodoState> emit) {
    List<Todo> updatedTodos = List.from(state.todos);
    updatedTodos.removeAt(event.index);
    emit(TodoState(updatedTodos));
  }
}