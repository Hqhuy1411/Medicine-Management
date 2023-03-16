import 'package:app/model/Device.dart';
import 'package:app/utils/vadilator.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

import '../firebase_store/fire_base_auth.dart';
import '../model/Users.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  var _firAuth = FirAuth();

  TextEditingController _nameController = new TextEditingController();
  TextEditingController _emailController = new TextEditingController();
  TextEditingController _passController = new TextEditingController();
  TextEditingController _phoneController = new TextEditingController();
  GlobalKey<FormState> formGlobalKey = new GlobalKey<FormState>();
  String errorMessage = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
          padding: EdgeInsets.fromLTRB(30, 0, 30, 0),
          constraints: BoxConstraints.expand(),
          color: Colors.white,
          child: SingleChildScrollView(
            child: Form(
              key: formGlobalKey,
              child: Column(
                children: <Widget>[
                  const SizedBox(
                    height: 140,
                  ),
                  //Image.asset('ic_car_red.png'),
                  const Padding(
                    padding: EdgeInsets.fromLTRB(0, 40, 0, 6),
                    child: Text(
                      "Welcome Aboard!",
                      style: TextStyle(fontSize: 22, color: Color(0xff333333)),
                    ),
                  ),
                  const Text(
                    "Signup with iCab in simple steps",
                    style: TextStyle(fontSize: 16, color: Color(0xff606470)),
                  ),

                  Padding(
                    padding: const EdgeInsets.fromLTRB(0, 80, 0, 20),
                    child: StreamBuilder(
                        builder: (context, snapshot) => TextFormField(
                              controller: _nameController,
                              style: const TextStyle(
                                  fontSize: 18, color: Colors.black),
                              // ignore: prefer_const_constructors
                              decoration: InputDecoration(
                                  //errorText:
                                  //  snapshot.hasError ? snapshot.error : null,
                                  labelText: "Name",
                                  prefixIcon: const SizedBox(
                                      width: 50,
                                      child:
                                          Icon(Icons.assignment_ind_rounded)),
                                  border: const OutlineInputBorder(
                                      borderSide: BorderSide(
                                          color: Color(0xffCED0D2), width: 1),
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(6)))),
                            )),
                  ),
                  StreamBuilder(
                      //stream: authBloc.phoneStream,
                      builder: (context, snapshot) => TextFormField(
                            controller: _phoneController,
                            validator: Validators.validatePhone,
                            style: const TextStyle(
                                fontSize: 18, color: Colors.black),
                            // ignore: prefer_const_constructors
                            decoration: InputDecoration(
                                labelText: "Phone Number",
                                // errorText:
                                //     snapshot.hasError ? snapshot.error : null,
                                prefixIcon: const SizedBox(
                                    width: 50, child: Icon(Icons.phone)),
                                border: const OutlineInputBorder(
                                    borderSide: BorderSide(
                                        color: Color(0xffCED0D2), width: 1),
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(6)))),
                          )),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(0, 20, 0, 20),
                    child: StreamBuilder(
                        //  stream: authBloc.emailStream,
                        builder: (context, snapshot) => TextFormField(
                              controller: _emailController,
                              validator: Validators.validateEmail,
                              style: const TextStyle(
                                  fontSize: 18, color: Colors.black),
                              decoration: InputDecoration(
                                  labelText: "Email",
                                  // errorText:
                                  //     snapshot.hasError ? snapshot.error : null,
                                  prefixIcon: Container(
                                      width: 50,
                                      child: const Icon(Icons.email)),
                                  border: const OutlineInputBorder(
                                      borderSide: BorderSide(
                                          color: Color(0xffCED0D2), width: 1),
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(6)))),
                            )),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(0, 0, 135, 0),
                    child:
                        Text(errorMessage, style: TextStyle(color: Colors.red)),
                  ),
                  StreamBuilder(
                      //  stream: authBloc.passStream,
                      builder: (context, snapshot) => TextFormField(
                            controller: _passController,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter some text';
                              }
                              return null;
                            },
                            obscureText: true,
                            style: const TextStyle(
                                fontSize: 18, color: Colors.black),
                            // ignore: prefer_const_constructors
                            decoration: InputDecoration(
                                // errorText:
                                //     snapshot.hasError ? snapshot.error : null,
                                labelText: "Password",
                                prefixIcon: const SizedBox(
                                    width: 50, child: Icon(Icons.lock)),
                                border: const OutlineInputBorder(
                                    borderSide: BorderSide(
                                        color: Color(0xffCED0D2), width: 1),
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(6)))),
                          )),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(0, 30, 0, 40),
                    child: SizedBox(
                      width: double.infinity,
                      height: 52,
                      child: ElevatedButton(
                        onPressed: () {
                          print(_nameController.text);
                          print(_phoneController.text);
                          print(_emailController.text);
                          print(_passController.text);
                          if (!formGlobalKey.currentState!.validate()) {
                            return;
                            // use the email provided here
                          }
                          List<Device> list = [];
                          _firAuth.signUp(
                              _emailController.text,
                              _passController.text,
                              Users(
                                  phone: int.parse(_phoneController.text),
                                  name: _nameController.text,
                                  devices: list));
                        },
                        child: const Text(
                          "Signup",
                          style: const TextStyle(
                              color: Colors.white, fontSize: 18),
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(70, 0, 0, 40),
                    child: Row(children: <Widget>[
                      const Text('Already a User ?'),
                      TextButton(
                        onPressed: () async {
                          Navigator.pop(context);
                          // print(Validators.checkExists());
                          // var rs = await _firAuth
                          //     .checkEmailExists(_emailController.text);
                          // print(rs);
                          // if (rs == true) {
                          //   errorMessage = "Email address is already exists";
                          //   setState(() {});
                          // }
                        },
                        child: const Text('Sigin Now',
                            style: TextStyle(fontSize: 20)),
                      )
                    ]),
                  )
                ],
              ),
            ),
          )),
    );
  }

//   _onSignUpClicked() {
//     var isValid = authBloc.isValid(_nameController.text, _emailController.text,
//         _passController.text, _phoneController.text);
//     if (isValid) {
//       // create user
//       // loading dialog
//       LoadingDialog.showLoadingDialog(context, 'Loading...');
//       authBloc.signUp(_emailController.text, _passController.text,
//           _phoneController.text, _nameController.text, () {
//         LoadingDialog.hideLoadingDialog(context);
//         Navigator.push(
//             context, MaterialPageRoute(builder: (context) => HomePage()));
//       }, (msg) {
//         LoadingDialog.hideLoadingDialog(context);
//         MsgDialog.showMsgDialog(context, "Sign-In", msg);
//         // show msg dialog
//       });
//     }
//   }
}
