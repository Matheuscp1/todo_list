import 'package:flutter/material.dart';

class TodoListPage extends StatefulWidget {
  TodoListPage({Key? key}) : super(key: key);

  @override
  State<TodoListPage> createState() => _TodoListPageState();
}

class _TodoListPageState extends State<TodoListPage> {
  final TextEditingController _addController = TextEditingController();

  List<String> todo = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
          child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(mainAxisSize: MainAxisSize.min, children: [
          Row(children: [
            Expanded(
              child: TextField(
                controller: _addController,
                keyboardType: TextInputType.text,
                decoration: InputDecoration(
                    hoverColor: Color(0xff00d7f3),
                    prefixIcon: Icon(Icons.add_box),
                    focusedBorder: OutlineInputBorder(
                      borderSide:
                          BorderSide(color: Color(0xff00d7f3), width: 2.0),
                    ),
                    border: OutlineInputBorder(
                        borderSide:
                            BorderSide(width: 10, color: Color(0xff00d7f3))),
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
                print(todo);
                setState(() {
                  todo.add(text);
                });
              },
              style: ElevatedButton.styleFrom(
                  backgroundColor: Color(0xff00d7f3),
                  padding: EdgeInsets.all(14)),
              child: Icon(Icons.add, size: 30),
            )
          ]),
          SizedBox(
            height: 16,
          ),
          SizedBox(
            height: 200,
            child: ListView.builder(
                shrinkWrap: true,
                itemCount: todo.length,
                itemBuilder: (context, index) => ListTile(
                      title: Text(todo[index]),
                      style: ListTileStyle.list,
                      onTap: (() => print(todo[index])),
                    )),
          ),
          Row(
            children: [
              Expanded(child: Text('Você possui 0 tarefas pendentes')),
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
    );
  }
}
