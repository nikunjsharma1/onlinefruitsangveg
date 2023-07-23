import 'package:flutter/material.dart';
import 'package:flutter_session_manager/flutter_session_manager.dart';
import 'package:online_fruits_and_vegetables_app/helper/apiHelper.dart';
import 'package:online_fruits_and_vegetables_app/utils/ProgreeHud.dart';
import 'package:online_fruits_and_vegetables_app/utils/form_helper.dart';
import 'package:online_fruits_and_vegetables_app/utils/validator.dart';
import 'package:wp_json_api/enums/wp_auth_type.dart';
import 'package:wp_json_api/models/responses/wp_user_info_response.dart';
import 'package:wp_json_api/models/responses/wp_user_login_response.dart';
import 'package:wp_json_api/wp_json_api.dart';

import '../models/CustomerModel.dart';
import '../utils/sharedpref.dart';


class SignupPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _SignupPageState();
}

@override
_SignupPageState createState() => _SignupPageState();

class _SignupPageState extends State<SignupPage> {
  late ApiHelper apiService;
  late CustomerModel model;
  SharedPref sharedPref = SharedPref();
  GlobalKey<FormState> globalKey = GlobalKey<FormState>();
  bool hidePassword = true;
  bool isApiCallProcess = false;

  @override
  void initState() {
    WPJsonAPI.instance.initWith(baseUrl: "https://onlinefruitsandvegetables.com");
    model= CustomerModel();
    apiService = ApiHelper();
    cadd();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.redAccent, automaticallyImplyLeading: true,
        title: Text("Sign Up"),
      ),
      // AppBar
      // body: ProgressHUD (child: new Form (key: globalKey, child: _formUI(),), inAsyncCall: isApiCallProcess,),
      body: formUI(),
    );
  }

  Widget formUI() {
    return SingleChildScrollView(
      child: Padding(padding: EdgeInsets.all(10),
        child: Container(
          child: Align(
            alignment: Alignment.topLeft, child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [

              FormHelper.fieldLabel("First Name"),
              FormHelper.textInput(
                context,
                model.firstName,
                    (value) =>
                {
                  this.model.firstName = value,},

                onValidate: (value) {
                  if (value
                      .toString()
                      .isEmpty) {
                    return 'Please enter First Name.';
                  }
                  return null;
                }, prefixIcon: Icon(Icons.account_box), suffixIcon: Icon(Icons.wallet_travel),
              ),
              FormHelper.fieldLabel("Last Name"),
              FormHelper.textInput(

                  context,
                  model.lastName,
                      (value) =>
                  { this.model.lastName = value,
                  },

                  onValidate: (value) {
                    return null;
                  }, prefixIcon: Icon(Icons.account_box),  suffixIcon: Icon(Icons.wallet_travel)
              ),
              FormHelper.fieldLabel("Email Id"),
              FormHelper.textInput(
                context,
                model.email,
                    (value) =>
                {
                  this.model.email = value,
                },
        
                onValidate: (value) {
                  if (value
                      .toString()
                      .isEmpty) {
                    return "please enter email";
                  }
                  if (value.isNotEmpty && value.isValidEmail) {
                    return 'Please enter valid email-id';
                  }
                  return null;
                }, prefixIcon: Icon(Icons.email), suffixIcon: Icon(Icons.arrow_back_ios_new_rounded),
              ),
                FormHelper.fieldLabel("Password"),
                FormHelper.textInput(
                  context,
                  model.password,
                      (value) =>
                  {
                    this.model.password = value,
                  },

                  onValidate: (value) {
                    if (value
                        .toString()
                        .isEmpty) {
                      return 'Please enter Password.';
                    }

                    return null;
                  },

                  obscureText: hidePassword,
                  suffixIcon: IconButton(
                    onPressed: () {
                      setState(() {
                        hidePassword = !hidePassword;
                      });
                    },


                    color: Theme
                        .of(context)
                        .accentColor
                        .withOpacity(0.4), icon: Icon(
                    hidePassword ? Icons.visibility_off : Icons
                        .visibility,), // Icon
                  ), prefixIcon: Icon(Icons.account_box), // IconButton
                ),
                // IconButton
                const SizedBox(
                  height: 20,
                ),
                // SizedBox

                Center(
                  child: FormHelper.saveButton(
                    "Register",
                        () {
                    //  if (validateAndSave()) {
                        print(model.toJson());
                        setState(() {
                          isApiCallProcess = true;
                        });
                        apiService.createCustomer(model).then(
                              (ret) {
                            setState(() {

                              isApiCallProcess = false;
                            });
                            if (ret) {
                              FormHelper.showMessage(
                                  context,
                                  "",
                                  "Registration Successfull",
                                  "Ok",
                                      () {

                                    Navigator.of(context).pop();
                                  }
                              );
                            } else {
                              FormHelper.showMessage(

                                context,
                                "",
                                "Email Id already registered.",
                                "Ok",
                                    () {
                                  Navigator.of(context).pop();
                                },
                              );
                            }
                          },
                        );
                     // }
                    }, color: '',
                  ),
                ),

            ],
          ),
          ),
        ),
      ),

    ); // Padding
// SingleChildScrollView
  }

  bool validateAndSave() {
    final form = globalKey.currentState;
    if(form!=null){
      if (form.validate()) {
        form.save();
        return true;
      }
    }

    return false;
  }

  Future<void> cadd() async {
    try {
    WPUserLoginResponse wpUserLoginResponse = await WPJsonAPI.instance
        .api((request) => request.wpLogin(
        email: "nikunjs11.@gmail.com",
        password: "12345",
        authType: WPAuthType.WpEmail
    ));
    print(wpUserLoginResponse.message);
    } on Exception catch (e) {
      print(e);
    }
  }



}


// loadSharedPrefs() async {
//   try {
//     User user = User.fromJson(await sharedPref.read("user"));
//     Scaffold.of(context).showSnackBar(SnackBar(
//         content: new Text("Loaded!"),
//         duration: const Duration(milliseconds: 500)));
//     setState(() {
//       userLoad = user;
//     });
//   } catch (Excepetion) {
//     Scaffold.of(context).showSnackBar(SnackBar(
//         content: new Text("Nothing found!"),
//         duration: const Duration(milliseconds: 500)));
//   }
// }