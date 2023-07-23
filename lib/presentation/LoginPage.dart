import 'package:flutter/material.dart';
import 'package:online_fruits_and_vegetables_app/helper/apiHelper.dart';

import '../utils/ProgreeHud.dart';
import '../utils/form_helper.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool hidePassword = true;
  bool isApiCallProcess = false;
  GlobalKey<FormState> globalKey = GlobalKey<FormState>();
  late String username;
  late String password;
  late ApiHelper apiService;

  @override
  void initState() {
    apiService = ApiHelper();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ProgressHUD(
        inAsyncCall: isApiCallProcess, opacity: 0.3, child: uiSetup(context));
  }

  Widget uiSetup(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).accentColor,
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Stack(
              children: <Widget>[
                Container(
                  width: double.infinity,
                  padding: EdgeInsets.symmetric(vertical: 30, horizontal: 20),
                  margin: EdgeInsets.symmetric(vertical: 85, horizontal: 20),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: Theme.of(context).primaryColor,
                    boxShadow: [
                      BoxShadow(
                          color: Theme.of(context).hintColor.withOpacity(0.2),
                          offset: Offset(0, 10),
                          blurRadius: 20) // BoxShadow
                    ],
                  ),
                  // BoxDecoration
                  child: Form(
                    key: globalKey,
                    child: Column(
                      children: <Widget>[
                        SizedBox(height: 25),
                        Text(
                          "Login",
                          style: Theme.of(context).textTheme.headline2,
                        ),
                        // Text
                        SizedBox(height: 20),
                        TextFormField(
                          keyboardType: TextInputType.emailAddress,
                          onSaved: (input) => username = input!,
                          validator: (input) => input!.contains('@')
                              ? null
                              : null,
                          decoration: InputDecoration(
                            hintText: "Email Address",
                            enabledBorder: UnderlineInputBorder(
                                borderSide: BorderSide(
                                    color: Theme.of(context)
                                        .accentColor
                                        .withOpacity(0.2))),
                            focusedBorder: UnderlineInputBorder(
                                borderSide: BorderSide(
                                    color: Theme.of(context)
                                        .accentColor)), // BorderSide
                            prefixIcon: Icon(
                              Icons.email,
                              color: Theme.of(context).accentColor,
                            ),
                          ), // Input Decoration
                        ), // TextFormField I
                        SizedBox(height: 20),
                        TextFormField(
                          style:
                              TextStyle(color: Theme.of(context).accentColor),
                          keyboardType: TextInputType.text,
                          onSaved: (input) => password = input!,
                          validator: (input) => input!.length < 3
                              ? "Password should be more than 3 characters"
                              : null,
                          obscureText: hidePassword,
                          decoration: InputDecoration(
                            hintText: "Password",
                            enabledBorder: UnderlineInputBorder(
                                borderSide: BorderSide(
                                    color: Theme.of(context)
                                        .accentColor
                                        .withOpacity(0.2))),
                            // BorderSide //
                            focusedBorder: UnderlineInputBorder(
                                borderSide: BorderSide(
                                    color: Theme.of(context).accentColor)),
                            //
                            prefixIcon: Icon(
                              Icons.lock,
                              color: Theme.of(context).accentColor,
                            ),
                            // Icon
                            suffixIcon: IconButton(
                              onPressed: () {
                                setState(() {
                                  hidePassword = !hidePassword;
                                });
                              },
                              color: Theme.of(context)
                                  .accentColor
                                  .withOpacity(0.4),
                              // BorderSide // UnderlineInputBorder
                              icon: Icon(hidePassword
                                  ? Icons.visibility_off
                                  : Icons.visibility), // Icon
                            ), // IconButton
                          ), // Input Decoration
                        ),
                        // TextFormField
                        SizedBox(height: 30),
                        TextButton(
                          style: flatButtonStyle, // EdgeInsets.symmetric
                          onPressed: () {
                            if (validateAndSave()) {
                              setState(() {
                                isApiCallProcess = true;
                              });
                              apiService
                                  .loginCustomer(username, password)
                                  .then((ret) {
                                if (ret != null) {

                                  FormHelper.showMessage(
                                    context,
                                    "",
                                    "Login Successfull",
                                    "Ok",
                                    () {},
                                  );
                                } else {
                                  FormHelper.showMessage(
                                    context,
                                    "",
                                    "Invalid Login!!",
                                    "Ok",
                                    () {},
                                  );
                                }
                              });
                            }
                          },
                          child: const Text(
                            "Login",
                            style: TextStyle(color: Colors.white),
                          ), // Text
                        ),
                        // FlatButton
                        SizedBox(height: 15),
                      ], // <Widget>[]
                    ), // Column
                  ), // Form
                ), // Container
              ], // <Widget>[]
            ), // Stack
          ], // <Widget>[]
        ), // Column
      ), // SingleChildScrollView
    ); // Scaffold
  }

  bool validateAndSave() {
    final form = globalKey.currentState;
    if (form != null) {
      if (form.validate()) {
        form.save();
        return true;
      }
    }

    return false;
  }
}

final ButtonStyle flatButtonStyle = TextButton.styleFrom(
  primary: Colors.white,
  minimumSize: Size(88, 44),
  padding: EdgeInsets.symmetric(horizontal: 16.0),
  shape: const RoundedRectangleBorder(
    borderRadius: BorderRadius.all(Radius.circular(2.0)),
  ),
  backgroundColor: Colors.blue,
);
