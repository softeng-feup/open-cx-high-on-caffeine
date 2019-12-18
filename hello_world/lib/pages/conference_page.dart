import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/material.dart';
import '../services/authentication.dart';
import 'package:firebase_database/firebase_database.dart';
import '../models/conference.dart';
import 'session_page.dart';

class ConferencePage extends StatefulWidget {
  ConferencePage({Key key, this.auth, this.userId, this.mode}) : super(key: key);

  final BaseAuth auth;
  final String userId;
   final String mode;

  @override
  State<StatefulWidget> createState() => new _ConferencePageState(mode: mode);
}

class _ConferencePageState extends State<ConferencePage> {
 _ConferencePageState({this.mode});

 final String mode;

  List<Conference> conferences = List();
  Conference conference;
  DatabaseReference conferenceRef;

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    conference = Conference("");

    final FirebaseDatabase database = FirebaseDatabase.instance;
    conferenceRef = database.reference().child('conferences');
    conferenceRef.onChildAdded.listen(_onEntryAdded);
    conferenceRef.onChildChanged.listen(_onEntryChanged);
    conferenceRef.onChildRemoved.listen(_onEntryRemoved);
  }

  _onEntryAdded(Event event) {
    setState(() {
      conferences.add(Conference.fromSnapshot(event.snapshot));
    });
  }

  _onEntryRemoved(Event event) {
    setState(() {
      var old = conferences.singleWhere((entry) {
        return entry.key == event.snapshot.key;
      });
      //conferences.remove(Conference.fromSnapshot(event.snapshot));
      conferences.removeAt(conferences.indexOf(old));
    });
  }

  _onEntryChanged(Event event) {
    var old = conferences.singleWhere((entry) {
      return entry.key == event.snapshot.key;
    });
    setState(() {
      conferences[conferences.indexOf(old)] = Conference.fromSnapshot(event.snapshot);
    });
  }

  Future handleSubmit() async {
    final FormState form = formKey.currentState;
    FirebaseUser userFirebase = await FirebaseAuth.instance.currentUser();
    conference.userName = userFirebase.email;
    if (form.validate()) {
      form.save();
      form.reset();
      conferenceRef.push().set(conference.toJson());
    }
  }


  String _userId = "";

  @override
  Widget build(BuildContext context) {
    print("ssdasdasdsd");
    print(mode);
    print("ssdasdasdsd");
    if(mode == "p")
    return new Scaffold(
      appBar: new AppBar(
        title: new Text('Choose a Conference'),
      ),
      body: Column(
        children: <Widget>[
          Flexible(
            child: FirebaseAnimatedList(
              query: conferenceRef,
              itemBuilder: (BuildContext context, DataSnapshot snapshot, Animation<double> animation, int index) {
                return new FlatButton(
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => new SessionPage(
                              userId: _userId, auth: widget.auth, conferencekey: conferences[index].key , mode: mode)));
                },
                /*color: Colors.orange,*/
                padding: EdgeInsets.all(20.0),
                child: Row( // Replace with a Row for horizontal icon + text
                  children: <Widget>[
                    Icon(Icons.adjust),
                    Text(conferences[index].phrase)
                  ],
                ),
              );
                

              },
            ),
          ),
        ],
      ),
    );
    else if(mode == "s")
    return new Scaffold(
      appBar: new AppBar(
        title: new Text('Choose a Conference'),
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
                        onSaved: (val) => conference.phrase = val,
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
              query: conferenceRef,
              itemBuilder: (BuildContext context, DataSnapshot snapshot, Animation<double> animation, int index) {
                return new FlatButton(
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => new SessionPage(
                              userId: _userId, auth: widget.auth, conferencekey: conferences[index].key , mode: mode)));
                },
                /*color: Colors.orange,*/
                padding: EdgeInsets.all(20.0),
                child: Row( // Replace with a Row for horizontal icon + text
                  children: <Widget>[
                    Icon(Icons.adjust),
                    Text(conferences[index].phrase)
                  ],
                ),
              );
                

              },
            ),
          ),
        ],
      ),
    );
    else
      return null;
  }
}
