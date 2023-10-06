import 'package:flutter/material.dart';
import 'package:gp91/constants.dart';
import 'package:gp91/login/components/already_have_an_account_acheck.dart';
import 'package:gp91/login/components/rounded_button.dart';
import 'package:gp91/login/components/rounded_input_field.dart';
import 'package:gp91/login/components/rounded_password_field.dart';
import 'package:gp91/login/login.dart';
import 'package:gp91/signup/components/background.dart';

class Body extends StatelessWidget {
  final Widget child;
  const Body({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Background(
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              "SIGN UP",
              style: TextStyle(
                fontSize: 20,
                fontFamily: 'NanumGothic',
                fontWeight: FontWeight.bold,
                color: primaryColor,
              ),
            ),
            Image.asset(
              "assets/images/logo_no_bkg.png",
              width: size.width,
              height: size.height * 0.3,
            ),
            RoundedInputField(
              hintText: "Name",
              onChanged: (value) {},
            ),
            RoundedInputField(
              hintText: "Email",
              onChanged: (value) {},
              icon: Icons.email,
            ),
            RoundedPasswordField(
              onChanged: (value) {},
            ),
            RoundedPasswordField(
              onChanged: (value) {},
              hintText: "Confirm Password",
            ),
            RoundedButton(
              text: "SIGN UP",
              // Go to the home page
              press: () {},
            ),
            AlreadyHaveAnAcoountCheck(
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
          ],
        ),
      ),
    );
  }
}
