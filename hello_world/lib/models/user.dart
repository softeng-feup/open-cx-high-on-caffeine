import 'package:firebase_database/firebase_database.dart';

class User{
  String key;
  String name;
  String country;
  String college;

  User(this.name, this.country, this.college);

  User.fromSnapshot(DataSnapshot snapshot)
    :key = snapshot.key,
    name = snapshot.value["name"],
    country = snapshot.value["country"],
    college = snapshot.value["college"];

    toJson(){
      return{
        "name": name,
        "country": country,
        "college": college,
      };
    }
}