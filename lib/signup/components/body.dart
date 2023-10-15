import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';
import 'package:gp91/constants.dart';
import 'package:gp91/firebase_auth/firebase_auth_services.dart';
import 'package:gp91/firebase_auth/signup_controller.dart';
import 'package:gp91/firebase_auth/user_model.dart';
import 'package:gp91/firebase_auth/user_repository/auth_repository.dart';
import 'package:gp91/firebase_auth/user_repository/user_repository.dart';
import 'package:gp91/login/components/already_have_an_account_acheck.dart';
import 'package:gp91/login/components/rounded_button.dart';
import 'package:gp91/login/components/text_field_container.dart';
import 'package:gp91/login/login.dart';
import 'package:gp91/logout.dart';
import 'package:gp91/signup/components/background.dart';

class Body extends StatefulWidget {
  final Widget child;
  const Body({super.key, required this.child});

  @override
  State<StatefulWidget> createState() => _FormScreenState();
}

class _FormScreenState extends State<Body> {
  final _formKey = GlobalKey<FormState>();

  final FirebaseAuthService _firebaseAuthService = FirebaseAuthService();

  final AuthRepository _authRepository = AuthRepository();
  final SignUpController _signUpController = SignUpController();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();

  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Background(
      child: SingleChildScrollView(
        child: Form(
          key: _formKey,
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

// name               nameInput,
              TextFieldContainer(
                child: TextFormField(
                  controller: _nameController,
                  onChanged: (value) {},
                  validator: (value) {
                    if (value!.length < 3) {
                      return "Name Should be at least 3 characters";
                    } else if (value!.isEmpty) {
                      return "Please enter your name";
                    } else {
                      return null;
                    }
                  },
                  decoration: const InputDecoration(
                    hintStyle: TextStyle(
                      fontFamily: 'NanumGothic',
                    ),
                    icon: Icon(
                      Icons.person,
                      color: primaryColor,
                    ),
                    hintText: "Name",
                    border: InputBorder.none,
                  ),
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                ),
              ),
// email               emailInput,
              TextFieldContainer(
                child: TextFormField(
                  controller: _emailController,
                  onChanged: (value) {},
                  validator: (value) {
                    RegExp emailRegex =
                        RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
                    final isEmailValid = emailRegex.hasMatch(value ?? '');
                    if (!isEmailValid) {
                      return "Please enter a valid email";
                    } else if (value!.isEmpty) {
                      return "Please enter your email";
                    } else {
                      return null;
                    }
                  },
                  keyboardType: TextInputType.emailAddress,
                  decoration: const InputDecoration(
                    hintStyle: TextStyle(
                      fontFamily: 'NanumGothic',
                    ),
                    icon: Icon(
                      Icons.email,
                      color: primaryColor,
                    ),
                    hintText: "Email",
                    border: InputBorder.none,
                  ),
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                ),
              ),

// password              passwordInput,
              TextFieldContainer(
                child: TextFormField(
                  controller: _passwordController,
                  obscureText: true,
                  onChanged: (value) {},
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "Please enter your password";
                    } else {
                      return null;
                    }
                  },
                  decoration: const InputDecoration(
                    hintStyle: TextStyle(
                      fontFamily: 'NanumGothic',
                    ),
                    icon: Icon(
                      Icons.lock,
                      color: primaryColor,
                    ),
                    suffixIcon: Icon(
                      Icons.visibility,
                      color: primaryColor,
                    ),
                    hintText: "Password",
                    border: InputBorder.none,
                  ),
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                ),
              ),
// confirm              confirmPasswordInput,
              TextFieldContainer(
                child: TextFormField(
                  controller: _confirmPasswordController,
                  obscureText: true,
                  onChanged: (value) {},
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "Please re-enter your password";
                    } else if (_passwordController.text !=
                        _confirmPasswordController.text) {
                      return "Passwords don't match";
                    } else {
                      return null;
                    }
                  },
                  decoration: const InputDecoration(
                    hintStyle: TextStyle(
                      fontFamily: 'NanumGothic',
                    ),
                    icon: Icon(
                      Icons.lock,
                      color: primaryColor,
                    ),
                    suffixIcon: Icon(
                      Icons.visibility,
                      color: primaryColor,
                    ),
                    hintText: "Confirm password",
                    border: InputBorder.none,
                  ),
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                ),
              ),

              // SIGN UP BUTTON
              RoundedButton(
                text: "SIGN UP",
                // Go to the home page
                press: () {
                  if (_formKey.currentState?.validate() == true) {
                    print("WOOOOORKED validation!!");

                    final user = UserModel(
                      name: _nameController.text.trim(),
                      email: _emailController.text.trim(),
                      password: _passwordController.text.trim(),
                    );
                    // _signUpController.registerUser(_emailController.text.trim(),
                    //     _passwordController.text.trim());
                    // createUser(user);
                    // _signUp(user);
                    _signUpController.registerUser(_emailController.text.trim(),
                        _passwordController.text.trim());
                    _signUpController.createUser(user);
                  } else {
                    print("validation did not work");
                  }
                },
              ),
              AlreadyHaveAnAcoountCheck(
                login: false,
                press: () {
                  Get.to(() => LoginScreen());
                  // Navigator.push(
                  //   context,
                  //   MaterialPageRoute(
                  //     builder: (context) {
                  //       return LoginScreen();
                  //     },
                  //   ),
                  // );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _signUp(UserModel userModel) async {
    String name = _nameController.text;
    String email = _emailController.text;
    String password = _passwordController.text;

    // User? user =
    //     await _firebaseAuthService.signUpWithEmailAndPassword(email, password);
    // _signUpController.createUser(userModel);

    // _signUpController.registerAndCreateUser(email, password, userModel);
    User? user =
        await _authRepository.createUserWithEmailAndPassword(email, password);
    if (user != null) {
      print("User is successfully created");
      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            content: Text("successfully signed up"),
          );
        },
      );
      Get.to(() => Logout());
      // Navigator.pushNamed(context, "/home");
    } else {
      print("User created failed");
    }
  }

  // void _signup(String email, String password) {
  //   _signUpController.registerUser(email, password);
  // }
}
