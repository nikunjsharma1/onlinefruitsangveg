import 'package:flutter/material.dart';

import '../utils/image_constant.dart';

class Slider1 extends StatelessWidget {
  const Slider1({Key? key}) : super(key: key);
  final image =
      "data:image/jpeg;base64,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";

  @override
  Widget build(BuildContext context) {
    var screenSize = MediaQuery.of(context).size;
    return ClipRRect(
      borderRadius: BorderRadius.all(Radius.circular(10)),
      child: Stack(children: <Widget>[
        Container(
          height: screenSize.height * 0.3,
          child: Image.asset(ImageConstant.sl1, fit: BoxFit.cover),width: 1000,
        ),
        // Provide an optional curve to make the animation feel smoother.
        //     curve: Curves.fastOutSlowIn,

        Positioned.fill(
          left: 30,
          top: 100,
          child: Column(
            children: [
              Align(
                alignment: Alignment.bottomLeft,
                child: Container(
                  child: const Text(
                    "Fresh from our Online \n Fruits and Vegetables",
                    style: TextStyle(
                        fontFamily: 'MontserratBold',
                        fontSize: 13,
                        fontWeight: FontWeight.bold,
                        color: Colors.white),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
              Align(
                alignment: Alignment.bottomLeft,
                child: Container(
                  height: 30,
                  width: 70,
                  alignment: Alignment.center,
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.all(Radius.circular(2.0)),
                  ),
                  child: const Text(
                    "Shop now",
                    style: TextStyle(
                        fontFamily: 'montserratbold700',
                        fontSize: 13,
                        color: Colors.black),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
            ],
          ),
        )
      ]),
    );
  }
}

class Slider2 extends StatelessWidget {
  const Slider2({Key? key}) : super(key: key);
  final image =
      "https://onlinefruitsandvegetables.com/wp-content/uploads/2022/02/visit-farm.webp";

  @override
  Widget build(BuildContext context) {
    var screenSize = MediaQuery.of(context).size;
    return ClipRRect(
      borderRadius: BorderRadius.all(Radius.circular(10)),
      child: Stack(children: <Widget>[
        Container(
          height: screenSize.height * 0.3,
          child: Image.asset(ImageConstant.sl2, fit: BoxFit.cover),width: 1000,
        ),
        // Provide an optional curve to make the animation feel smoother.
        //     curve: Curves.fastOutSlowIn,

        Positioned.fill(
          left: 30,
          top: 100,
          child: Column(
            children: [
              Align(
                alignment: Alignment.bottomLeft,
                child: Container(
                  child: const Text(
                    "Discover Real \n Organic Flavours",
                    style: TextStyle(
                        fontFamily: 'MontserratBold',
                        fontSize: 13,
                        fontWeight: FontWeight.bold,
                        color: Colors.white),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
              Align(
                alignment: Alignment.bottomLeft,
                child: Container(
                  height: 30,
                  width: 70,
                  alignment: Alignment.center,
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.all(Radius.circular(2.0)),
                  ),
                  child: const Text(
                    "Shop now",
                    style: TextStyle(
                        fontFamily: 'montserratbold700',
                        fontSize: 13,
                        color: Colors.black),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
            ],
          ),
        )
      ]),
    );
  }
}

class Slider3 extends StatelessWidget {
  const Slider3({Key? key}) : super(key: key);
  final image =
      "https://onlinefruitsandvegetables.com/wp-content/uploads/2022/03/visit-farm-1200x800.webp";

  @override
  Widget build(BuildContext context) {
    var screenSize = MediaQuery.of(context).size;
    return ClipRRect(
      borderRadius: BorderRadius.all(Radius.circular(10)),
      child: Stack(children: <Widget>[
        Container(
          height: screenSize.height * 0.3,
          child: Image.asset(ImageConstant.sl3, fit: BoxFit.cover),width: 1000,
        ),
        // Provide an optional curve to make the animation feel smoother.
        //     curve: Curves.fastOutSlowIn,

        Positioned.fill(
          left: 30,
          top: 100,
          child: Column(
            children: [
              Align(
                alignment: Alignment.bottomLeft,
                child: Container(
                  child: const Text(
                    "Fresh and Healthy",
                    style: TextStyle(
                        fontFamily: 'MontserratBold',
                        fontWeight: FontWeight.bold,
                        fontSize: 13,
                        color: Colors.white),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
              Align(
                alignment: Alignment.bottomLeft,
                child: Container(
                  height: 30,
                  width: 70,
                  alignment: Alignment.center,
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.all(Radius.circular(2.0)),
                  ),
                  child: const Text(
                    "Shop now",
                    style: TextStyle(
                        fontFamily: 'montserratbold700',
                        fontSize: 13,
                        color: Colors.black),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
            ],
          ),
        )
      ]),
    );
  }
}
