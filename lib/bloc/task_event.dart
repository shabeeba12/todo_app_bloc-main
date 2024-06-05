abstract class TodoEvent {}

class AddTodoEvent extends TodoEvent {
  final String title;

  AddTodoEvent(this.title);
}

class ToggleTodoCompletionEvent extends TodoEvent {
  final int index;

  ToggleTodoCompletionEvent(this.index);
}

class DeleteTodoEvent extends TodoEvent {
  final int index;
  DeleteTodoEvent(this.index);
}
