import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/material.dart';
import '../services/authentication.dart';
import 'package:firebase_database/firebase_database.dart';
import 'dart:async';
import '../models/user.dart';

class CreateProfilePage extends StatefulWidget {
  CreateProfilePage({Key key, this.auth, this.userId}) : super(key: key);

  final BaseAuth auth;
  final String userId;
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
                        initialValue: "",
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
                        initialValue: "",
                        onSaved: (val) => user.country = val,
                      ),
                    ),
                    ListTile(
                      leading: Text(
                        "college",
                        textScaleFactor: 2,
                        textAlign: TextAlign.center,
                      ),
                      title: TextFormField(
                        initialValue: "",
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
