import 'dart:ffi';

import 'package:firebase_database/firebase_database.dart';


class Conference {
  String userName;
  String key;
  String phrase;

  Conference(this.phrase);

  Conference.fromSnapshot(DataSnapshot snapshot)
      :key = snapshot.key,
       phrase = snapshot.value["phrase"],
       userName = snapshot.value["userName"];

  toJson() {
    return {
      "userName": userName,
      "phrase": phrase,
     
    };
  }
}

class Session {
  String userName;
  String key;
  String phrase;

  Session(this.phrase);

  Session.fromSnapshot(DataSnapshot snapshot)
      :key = snapshot.key,
       userName = snapshot.value["userName"],
       phrase = snapshot.value["phrase"];

  toJson() {
    return {
      "userName": userName,
      "phrase": phrase
    };
  }
}

class Rate {
  int rate;
  String key;

  Rate(this.rate);

  Rate.fromSnapshot(DataSnapshot snapshot)
      :key = snapshot.key,
      rate = snapshot.value["rate"];
      

  toJson() {
    return {
      "rate": rate
    };
  }
}