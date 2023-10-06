import 'package:flutter/material.dart';
import 'package:gp91/login/components/already_have_an_account_acheck.dart';
import 'package:gp91/login/components/background.dart';
import 'package:gp91/constants.dart';
import 'package:gp91/login/components/rounded_button.dart';
import 'package:gp91/login/components/rounded_input_field.dart';
import 'package:gp91/login/components/rounded_password_field.dart';

class Body extends StatelessWidget {
  const Body({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Background(
      // child: SingleChildScrollView(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          const Text(
            "Welcome Back!",
            style: TextStyle(
                fontSize: 20,
                fontFamily: 'NanumGothic',
                fontWeight: FontWeight.bold,
                color: primaryColor),
          ),
          SizedBox(height: size.height * 0.03),
          Image.asset(
            "assets/images/logo_no_bkg.png",
            width: size.width,
            height: size.height * 0.3,
          ),
          RoundedInputField(
            hintText: "Your Email",
            onChanged: (value) {},
          ),
          RoundedPasswordField(
            onChanged: (value) {},
          ),
          SizedBox(
            height: size.height * 0.01,
          ),
          RoundedButton(
            text: "LOGIN",
            press: () {},
          ),
          SizedBox(
            height: size.height * 0.03,
          ),
          AlreadyHaveAnAcoountCheck(
            press: () {},
          ),
        ],
      ),
    );
    // );
  }
}
