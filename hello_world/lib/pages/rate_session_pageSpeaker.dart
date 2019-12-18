import 'dart:ffi';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/material.dart';
import '../services/authentication.dart';
import 'package:firebase_database/firebase_database.dart';
import '../models/conference.dart';

class RatePageSpeaker extends StatefulWidget {
  RatePageSpeaker({Key key, this.auth, this.userId, this.conferencekey, this.sessionkey, this.name}) : super(key: key);

  final BaseAuth auth;
  final String userId;
  final String conferencekey;
  final String sessionkey;
  final String name;

  @override
  State<StatefulWidget> createState() => new _RatePageSpeakerState(conferencekey: conferencekey, sessionkey: sessionkey,name: name );
}

class _RatePageSpeakerState extends State<RatePageSpeaker> {
  _RatePageSpeakerState({this.conferencekey, this.sessionkey, this.name});

  final String conferencekey;
  final String sessionkey;
  final String name;

  Rate rate;
  List<Rate> rates = List();
  DatabaseReference rateRef;

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  String getname(){
      return name;
  }

  int getrate(){
    if(rates.length > 0)
      return ((rates.map((m) => m.rate).reduce((a, b) => a + b))/rates.length).floor() ;
    else
      return 0;
  }

  @override
  void initState() {
    super.initState();
    rate = Rate(0);
    
    final FirebaseDatabase database = FirebaseDatabase.instance;
    rateRef = database.reference().child('conferences');
    rateRef = rateRef.child(conferencekey);
    rateRef = rateRef.child("sessions");
    rateRef = rateRef.child(sessionkey);
    rateRef = rateRef.child("rate");
    rateRef.onChildAdded.listen(_onEntryAdded);
    rateRef.onChildChanged.listen(_onEntryChanged);
    rateRef.onChildRemoved.listen(_onEntryRemoved);
  }

  _onEntryAdded(Event event) {
    setState(() {
      rates.add(Rate.fromSnapshot(event.snapshot));
    });
  }

  _onEntryRemoved(Event event) {
    setState(() {
      var old = rates.singleWhere((entry) {
        return entry.key == event.snapshot.key;
      });
      rates.removeAt(rates.indexOf(old));
    });
  }

  _onEntryChanged(Event event) {
    var old = rates.singleWhere((entry) {
      return entry.key == event.snapshot.key;
    });
    setState(() {
      rates[rates.indexOf(old)] = Rate.fromSnapshot(event.snapshot);
    });
  }

  Future handleSubmit() async {
    final FormState form = formKey.currentState;
    if (form.validate()) {
      form.save();
      form.reset();
      rateRef.push().set(rate.toJson());
    }
  }
  
  @override
  Widget build(BuildContext context) {
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
                    IconTheme(
                  data: IconThemeData(
                    color: Colors.amber,
                    size: 70,
                  ),
                  child: StarDisplay(value: getrate()  ),
                )
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class StarDisplay extends StatelessWidget {
  final int value;
  const StarDisplay({Key key, this.value = 0})
      : assert(value != null),
        super(key: key);
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: List.generate(5, (index) {
        return Icon(
          index < value ? Icons.star : Icons.star_border,
        );
      }),
    );
  }
}