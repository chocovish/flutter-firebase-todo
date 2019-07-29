import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'AddTodo.dart' show AddToDo;

var email;

class Home extends StatelessWidget {
  Home(String e) {
    email = e;
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
          body: SafeArea(child: Body()),
          floatingActionButton: Builder(
            builder: (context) {
              return FloatingActionButton.extended(
                label: Text("Add Todo"),
                onPressed: () {
                  showDialog(
                      context: context,
                      // builder: (context) {
                      //   return AddToDo();
                      // }
                      builder: (_) => AddToDo());
                },
              );
            },
          )),
    );
  }
}

final fi = Firestore.instance;
TextEditingController tc;

DateTime selectedDate;
TimeOfDay selectedTime;

class Body extends StatefulWidget {
  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
  @override
  void initState() {
    super.initState();
    tc = TextEditingController();
  }

  @override
  void dispose() {
    tc.dispose();
    super.dispose();
  }

  Stream getData() {
    return fi.collection("todos").where("email", isEqualTo: email).snapshots();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              email,
              style: TextStyle(fontSize: 28, fontWeight: FontWeight.w700),
            ),
          ),
          Expanded(
            child: StreamBuilder(
              stream: getData(),
              builder: (BuildContext context, AsyncSnapshot snapshot) {
                if (snapshot.hasError) return Text(snapshot.error);
                if (!snapshot.hasData)
                  return Container(
                      alignment: Alignment.center,
                      child: CircularProgressIndicator());
                List<DocumentSnapshot> todos = snapshot.data.documents;
                return Container(
                  child: ListView(
                      children: todos.map((todo) {
                    return todoview(todos, todo);
                  }).toList()),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Container todoview(List<DocumentSnapshot> todos, DocumentSnapshot todo) {
    return Container(
      margin: EdgeInsets.all(5),
      decoration: BoxDecoration(
          color: Colors.lightBlueAccent,
          borderRadius: BorderRadius.circular(6)),
      child: ListTile(
        leading:
            CircleAvatar(child: Text((todos.indexOf(todo) + 1).toString())),
        title: Text(
          todo["task"],
          style: TextStyle(
              fontWeight: todo["completed"] ?? false ? FontWeight.bold : null),
        ),
        subtitle: todo["completed"] ? Text("Completed") : null,
        trailing: IconButton(
          icon: Icon(Icons.delete_sweep),
          onPressed: todo.reference.delete,
        ),
        onLongPress: () {
          print(todo.reference.delete());
        },
        onTap: () {
          todo.reference.updateData({"completed": true});
        },
      ),
    );
  }
}
