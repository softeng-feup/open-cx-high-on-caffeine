import 'package:firebase_database/firebase_database.dart';

class User{
  String key;
  String name;
  String country;
  String college;
  String uid;

  User(this.name, this.country, this.college,this.uid);

  User.fromSnapshot(DataSnapshot snapshot)
    :key = snapshot.key,
    name = snapshot.value["name"],
    country = snapshot.value["country"],
    college = snapshot.value["college"],
    uid =snapshot.value["uid"];

    toJson(){
      return{
        "name": name,
        "country": country,
        "college": college,
      };
    }
}