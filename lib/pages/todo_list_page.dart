import 'package:flutter/material.dart';

class TodoListPage extends StatelessWidget {
  TodoListPage({Key? key}) : super(key: key);

  final TextEditingController _addControle = TextEditingController();
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
                controller: _addControle,
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
              onPressed: () => {},
              style: ElevatedButton.styleFrom(
                  backgroundColor: Color(0xff00d7f3),
                  padding: EdgeInsets.all(14)),
              child: Icon(Icons.add, size: 30),
            )
          ]),
          SizedBox(
            height: 16,
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
