import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/material.dart';
import '../services/authentication.dart';
import 'package:firebase_database/firebase_database.dart';
import '../models/question.dart';

class QuestionsPage extends StatefulWidget {
  QuestionsPage({Key key, this.auth, this.userId, this.conferencekey, this.sessionkey, this.name, this.mode}) : super(key: key);

  final BaseAuth auth;
  final String userId;
  final String conferencekey;
  final String sessionkey;
  final String name;
  final String mode;

  @override
  State<StatefulWidget> createState() => new _QuestionsPageState(conferencekey: conferencekey, sessionkey: sessionkey,name: name, mode:mode );
}

class _QuestionsPageState extends State<QuestionsPage> {
  _QuestionsPageState({this.conferencekey, this.sessionkey, this.name, this.mode});

  final String conferencekey;
  final String sessionkey;
  final String name;
  final String mode;

  List<Question> questions = List();
  Question question;
  DatabaseReference questionRef;

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

   String getname(){
      return name;
  }

  @override
  void initState() {
    super.initState();
    question = Question("");

    final FirebaseDatabase database = FirebaseDatabase.instance;
    questionRef = database.reference().child('conferences');
    questionRef = questionRef.child(conferencekey);
    questionRef = questionRef.child("sessions");
    questionRef = questionRef.child(sessionkey);
    questionRef = questionRef.child("questions");
    questionRef.onChildAdded.listen(_onEntryAdded);
    questionRef.onChildChanged.listen(_onEntryChanged);
    questionRef.onChildRemoved.listen(_onEntryRemoved);
  }

  _onEntryAdded(Event event) {
    setState(() {
      questions.add(Question.fromSnapshot(event.snapshot));
    });
  }

  _onEntryRemoved(Event event) {
    setState(() {
      var old = questions.singleWhere((entry) {
        return entry.key == event.snapshot.key;
      });
      //questions.remove(Question.fromSnapshot(event.snapshot));
      questions.removeAt(questions.indexOf(old));
    });
  }

  _onEntryChanged(Event event) {
    var old = questions.singleWhere((entry) {
      return entry.key == event.snapshot.key;
    });
    setState(() {
      questions[questions.indexOf(old)] = Question.fromSnapshot(event.snapshot);
    });
  }

  Future handleSubmit() async {
    final FormState form = formKey.currentState;
    FirebaseUser userFirebase = await FirebaseAuth.instance.currentUser();
    question.userName = userFirebase.email;
    if (form.validate()) {
      form.save();
      form.reset();
      questionRef.push().set(question.toJson());
    }
  }

  @override
  Widget build(BuildContext context) {
    print("ssdasdasdsd");
    print(mode);
    print("ssdasdasdsd");
    if(mode == "p")
    return new Scaffold(
      appBar: new AppBar(
        title: new Text(getname()),
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
                        onSaved: (val) => question.phrase = val,
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
              query: questionRef,
              itemBuilder: (BuildContext context, DataSnapshot snapshot,
                  Animation<double> animation, int index) {
                return new ListTile(
                  leading: Icon(Icons.message),
                  title: Text(questions[index].phrase),
                  subtitle: Text(questions[index].userName),
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
        title: new Text(getname()),
      ),
      body: Column(
        children: <Widget>[
          Flexible(
            child: FirebaseAnimatedList(
              query: questionRef,
              itemBuilder: (BuildContext context, DataSnapshot snapshot,
                  Animation<double> animation, int index) {
                return new ListTile(
                  leading: Icon(Icons.message),
                  title: Text(questions[index].phrase),
                  subtitle: Text(questions[index].userName),
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
