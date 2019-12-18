import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/material.dart';
import '../services/authentication.dart';
import 'package:firebase_database/firebase_database.dart';
import '../models/conference.dart';
import 'home_session_page.dart';

class SessionPage extends StatefulWidget {
  SessionPage({Key key, this.auth, this.userId, this.conferencekey, this.mode}) : super(key: key);

  final BaseAuth auth;
  final String userId;
  final String conferencekey;
  final String mode;

  @override
  State<StatefulWidget> createState() => new _SessionPageState(conferencekey: conferencekey, mode: mode);
}

class _SessionPageState extends State<SessionPage> {
  _SessionPageState({this.conferencekey, this.mode});

  final String conferencekey;
  final String mode;

  List<Session> sessions = List();
  Session session;
  DatabaseReference sessionRef;

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  int modeP(){
    if(mode == "p")
      return 1;
    else
      return 0;
  }

  @override
  void initState() {
    super.initState();
    session = Session("");

    final FirebaseDatabase database = FirebaseDatabase.instance;
    sessionRef = database.reference().child('conferences');
    sessionRef = sessionRef.child(conferencekey);
    sessionRef = sessionRef.child("sessions");
    sessionRef.onChildAdded.listen(_onEntryAdded);
    sessionRef.onChildChanged.listen(_onEntryChanged);
    sessionRef.onChildRemoved.listen(_onEntryRemoved);
  }

  _onEntryAdded(Event event) {
    setState(() {
      sessions.add(Session.fromSnapshot(event.snapshot));
    });
  }

  _onEntryRemoved(Event event) {
    setState(() {
      var old = sessions.singleWhere((entry) {
        return entry.key == event.snapshot.key;
      });
      //sessions.remove(Session.fromSnapshot(event.snapshot));
      sessions.removeAt(sessions.indexOf(old));
    });
  }

  _onEntryChanged(Event event) {
    var old = sessions.singleWhere((entry) {
      return entry.key == event.snapshot.key;
    });
    setState(() {
      sessions[sessions.indexOf(old)] = Session.fromSnapshot(event.snapshot);
    });
  }

  Future handleSubmit() async {
    final FormState form = formKey.currentState;
    FirebaseUser userFirebase = await FirebaseAuth.instance.currentUser();
    session.userName = userFirebase.email;
    if (form.validate()) {
      form.save();
      form.reset();
      sessionRef.push().set(session.toJson());
    }
  }




  String _userId = "";

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text('Choose a Session'),
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
                      leading: Icon(Icons.info),
                      title: TextFormField(
                        initialValue: "",
                        onSaved: (val) => session.phrase = val,
                        validator: (val) => val == "" ? val : null,
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
          Flexible(
            child: FirebaseAnimatedList(
              query: sessionRef,
              itemBuilder: (BuildContext context, DataSnapshot snapshot, Animation<double> animation, int index) {
                return new FlatButton(
                onPressed: () {
                  Navigator.push(
                      context,
            
                      MaterialPageRoute( 
                          builder: (context) => new HomeSessionPage(
                              userId: _userId, auth: widget.auth,  conferencekey: conferencekey, sessionkey: sessions[index].key, name:sessions[index].phrase, mode: mode)));
                },
                padding: EdgeInsets.all(20.0),
                child: Row( // Replace with a Row for horizontal icon + text
                  children: <Widget>[
                    Icon(Icons.adjust),
                    Text(sessions[index].phrase)
                  ],
                ),
              );
               
              },
            ),
          ),
        ],
      ),
    );
  }
}
