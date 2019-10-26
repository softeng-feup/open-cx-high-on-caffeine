import 'dart:isolate';

import 'package:flutter/material.dart';
import '../services/authentication.dart';
import 'package:firebase_database/firebase_database.dart';
import '../models/user.dart';

class CreateProfilePage extends StatefulWidget {
  CreateProfilePage({Key key, this.auth, this.userId,this.user_received}) : super(key: key);

  final BaseAuth auth;
  final String userId;
  final User user_received;
  @override
  State<StatefulWidget> createState() => new _CreateProfileState();
}

class _CreateProfileState extends State<CreateProfilePage> {
  DatabaseReference userRef;

  final FirebaseDatabase _database = FirebaseDatabase.instance;
    final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final _textEditingController = TextEditingController();

  User user;

  @override
  void initState() {
    super.initState();
    user = User("", "", "");

    final FirebaseDatabase database = FirebaseDatabase.instance;
    userRef = database.reference().child('Users');
  }

  void handleSubmit() {
    final FormState form = formKey.currentState;

    if (form.validate()) {
      form.save();
      form.reset();
      userRef.push().set(user.toJson());
      Navigator.pop(context,user);
      
    }
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text('High on Caffeine'),
      ),
      body: Column(
        children: <Widget>[
          Flexible(
            flex: 0,
            child: Center(
              child: Form(
                key: formKey,
                child: Flex(
                  direction: Axis.vertical,
                  children: <Widget>[
                    ListTile(
                      leading: Text(
                        "Name",
                        textScaleFactor: 2,
                        textAlign: TextAlign.center,
                      ),
                      title: TextFormField(
                        initialValue: widget.user_received.name,
                        onSaved: (val) => user.name = val,
                      ),
                    ),
                    ListTile(
                      leading: Text(
                        "Country",
                        textScaleFactor: 2,
                        textAlign: TextAlign.center,
                      ),
                      title: TextFormField(
                        initialValue: widget.user_received.country,
                        onSaved: (val) => user.country = val,
                      ),
                    ),
                    ListTile(
                      leading: Text(
                        "College",
                        textScaleFactor: 2,
                        textAlign: TextAlign.center,
                      ),
                      title: TextFormField(
                        initialValue: widget.user_received.college,
                        onSaved: (val) => user.college = val,
                      ),
                    ),
                    IconButton(
                      icon: Icon(Icons.send),
                      onPressed: () {
                        handleSubmit();
                      },
                    ),
                  ],
                ),
              ),
            ),
          ),
          /*Flexible(
            child: FirebaseAnimatedList(
              query: questionRef,
              itemBuilder: (BuildContext context, DataSnapshot snapshot,
                  Animation<double> animation, int index) {
                return new ListTile(
                  leading: Icon(Icons.message),
                  title: Text(questions[index].phrase),
                );
              },
            ),
          ),*/
        ],
      ),
    );
  }
}
