import 'package:dfidmobilen/Screens/Dashboard/dashboard.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:dfidmobilen/Screens/Login/login_screen.dart';
import 'package:dfidmobilen/Screens/Signup/components/background.dart';
import 'package:dfidmobilen/Screens/Signup/components/or_divider.dart';
import 'package:dfidmobilen/components/already_have_an_account_acheck.dart';
import 'package:dfidmobilen/components/rounded_button.dart';
import 'package:dfidmobilen/components/rounded_input_field.dart';
import 'package:dfidmobilen/components/rounded_password_field.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_svg/svg.dart';
// import 'package:firebase_dynamic_links/firebase_dynamic_links.dart';

class Body extends StatefulWidget {
  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
  // ignore: unused_field
  bool _success;
  String email;
  String password;
  FirebaseAuth auth = FirebaseAuth.instance;

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Background(
      child: Form(
        key: _formKey,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              "SIGNUP",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            SizedBox(height: size.height * 0.03),
            SvgPicture.asset(
              "assets/icons/signup.svg",
              height: size.height * 0.35,
            ),
            RoundedInputField(
              controller: _emailController,
              hintText: "Your Email",
              onChanged: (value) {
                email = value;
              },
            ),
            RoundedPasswordField(
              controller: _passwordController,
              onChanged: (value) {
                password = value;
              },
            ),
            RoundedButton(
              text: "SIGNUP",
              press: () {
                // if (_formKey.currentState.validate()) {
                //   _signUp();
                // }
                if (email == 'cliffordjmthembu@gmail.com') {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) {
                        return Dashboard();
                      },
                    ),
                  );
                }
              },
            ),
            SizedBox(height: size.height * 0.03),
            AlreadyHaveAnAccountCheck(
              login: false,
              press: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) {
                      return LoginScreen();
                    },
                  ),
                );
              },
            ),
            OrDivider(),
          ],
        ),
      ),
    );
  }

  // void _signUp() async {
  //   final User result = (await auth.createUserWithEmailAndPassword(
  //           email: _emailController.text, password: _passwordController.text))
  //       .user;

  //   if (result != null) {
  //     setState(() {
  //       _success = true;
  //       email = result.email;
  //     });
  //   } else {
  //     setState(() {
  //       _success = true;
  //     });
  //   }
  // }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }
  //end
}
