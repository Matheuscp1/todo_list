import 'package:flutter/material.dart';
import 'package:todo_list/model/Todo.dart';
import 'package:todo_list/repository/todo_repository.dart';
import 'package:todo_list/widgets/todo_list_item.dart';

class TodoListPage extends StatefulWidget {
  const TodoListPage({Key? key}) : super(key: key);

  @override
  State<TodoListPage> createState() => _TodoListPageState();
}

class _TodoListPageState extends State<TodoListPage> {
  final TextEditingController _addController = TextEditingController();
  final TodoRepository todoRepository = TodoRepository();
  List<Todo> todo = [];

  @override
  void initState() {
    super.initState();

    todoRepository.getTodoList().then((value) {
      setState(() {
        todo = value;
      });
    });
  }

  void onDelete(Todo item) {
    int deletedTodoPos = todo.indexOf(item);
    setState(() {
      todo.remove(item);
    });
    todoRepository.saveTodoList(todo);
    ScaffoldMessenger.of(context).clearSnackBars();
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: SizedBox(
        height: 50,
        child: Text(
          'Tarefa ${item.title} foi removida!',
          style: TextStyle(color: Color(0xff060708)),
        ),
      ),
      backgroundColor: Colors.white,
      action: SnackBarAction(
        label: 'Desfazer',
        textColor: const Color(0xff00d7f3),
        onPressed: () {
          setState(() {
            todo.insert(deletedTodoPos, item);
          });
        },
      ),
      duration: const Duration(seconds: 5),
    ));
  }

  void onCreate() {
    String text = _addController.text;
    Todo todoItem = Todo(title: text);
    if (_addController.text.isNotEmpty) {
      setState(() {
        todo.add(todoItem);
        errorText = false;
      });
      _addController.clear();
      todoRepository.saveTodoList(todo);
    }
  }

  bool errorText = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
          child: Center(
              child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
            child: Column(mainAxisSize: MainAxisSize.min, children: [
              Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
                Expanded(
                  child: TextField(
                    textInputAction: TextInputAction.done,
                    onSubmitted: (value) => onCreate(),
                    controller: _addController,
                    keyboardType: TextInputType.text,
                    onChanged: (value) {
                      value == ''
                          ? setState(() {
                              errorText = true;
                            })
                          : setState(() {
                              errorText = false;
                            });
                    },
                    decoration: InputDecoration(
                        errorText: errorText ? 'Campo vazio' : null,
                        errorStyle: TextStyle(height: 0.5),
                        hoverColor: Color(0xff00d7f3),
                        prefixIcon: Icon(Icons.add_box),
                        focusedBorder: OutlineInputBorder(
                          borderSide:
                              BorderSide(color: Color(0xff00d7f3), width: 2.0),
                        ),
                        border: OutlineInputBorder(
                            borderSide: BorderSide(
                                width: 10, color: Color(0xff00d7f3))),
                        labelText: "Adicione uma tarefa",
                        hintText: "Todo"),
                  ),
                ),
                SizedBox(
                  width: 8,
                ),
                ElevatedButton(
                  onPressed: () {
                    FocusScope.of(context).unfocus();
                    onCreate();
                  },
                  style: ElevatedButton.styleFrom(
                      backgroundColor: Color(0xff00d7f3),
                      padding: EdgeInsets.all(14)),
                  child: Icon(Icons.add, size: 30),
                ),
              ]),
              SizedBox(
                height: 5,
              ),
              SizedBox(
                height: 630,
                child: ListView.builder(
                    itemCount: todo.length,
                    itemBuilder: (context, index) => TodoListItem(
                          todo: todo[(todo.length - 1) - index],
                          onDelete: onDelete,
                        )),
              ),
              SizedBox(
                height: 5,
              ),
              Row(
                children: [
                  Expanded(
                      child:
                          Text('Você possui ${todo.length} tarefas pendentes')),
                  SizedBox(
                    width: 8,
                  ),
                  ElevatedButton(
                      onPressed: () {
                        showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return AlertDialog(
                              title: const Text('Deseja deletar todos?'),
                              actions: <Widget>[
                                TextButton(
                                  style: TextButton.styleFrom(
                                    textStyle:
                                        Theme.of(context).textTheme.labelLarge,
                                  ),
                                  child: const Text('Voltar'),
                                  onPressed: () {
                                    Navigator.of(context).pop();
                                  },
                                ),
                                TextButton(
                                  style: TextButton.styleFrom(
                                    foregroundColor: Colors.red,
                                    textStyle:
                                        Theme.of(context).textTheme.labelLarge,
                                  ),
                                  child: const Text('Deletar'),
                                  onPressed: () {
                                    setState(() {
                                      todo.clear();
                                      todoRepository.saveTodoList(todo);
                                    });
                                    Navigator.of(context).pop();
                                  },
                                ),
                              ],
                            );
                          },
                        );
                      },
                      style: ElevatedButton.styleFrom(
                          backgroundColor: Color(0xff00d7f3),
                          padding: EdgeInsets.all(14)),
                      child: Text('Limpar tudo'))
                ],
              )
            ]),
          )),
        ),
      ),
    );
  }
}
// TodoListItem(todo: todo[(todo.length - 1) - index])