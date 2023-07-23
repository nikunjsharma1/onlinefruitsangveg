import 'package:flutter/material.dart';
import 'package:flutter_session_manager/flutter_session_manager.dart';
import 'package:online_fruits_and_vegetables_app/presentation/HomeScreen.dart';
import 'package:online_fruits_and_vegetables_app/presentation/signupPage.dart';

import '../models/signupmodel.dart';
import '../utils/sharedpref.dart';
import 'MainPage.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
   late String id;
  @override
  void initState() {
    super.initState();
    loadSharedPrefs();

    Future.delayed(
        const Duration(seconds: 2),
       () =>

        // id!=null?
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => WebViewExample()))
          //  :Navigator.pushReplacement(
          //  context, MaterialPageRoute(builder: (context) => SignupPage()))
    );
  }
  loadSharedPrefs() async {
    try {
      String ids = await SessionManager().get("id").toString();
      setState(() {
        id=ids;
      });
      print("====>>>d"+id.toString());

    } catch (excepetion ) {
      print("====>>>e"+excepetion.toString());

    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [

          Container(
              decoration: const BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage("assets/images/welcome_bg.png"),
                    fit: BoxFit.cover,
                  ))),
          Padding(
            padding: EdgeInsets.only(bottom: 100),
            child: Align(
               alignment: Alignment.center,
              child: Container(
                height: MediaQuery.of(context).size.height/4,
                width: MediaQuery.of(context).size.width/1,


                child: Image.asset(
                  "assets/images/sps.png",
                  fit: BoxFit.contain,
                  width: MediaQuery.of(context).size.width/4,
                ),),
            ),
          ),
          Container(
            alignment: Alignment.center,
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  const SizedBox(
                    height: 44,
                  ),

                  SizedBox(
                    height: 32,
                  ),
                  Container(
                    margin: const EdgeInsets.symmetric(horizontal: 8),
                    child: Text(
                      "Get your groceries delivered to your home",
                      textAlign: TextAlign.center,
                      style:
                      TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Container(
                    margin: const EdgeInsets.symmetric(horizontal: 32),
                    child: Text(
                      "The best delivery app in town for delivering your daily fresh groceries",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          fontWeight: FontWeight.w500,
                          fontSize: 14,
                          color: Color(0xff979899)),
                    ),
                  ),
                  SizedBox(
                    height: 36,
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
