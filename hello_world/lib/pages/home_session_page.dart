import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:hello_world/models/user.dart';
import 'package:hello_world/pages/create_profile_page.dart';
import '../services/authentication.dart';
import 'package:firebase_database/firebase_database.dart';
import 'questions_page.dart';
import 'rate_session_page.dart';
import 'questions_pageSpeaker.dart';
import 'rate_session_pageSpeaker.dart';

class HomeSessionPage extends StatefulWidget {
  HomeSessionPage({Key key, this.auth, this.userId, this.logoutCallback,  this.conferencekey, this.sessionkey, this.name, this.mode})
      : super(key: key);

  final BaseAuth auth;
  final VoidCallback logoutCallback;
  final String userId;
  final String conferencekey;
  final String sessionkey;
  final String name;
  final String mode;

  @override
  State<StatefulWidget> createState() => new _HomeSessionPageState(conferencekey: conferencekey, sessionkey: sessionkey,name: name, mode:mode );
}

class _HomeSessionPageState extends State<HomeSessionPage> {
  _HomeSessionPageState({ this.conferencekey, this.sessionkey, this.name, this.mode});

  final String conferencekey;
  final String sessionkey;
  final String name;
  final String mode;

User user = new User("", "", "", "");
  String result;
  DatabaseReference dataBaseRef;

  String _userId = "";
  final FirebaseDatabase _database = FirebaseDatabase.instance;
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  bool _isEmailVerified = false;

  String getname(){
      return name;
  }

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
    
    print("ssdasdasdsd");
    print(mode);
    print("ssdasdasdsd");
    if(mode == "p")
    return new Scaffold(
      appBar: new AppBar(
        title: new Text(getname()),
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
                          userId: _userId, auth: widget.auth, conferencekey: conferencekey, sessionkey: sessionkey, name:name)));
            },
          ),
          IconButton(
              iconSize: 100,
              tooltip: "Rate Session",
              icon: Icon(Icons.rate_review),
              onPressed: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => new RatePage(
                          userId: _userId, auth: widget.auth, conferencekey: conferencekey, sessionkey: sessionkey, name:name)));
            },
              ),
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
                "Rate Session",
                textScaleFactor: 2,
              )
            ])
      ]),
    );
    else if(mode == "s")
    return new Scaffold(
      appBar: new AppBar(
        title: new Text(getname()),
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
                      builder: (context) => new QuestionsPageSpeaker(
                          userId: _userId, auth: widget.auth, conferencekey: conferencekey, sessionkey: sessionkey, name:name)));
            },
          ),
          IconButton(
              iconSize: 100,
              tooltip: "Rate Session",
              icon: Icon(Icons.rate_review),
              onPressed: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => new RatePageSpeaker(
                          userId: _userId, auth: widget.auth, conferencekey: conferencekey, sessionkey: sessionkey, name:name)));
            },
              ),
        ]),
        Flex(
            direction: Axis.vertical,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text("\n\n"),
              Text(
                "Check Questions",
                textScaleFactor: 2,
              ),
              Text("\n\n\n\n"),
              Text(
                "Check Rate",
                textScaleFactor: 2,
              )
            ])
      ]),
    );
    else
      return null;
  }
}
