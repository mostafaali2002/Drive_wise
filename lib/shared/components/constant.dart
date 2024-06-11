import 'package:firebase_database/firebase_database.dart';

abstract class Rating {
  static double rate = 0;
  static DatabaseReference ttestsref =
      FirebaseDatabase.instance.ref('drivers').child('driver_id_1');
}
