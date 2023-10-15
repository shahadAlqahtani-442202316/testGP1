import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:gp91/constants.dart';
import 'package:gp91/firebase_auth/user_repository/auth_repository.dart';
import 'package:gp91/on_boarding/on_boarding_screen.dart';
import 'package:gp91/screens/welcome_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp().then((value) => Get.put(AuthRepository()));
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    // Map<String, String> dataToSave = {'name': 'station1'};
    // FirebaseFirestore.instance.collection("Station").add(dataToSave);
    return GetMaterialApp(
      
      // IDK What's the point of this line.
      debugShowCheckedModeBanner: false,
      title: 'Flutter Auth',

      theme: ThemeData(
        // primaryColor: bkgPrimaryColor,
        scaffoldBackgroundColor: Colors.white,
      ),
      //WelcomeScreen()
      home: OnBoardingScreen(),
    );
  }
}

// class FirstRoute extends StatelessWidget {
//   const FirstRoute({Key? key});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('First Route'),
//       ),
//       body: Center(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: <Widget>[
//             ElevatedButton(
//               child: const Text('Afnan'),
//               onPressed: () {
//                 Navigator.push(
//                   context,
//                   MaterialPageRoute(builder: (context) => Body()),
//                 );
//               },
//             ),
//             ElevatedButton(
//               child: const Text('Rahaf'),
//               onPressed: () {
//                 // Handle Rahaf button click here
//                 // Navigator.push(
//                 //   context,
//                 //   MaterialPageRoute(builder: (context) => Body()),
//                 // );
//               },
//             ),
//             ElevatedButton(
//               child: const Text('Sara'),
//               onPressed: () {
//                 // Handle Sara button click here
//                 // Navigator.push(
//                 //   context,
//                 //   MaterialPageRoute(builder: (context) => Body()),
//                 // );
//               },
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
