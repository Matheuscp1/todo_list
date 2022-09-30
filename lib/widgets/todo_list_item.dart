import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:todo_list/model/Todo.dart';

class TodoListItem extends StatelessWidget {
  const TodoListItem({Key? key, required this.todo, required this.onDelete})
      : super(key: key);
  final Todo todo;
  final void Function(Todo todo) onDelete;
  @override
  Widget build(BuildContext context) {
    return Dismissible(
      key: ValueKey<Todo>(todo),
      direction: DismissDirection.endToStart,
      background: Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(4), color: Colors.red),
        margin: const EdgeInsets.symmetric(vertical: 5),
        padding: const EdgeInsets.all(16),
        alignment: Alignment.centerRight,
        child: Icon(Icons.delete),
      ),
      confirmDismiss: (direction) {
        return showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: const Text('Deseja deletar?'),
              actions: <Widget>[
                TextButton(
                  style: TextButton.styleFrom(
                    textStyle: Theme.of(context).textTheme.labelLarge,
                  ),
                  child: const Text('Voltar'),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
                TextButton(
                  style: TextButton.styleFrom(
                    foregroundColor: Colors.red,
                    textStyle: Theme.of(context).textTheme.labelLarge,
                  ),
                  child: const Text('Deletar'),
                  onPressed: () {
                    onDelete(todo);
                    Navigator.of(context).pop();
                  },
                ),
              ],
            );
          },
        );
      },
      child: Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(4), color: Colors.grey[200]),
        margin: const EdgeInsets.symmetric(vertical: 5),
        padding: const EdgeInsets.all(16),
        child:
            Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
          Text(
            DateFormat('dd/MM/yyyy HH:mm').format(todo.dateTime),
            style: TextStyle(fontSize: 12),
          ),
          Text(
            todo.title,
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
          )
        ]),
      ),
    );
  }
}
