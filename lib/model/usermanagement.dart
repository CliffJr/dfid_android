import 'package:dfidmobilen/Screens/Login/login_screen.dart';
import 'package:dfidmobilen/Screens/Welcome/welcome_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class UserManagement {
  FirebaseAuth auth = FirebaseAuth.instance;

  Widget handleAuth() {
    return new StreamBuilder(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (BuildContext context, snapshot) {
        if (snapshot.hasData) {
          return WelcomeScreen();
        }
        return LoginScreen();
      },
    );
  }
//  authorizeAdmin(BuildContext context) {
//     FirebaseAuth.instance.currentUser().then((user) {
//       Firestore.instance
//           .collection('users')
//           .where('uid', isEqualTo: user.uid)
//           .getDocuments()
//           .then((docs) {
//         if (docs.documents[0].exists) {
//           if (docs.documents[0].data['role'] == 'admin') {
//             Navigator.push(
//                 context,
//                 new MaterialPageRoute(
//                     builder: (BuildContext context) => new AdminPage()));
//           } else {
//             print('Not Authorized');
//           }
//         }
//       });
//     });
//   }

  currentStaff() {
    if (auth.currentUser != null) {
      print(auth.currentUser.uid);
    } else {
      print('no user');
    }
  }

  registerUser() async {
    try {
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: "jayara@gmail.com", password: "SuperSecretPassword!");
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        print('The password provided is too weak.');
      } else if (e.code == 'email-already-in-use') {
        print('The account already exists for that email.');
      }
    } catch (e) {
      print(e);
    }
  }

  signIn() async {
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: "barry.allen@example.com", password: "SuperSecretPassword!");
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        print('No user found for that email.');
      } else if (e.code == 'wrong-password') {
        print('Wrong password provided for that user.');
      }
    }
  }

  signOut() {
    FirebaseAuth.instance.signOut();
  }
}
