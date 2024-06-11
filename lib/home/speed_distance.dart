import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:our_project_1/provider/provider.dart';
import 'package:our_project_1/shared/components/constant.dart';
import 'package:provider/provider.dart';

class Speed_distance extends StatefulWidget {
  static const String routeName = "Speed_distance";
  const Speed_distance({super.key});

  @override
  State<Speed_distance> createState() => _Speed_distanceState();
}

class _Speed_distanceState extends State<Speed_distance> {
  String speedsvalue = '0';
  String distancesvalue = '0';

  final Future<FirebaseApp> fApps = Firebase.initializeApp();
  @override
  Widget build(BuildContext context) {
    DatabaseReference testsref = FirebaseDatabase.instance
        .ref('drivers')
        .child('driver_id_1')
        .child('vehicle');

    Rating.ttestsref.onValue.listen((event) {
      setState(() {
        Rating.rate =
            double.parse(event.snapshot.child('rating').value.toString());
      });
    });

    testsref.onValue.listen(
      (event) {
        setState(() {
          speedsvalue = event.snapshot.child('current_speed').value.toString();

          distancesvalue =
              event.snapshot.child('current_distance').value.toString();
        });
      },
    );
    return Consumer<UserState>(builder: (context, userState, _) {
      return Scaffold(
          appBar: AppBar(
            toolbarHeight: 100,
            backgroundColor: const Color.fromRGBO(29, 29, 29, 1),
            leading: IconButton(
                icon: const Icon(
                  Icons.arrow_back,
                  size: 60,
                ),
                onPressed: () {
                  Navigator.pop(context);
                }),
            actions: [
              Column(
                children: [
                  Text(
                    ' ${userState.username}',
                    style: const TextStyle(fontSize: 30, color: Colors.white),
                  ),
                  GetRating(rate: Rating.rate),
                ],
              ),
              CircleAvatar(
                radius: 70.0,
                child: Image.asset('images/profile.png'),
              ),
            ],
          ),
          backgroundColor: const Color.fromRGBO(0, 0, 0, 1),
          body: FutureBuilder(
            future: fApps,
            builder: (context, snapshot) {
              if (snapshot.hasError) {
                return const Text("something wrong");
              } else if (snapshot.hasData) {
                return body(
                    speedsvalue: speedsvalue, distancesvalue: distancesvalue);
              } else {
                return const CircularProgressIndicator();
              }
            },
          ));
    });
  }
}

class GetRating extends StatelessWidget {
  const GetRating({
    super.key,
    required this.rate,
  });

  final double rate;

  @override
  Widget build(BuildContext context) {
    return Row(children: [
      if (rate == 0 || rate <= 1.9) ...[
        Icon(Icons.star, color: Colors.amber, size: 40),
        Icon(Icons.star, color: Colors.grey, size: 40),
        Icon(Icons.star, color: Colors.grey, size: 40),
        Icon(Icons.star, color: Colors.grey, size: 40),
        Icon(Icons.star, color: Colors.grey, size: 40),
      ] else if (rate == 2 || rate <= 2.9) ...[
        Icon(Icons.star, color: Colors.amber, size: 40),
        Icon(Icons.star, color: Colors.amber, size: 40),
        Icon(Icons.star, color: Colors.grey, size: 40),
        Icon(Icons.star, color: Colors.grey, size: 40),
        Icon(Icons.star, color: Colors.grey, size: 40),
      ] else if (rate == 3 || rate <= 3.9) ...[
        Icon(Icons.star, color: Colors.amber, size: 40),
        Icon(Icons.star, color: Colors.amber, size: 40),
        Icon(Icons.star, color: Colors.amber, size: 40),
        Icon(Icons.star, color: Colors.grey, size: 40),
        Icon(Icons.star, color: Colors.grey, size: 40),
      ] else if (rate == 4 || rate <= 4.5) ...[
        Icon(Icons.star, color: Colors.amber, size: 40),
        Icon(Icons.star, color: Colors.amber, size: 40),
        Icon(Icons.star, color: Colors.amber, size: 40),
        Icon(Icons.star, color: Colors.amber, size: 40),
        Icon(Icons.star, color: Colors.grey, size: 40),
      ] else if (rate == 4.6 || rate <= 5) ...[
        Icon(Icons.star, color: Colors.amber, size: 40),
        Icon(Icons.star, color: Colors.amber, size: 40),
        Icon(Icons.star, color: Colors.amber, size: 40),
        Icon(Icons.star, color: Colors.amber, size: 40),
        Icon(Icons.star, color: Colors.amber, size: 40),
      ]
    ]);
  }
}

class body extends StatelessWidget {
  const body({
    super.key,
    required this.speedsvalue,
    required this.distancesvalue,
  });

  final String speedsvalue;
  final String distancesvalue;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 400, top: 20),
      child: Column(
        children: [
          Stack(
            children: [
              const Image(
                image: AssetImage('images/speed.jpg'),
                width: 380.0,
              ),
              Positioned.fill(
                  child: Align(
                alignment: Alignment.center,
                child: Text(
                  '$speedsvalue',
                  style: const TextStyle(
                      color: Colors.white,
                      fontSize: 140.0,
                      fontStyle: FontStyle.normal,
                      fontFamily: 'Teko'),
                ),
              )),
            ],
          ),
          const SizedBox(
            height: 10.0,
          ),
          const Image(
            image: AssetImage('images/smallcar.jpg'),
          ),
          const SizedBox(
            height: 15.0,
          ),
          const Text(
            'Distance',
            style: TextStyle(
              color: Color.fromRGBO(248, 31, 75, 1),
              fontSize: 50.0,
            ),
          ),
          const SizedBox(
            height: 10.0,
          ),
          Text(
            ' $distancesvalue m',
            style: const TextStyle(
              color: Colors.white,
              fontSize: 35.0,
            ),
          )
        ],
      ),
    );
  }
}
