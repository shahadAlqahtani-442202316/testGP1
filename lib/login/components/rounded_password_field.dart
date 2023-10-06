import 'package:flutter/material.dart';
import 'package:gp91/constants.dart';
import 'package:gp91/login/components/text_field_container.dart';

class RoundedPasswordField extends StatelessWidget {
  final ValueChanged<String> onChanged;
  const RoundedPasswordField({
    super.key,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return const TextFieldContainer(
      child: TextField(
        obscureText: true,
        decoration: InputDecoration(
          hintStyle: TextStyle(
            fontFamily: 'NanumGothic',
          ),
          hintText: "Password",
          icon: Icon(
            Icons.lock,
            color: primaryColor,
          ),
          suffixIcon: Icon(
            Icons.visibility,
            color: primaryColor,
          ),
          border: InputBorder.none,
        ),
      ),
    );
  }
}
