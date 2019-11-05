import 'package:firebase_database/firebase_database.dart';


class Question {
  String userName;
  String key;
  String phrase;

  Question(this.phrase);

  Question.fromSnapshot(DataSnapshot snapshot)
      :key = snapshot.key,
       phrase = snapshot.value["phrase"],
       userName = snapshot.value["userName"];

  toJson() {
    return {
      "userName": userName,
      "phrase": phrase
    };
  }
}