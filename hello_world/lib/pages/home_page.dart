import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:hello_world/models/user.dart';
import 'package:hello_world/pages/create_profile_page.dart';
import '../services/authentication.dart';
import 'package:firebase_database/firebase_database.dart';
import 'questions_page.dart';

class HomePage extends StatefulWidget {
  HomePage({Key key, this.auth, this.userId, this.logoutCallback})
      : super(key: key);

  final BaseAuth auth;
  final VoidCallback logoutCallback;
  final String userId;

  @override
  State<StatefulWidget> createState() => new _HomePageState();
}

class _HomePageState extends State<HomePage> {
  User user = new User("", "", "", "");
  String result;
  DatabaseReference dataBaseRef;

  String _userId = "";
  final FirebaseDatabase _database = FirebaseDatabase.instance;
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  bool _isEmailVerified = false;

  void logoutCallback() {
    setState(() {
      _userId = "";
    });
  }

  @override
  void initState() {
    super.initState();

    //_checkEmailVerification();
  }

  void _checkEmailVerification() async {
    _isEmailVerified = await widget.auth.isEmailVerified();
    if (!_isEmailVerified) {
      _showVerifyEmailDialog();
    }
  }

  void _resentVerifyEmail() {
    widget.auth.sendEmailVerification();
    _showVerifyEmailSentDialog();
  }

  void _showVerifyEmailDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        // return object of type Dialog
        return AlertDialog(
          title: new Text("Verify your account"),
          content: new Text("Please verify account in the link sent to email"),
          actions: <Widget>[
            new FlatButton(
              child: new Text("Resent link"),
              onPressed: () {
                Navigator.of(context).pop();
                _resentVerifyEmail();
              },
            ),
            new FlatButton(
              child: new Text("Dismiss"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  void _showVerifyEmailSentDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        // return object of type Dialog
        return AlertDialog(
          title: new Text("Verify your account"),
          content:
              new Text("Link to verify account has been sent to your email"),
          actions: <Widget>[
            new FlatButton(
              child: new Text("Dismiss"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  signOut() async {
    try {
      await widget.auth.signOut();
      widget.logoutCallback();
    } catch (e) {
      print(e);
    }
  }

  checkAlreadyExists() async {
    FirebaseUser userFirebase = await FirebaseAuth.instance.currentUser();
    dataBaseRef = _database.reference().child('Users').child(userFirebase.uid);
    dataBaseRef.once().then((DataSnapshot snapshot) {
      Map<dynamic, dynamic> map = snapshot.value;
      user.college = map.values.toList()[0];
      user.country = map.values.toList()[1];
      user.name = map.values.toList()[2];
      print(user);
    });
  }

  @override
  Widget build(BuildContext context) {
    checkAlreadyExists();
    return new Scaffold(
      appBar: new AppBar(
        title: new Text('High on Caffeine'),
        actions: <Widget>[
          new FlatButton(
              child: new Text('Logout',
                  style: new TextStyle(fontSize: 17.0, color: Colors.white)),
              onPressed: signOut)
        ],
      ),
      body: new Row(children: <Widget>[
        Flex(direction: Axis.vertical, children: <Widget>[
          IconButton(
            iconSize: 100,
            tooltip: "Questions",
            icon: Icon(Icons.question_answer),
            onPressed: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => new QuestionsPage(
                          userId: _userId, auth: widget.auth)));
            },
          ),
          IconButton(
              iconSize: 100,
              tooltip: "Edit Profile",
              icon: Icon(Icons.assignment_ind),
              onPressed: () async {
                User auxUser = await Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => new CreateProfilePage(
                              userId: _userId,
                              auth: widget.auth,
                              userReceived: user,
                            )));
                if (auxUser != null) user = auxUser;
              }),
        ]),
        Flex(
            direction: Axis.vertical,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text("\n\n"),
              Text(
                "Ask Questions",
                textScaleFactor: 2,
              ),
              Text("\n\n\n\n"),
              Text(
                "Edit Profile",
                textScaleFactor: 2,
              )
            ])
      ]),
    );
  }
}
