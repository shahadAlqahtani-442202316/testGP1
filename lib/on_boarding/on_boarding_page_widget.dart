import 'package:flutter/material.dart';
import 'package:gp91/on_boarding/on_boarding_model.dart';

class OnBoardingPageWidget extends StatelessWidget {
  final Size size;
  final OnBoardingModel model;
  const OnBoardingPageWidget({
    super.key,
    required this.model,
    required this.size,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(30),
      color: model.bgColor,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Image.asset(
            model.image,
            width: size.width,
            height: size.height * 0.3,
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                model.title,
                style: const TextStyle(
                  fontSize: 20,
                  fontFamily: 'NanumGothic',
                  fontWeight: FontWeight.w900,
                  // color: primaryColor,
                ),
              ),
              SizedBox(
                height: size.height * 0.01,
              ),
              Text(
                model.subTitle,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 16,
                  fontFamily: 'NanumGothic',
                  fontWeight: FontWeight.w600,
                  // color: primaryColor,
                ),
              ),
            ],
          ),
          Text(
            model.counterText,
            style: const TextStyle(
              fontSize: 14,
              fontFamily: 'NanumGothic',
              fontWeight: FontWeight.w600,
              // color: primaryColor,
            ),
          ),
          SizedBox(
            height: size.height * 0.1,
          ),
        ],
      ),
    );
  }
}
