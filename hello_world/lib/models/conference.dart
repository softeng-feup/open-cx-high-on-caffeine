import 'package:firebase_database/firebase_database.dart';

class Conference{
  String theme;
  String start;
  String place;
  String speakerName;

  Conference(this.theme, this.start, this.place,this.speakerName);

  Conference.fromSnapshot(DataSnapshot snapshot)
    :theme = snapshot.value["theme"],
    start = snapshot.value["start"],
    place = snapshot.value["place"],
    speakerName =snapshot.value["speakerName"];

    toJson(){
      return{
        "theme": theme,
        "start": start,
        "place": place,
        "speakerName": speakerName,
      };
    }
}