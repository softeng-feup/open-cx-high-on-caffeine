import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../services/authentication.dart';
import 'package:firebase_database/firebase_database.dart';
import '../models/user.dart';

class CreateProfilePage extends StatefulWidget {
  CreateProfilePage({Key key, this.auth, this.userId, this.userReceived})
      : super(key: key);
  DatabaseReference dataBaseRef;
  final FirebaseDatabase _database = FirebaseDatabase.instance;

  final BaseAuth auth;
  final String userId;
  final User userReceived;
  @override
  State<StatefulWidget> createState() => new _CreateProfileState();
}

class _CreateProfileState extends State<CreateProfilePage> {
  DatabaseReference userRef;

  final FirebaseDatabase _database = FirebaseDatabase.instance;
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  User user;

  checkAlreadyExists() async {
    if (widget.userReceived.name == "" && widget.userReceived.country == "" && widget.userReceived.college == "" ) {
      FirebaseUser userFirebase = await FirebaseAuth.instance.currentUser();
      widget.dataBaseRef = _database.reference().child('Users').child(userFirebase.uid);
      widget.dataBaseRef.once().then((DataSnapshot snapshot) {
        Map<dynamic, dynamic> map = snapshot.value;
        widget.userReceived.college = map.values.toList()[0];
        widget.userReceived.country = map.values.toList()[1];
        widget.userReceived.name = map.values.toList()[2];
        print(widget.userReceived);
      });
    }
  }

  @override
  initState() {
    super.initState();
    user = User("", "", "", "");
    checkAlreadyExists();

    final FirebaseDatabase database = FirebaseDatabase.instance;

    userRef = database.reference().child('Users');
  }

  Future handleSubmit() async {
    final FormState form = formKey.currentState;

    if (form.validate()) {
      form.save();
      form.reset();
      FirebaseUser userFirebase = await FirebaseAuth.instance.currentUser();
      userRef.child(userFirebase.uid).set(user.toJson());
      Navigator.pop(context, user);
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
                        initialValue: widget.userReceived.name,
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
                        initialValue: widget.userReceived.country,
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
                        initialValue: widget.userReceived.college,
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
