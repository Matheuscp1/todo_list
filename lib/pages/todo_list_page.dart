import 'package:flutter/material.dart';
import 'package:todo_list/model/Todo.dart';
import 'package:todo_list/widgets/todo_list_item.dart';

class TodoListPage extends StatefulWidget {
  TodoListPage({Key? key}) : super(key: key);

  @override
  State<TodoListPage> createState() => _TodoListPageState();
}

class _TodoListPageState extends State<TodoListPage> {
  final TextEditingController _addController = TextEditingController();

  List<Todo> todo = [];

  void onDelete(Todo item) {
    setState(() {
      todo.remove(item);
    });
  }

  bool errorText = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Center(
              child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
            child: Column(mainAxisSize: MainAxisSize.min, children: [
              Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
                Expanded(
                  child: TextField(
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
                    String text = _addController.text;
                    Todo todoItem = Todo(title: text);
                    print(todo);
                    if (_addController.text.isNotEmpty) {
                      setState(() {
                        todo.add(todoItem);
                      });
                      _addController.text = '';
                    }
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
                      onPressed: () {},
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