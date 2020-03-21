import 'dart:convert';

import 'package:demo_app/todo.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.orange,
      ),
      home: MyHomePage(title: 'Todos'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final String API = 'https://jsonplaceholder.typicode.com/todos';
  bool _loading = false;
  List<Todo> _todos = [];

  @override
  void initState() {
    _loadTodos();
    super.initState();
  }

  Future<void> _loadTodos() async {
    setState(() {
      _loading = true;
    });

    http.Response response =
        await http.get(API);
    List body = json.decode(response.body);
    setState(() {
      _todos = body.map((todo) => Todo.fromJson(todo)).toList();
      _loading = false;
    });
  }

  List<ListTile> _renderItems() {
    return _todos.map((todo) {
      Icon icon = todo.completed
          ? Icon(Icons.check)
          : Icon(Icons.radio_button_unchecked);

      return ListTile(
          title: Text(todo.title),
          leading: GestureDetector(
            child: icon,
            onTap: () {
              setState(() {
                todo.completed = !todo.completed;
              });
            },
          ),
          subtitle: Text(todo.userId.toString()));
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text(
          widget.title,
          style: TextStyle(color: Colors.black38),
        ),
        leading: Center(
          child: Text(
            _todos.length.toString(),
            style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
          ),
        ),
      ),
      body: Center(
        child: _loading
            ? CircularProgressIndicator
            : ListView(
                children: _renderItems(),
              ),
      ),
    );
  }
}
