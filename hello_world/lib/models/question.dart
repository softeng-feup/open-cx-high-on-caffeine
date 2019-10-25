import 'package:firebase_database/firebase_database.dart';


class Question {
  String key;
  String phrase;

  Question(this.phrase);

  Question.fromSnapshot(DataSnapshot snapshot)
      :key = snapshot.key,
       phrase = snapshot.value["phrase"];

  toJson() {
    return {
      "phrase": phrase,
    };
  }
}