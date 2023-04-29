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
bool _isObscured = true;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage("images/bg.png"), fit: BoxFit.cover)),
        // padding: const EdgeInsets.all(10),
          // padding: EdgeInsets.fromLTRB(30, 0, 30, 0),
          constraints: BoxConstraints.expand(),
          // color: Colors.white,
          child: SingleChildScrollView(
            child: Form(
              key: formGlobalKey,
              child: Column(
                children: <Widget>[
                  const SizedBox(
                    height: 40,
                  ),
                  //Image.asset('ic_car_red.png'),
                  const Padding(
                    padding: EdgeInsets.fromLTRB(0, 20, 0, 6),
                    child: Text(
                      "Sign up",
                      style: TextStyle(fontSize: 40, color: Color(0xff333333)),
                    ),
                  ),
                  const Text(
                    "Create an Account",
                    style: TextStyle(fontSize: 16, color: Color(0xff606470)),
                  ),
                  Container(
                      width: 340,
                      height: 70,
                      // padding: EdgeInsets.only(right: 5.0),
                      // margin: EdgeInsets.symmetric(horizontal: 40),
                      margin: EdgeInsets.only(top: 60, bottom: 0, left: 40, right: 40),
                      decoration: BoxDecoration(
                        color: Color(0xff64abbf),
                      ),

                        child: Stack(
                          children: <Widget>[
                            Row(children: [
                              // SizedBox(width: 10),
                              Expanded(
                                child: Center(
                                  child: TextField(
                                    controller: _nameController,
                                    style: TextStyle(
                                        color: Colors.black, // màu chữ
                                        fontSize: 15, // kích thước chữ
                                      ),
                                      decoration: InputDecoration(
                                        icon: Icon(
                                          Icons.people_outline,
                                          color: Color(0xFFFFFFFF),
                                        ),
                                        constraints: BoxConstraints(
                                          maxHeight: 40, // chiều cao tối đa của TextField
                                          maxWidth: 280, // chiều rộng tối đa của TextField
                                        ),
                                        fillColor: Colors.white,
                                        filled: true,
                                        border: OutlineInputBorder(
                                          borderRadius: BorderRadius.circular(30.0), // bo góc
                                          borderSide: BorderSide.none,
                                        ),
                                        // border: InputBorder.none, // loại bỏ đường viền
                                        // contentPadding: EdgeInsets.symmetric(vertical: 10), // khoảng cách giữa đường viền và văn bản
                                        hintText: 'Your Name', // placeholder
                                        hintStyle: TextStyle(
                                          color: Colors.grey, // màu placeholder
                                          fontSize: 15, // kích thước placeholder
                                        ),
                                      ),
                              )))
                            ]),
                          ],
                        ),
                    ),
                  // Padding(
                  //   padding: const EdgeInsets.fromLTRB(0, 80, 0, 20),
                  //   child: StreamBuilder(
                  //       builder: (context, snapshot) => TextFormField(
                  //             controller: _nameController,
                  //             style: const TextStyle(
                  //                 fontSize: 18, color: Colors.black),
                  //             // ignore: prefer_const_constructors
                  //             decoration: InputDecoration(
                  //                 //errorText:
                  //                 //  snapshot.hasError ? snapshot.error : null,
                  //                 labelText: "Name",
                  //                 prefixIcon: const SizedBox(
                  //                     width: 50,
                  //                     child:
                  //                         Icon(Icons.assignment_ind_rounded)),
                  //                 border: const OutlineInputBorder(
                  //                     borderSide: BorderSide(
                  //                         color: Color(0xffCED0D2), width: 1),
                  //                     borderRadius: BorderRadius.all(
                  //                         Radius.circular(6)))),
                  //           )),
                  // ),

                  Container(
                      width: 340,
                      height: 70,
                      // padding: EdgeInsets.only(right: 5.0),
                      // margin: EdgeInsets.symmetric(horizontal: 40),
                      margin: EdgeInsets.only(left: 40, right: 40),
                      decoration: BoxDecoration(
                        color: Color(0xff64abbf),
                      ),
                        child: Stack(
                          children: <Widget>[
                            Row(children: [
                              // SizedBox(width: 10),
                              Expanded(
                                child: Center(
                                  child: TextFormField(
                                    controller: _phoneController,
                                    validator: Validators.validatePhone,
                                    style: TextStyle(
                                        color: Colors.black, // màu chữ
                                        fontSize: 15, // kích thước chữ
                                      ),
                                      decoration: InputDecoration(
                                        icon: Icon(
                                          Icons.phone_outlined,
                                          color: Color(0xFFFFFFFF),
                                        ),
                                        constraints: BoxConstraints(
                                          maxHeight: 40, // chiều cao tối đa của TextField
                                          maxWidth: 280, // chiều rộng tối đa của TextField
                                        ),
                                        fillColor: Colors.white,
                                        filled: true,
                                        border: OutlineInputBorder(
                                          borderRadius: BorderRadius.circular(30.0), // bo góc
                                          borderSide: BorderSide.none,
                                        ),
                                        // border: InputBorder.none, // loại bỏ đường viền
                                        // contentPadding: EdgeInsets.symmetric(vertical: 10), // khoảng cách giữa đường viền và văn bản
                                        hintText: 'Phone Number', // placeholder
                                        hintStyle: TextStyle(
                                          color: Colors.grey, // màu placeholder
                                          fontSize: 15, // kích thước placeholder
                                        ),
                                      ),
                              )))
                            ]),
                          ],
                        ),
                    ),
                  // StreamBuilder(
                  //     //stream: authBloc.phoneStream,
                  //     builder: (context, snapshot) => TextFormField(
                  //           controller: _phoneController,
                  //           validator: Validators.validatePhone,
                  //           style: const TextStyle(
                  //               fontSize: 18, color: Colors.black),
                  //           // ignore: prefer_const_constructors
                  //           decoration: InputDecoration(
                  //               labelText: "Phone Number",
                  //               // errorText:
                  //               //     snapshot.hasError ? snapshot.error : null,
                  //               prefixIcon: const SizedBox(
                  //                   width: 50, child: Icon(Icons.phone)),
                  //               border: const OutlineInputBorder(
                  //                   borderSide: BorderSide(
                  //                       color: Color(0xffCED0D2), width: 1),
                  //                   borderRadius:
                  //                       BorderRadius.all(Radius.circular(6)))),
                  //         )),
                  
                  Container(
                      width: 340,
                      height: 70,
                      // padding: EdgeInsets.only(right: 5.0),
                      // margin: EdgeInsets.symmetric(horizontal: 40),
                      margin: EdgeInsets.only(left: 40, right: 40),
                      decoration: BoxDecoration(
                        color: Color(0xff64abbf),
                      ),
                        child: Stack(
                          children: <Widget>[
                            Row(children: [
                              // SizedBox(width: 10),
                              Expanded(
                                child: Center(
                                  child: TextFormField(
                                    controller: _emailController,
                                    validator: Validators.validateEmail,
                                    style: TextStyle(
                                        color: Colors.black, // màu chữ
                                        fontSize: 15, // kích thước chữ
                                      ),
                                      decoration: InputDecoration(
                                        icon: Icon(
                                          Icons.email_outlined,
                                          color: Color(0xFFFFFFFF),
                                        ),
                                        constraints: BoxConstraints(
                                          maxHeight: 40, // chiều cao tối đa của TextField
                                          maxWidth: 280, // chiều rộng tối đa của TextField
                                        ),
                                        fillColor: Colors.white,
                                        filled: true,
                                        border: OutlineInputBorder(
                                          borderRadius: BorderRadius.circular(30.0), // bo góc
                                          borderSide: BorderSide.none,
                                        ),
                                        // border: InputBorder.none, // loại bỏ đường viền
                                        // contentPadding: EdgeInsets.symmetric(vertical: 10), // khoảng cách giữa đường viền và văn bản
                                        hintText: 'Email', // placeholder
                                        hintStyle: TextStyle(
                                          color: Colors.grey, // màu placeholder
                                          fontSize: 15, // kích thước placeholder
                                        ),
                                      ),
                              )))
                            ]),
                          ],
                        ),
                    ),
                  // Padding(
                  //   padding: const EdgeInsets.fromLTRB(0, 20, 0, 20),
                  //   child: StreamBuilder(
                  //       //  stream: authBloc.emailStream,
                  //       builder: (context, snapshot) => TextFormField(
                  //             controller: _emailController,
                  //             validator: Validators.validateEmail,
                  //             style: const TextStyle(
                  //                 fontSize: 18, color: Colors.black),
                  //             decoration: InputDecoration(
                  //                 labelText: "Email",
                  //                 // errorText:
                  //                 //     snapshot.hasError ? snapshot.error : null,
                  //                 prefixIcon: Container(
                  //                     width: 50,
                  //                     child: const Icon(Icons.email)),
                  //                 border: const OutlineInputBorder(
                  //                     borderSide: BorderSide(
                  //                         color: Color(0xffCED0D2), width: 1),
                  //                     borderRadius: BorderRadius.all(
                  //                         Radius.circular(6)))),
                  //           )),
                  // ),
                  // Padding(
                  //   padding: const EdgeInsets.fromLTRB(0, 0, 135, 0),
                  //   child:
                  //       Text(errorMessage, style: TextStyle(color: Colors.red)),
                  // ),
                  Container(
                      width: 340,
                      height: 70,
                      // padding: EdgeInsets.only(right: 5.0),
                      // margin: EdgeInsets.symmetric(horizontal: 40),
                      margin: EdgeInsets.only(left: 40, right: 40),
                      decoration: BoxDecoration(
                        color: Color(0xff64abbf),
                      ),
                        child: Stack(
                          children: <Widget>[
                            Row(children: [
                              // SizedBox(width: 10),
                              Expanded(
                                child: Center(
                                  child: TextFormField(
                                    controller: _passController,
                                    validator: (value) {
                                      if (value == null || value.isEmpty) {
                                        return 'Please enter some text';
                                      }
                                      return null;
                                    },
                                    obscureText: _isObscured,
                                    style: TextStyle(
                                        color: Colors.black, // màu chữ
                                        fontSize: 15, // kích thước chữ
                                      ),
                                      decoration: InputDecoration(
                                        icon: Icon(
                                          Icons.lock_outline,
                                          color: Color(0xFFFFFFFF),
                                        ),
                                        constraints: BoxConstraints(
                                          maxHeight: 40, // chiều cao tối đa của TextField
                                          maxWidth: 280, // chiều rộng tối đa của TextField
                                        ),
                                        fillColor: Colors.white,
                                        filled: true,
                                        border: OutlineInputBorder(
                                          borderRadius: BorderRadius.circular(30.0), // bo góc
                                          borderSide: BorderSide.none,
                                        ),
                                        // border: InputBorder.none, // loại bỏ đường viền
                                        // contentPadding: EdgeInsets.symmetric(vertical: 10), // khoảng cách giữa đường viền và văn bản
                                        hintText: 'Password', // placeholder
                                        hintStyle: TextStyle(
                                          color: Colors.grey, // màu placeholder
                                          fontSize: 15, // kích thước placeholder
                                        ),
                                        suffixIcon: IconButton(
                                          icon: Icon(_isObscured ? Icons.visibility_off : Icons.visibility),
                                          onPressed: () {
                                            setState(() {
                                              _isObscured = !_isObscured;
                                            });
                                          },
                                        ),
                                      ),
                              )))
                            ]),
                          ],
                        ),
                    ),
                  // Padding(
                  //   padding: const EdgeInsets.fromLTRB(0, 0, 135, 0),
                  //   child:
                  //       Text(errorMessage, style: TextStyle(color: Colors.red)),
                  // ),
                  // StreamBuilder(
                  //     //  stream: authBloc.passStream,
                  //     builder: (context, snapshot) => TextFormField(
                  //           controller: _passController,
                  //           validator: (value) {
                  //             if (value == null || value.isEmpty) {
                  //               return 'Please enter some text';
                  //             }
                  //             return null;
                  //           },
                  //           obscureText: true,
                  //           style: const TextStyle(
                  //               fontSize: 18, color: Colors.black),
                  //           // ignore: prefer_const_constructors
                  //           decoration: InputDecoration(
                  //               // errorText:
                  //               //     snapshot.hasError ? snapshot.error : null,
                  //               labelText: "Password",
                  //               prefixIcon: const SizedBox(
                  //                   width: 50, child: Icon(Icons.lock)),
                  //               border: const OutlineInputBorder(
                  //                   borderSide: BorderSide(
                  //                       color: Color(0xffCED0D2), width: 1),
                  //                   borderRadius:
                  //                       BorderRadius.all(Radius.circular(6)))),
                  //         )),

                  Container(
                    margin: EdgeInsets.only(top: 20, bottom: 0, left: 90, right: 90),
                      height: 50,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                        primary: Color(0xff64abbf),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30.0), // set độ bo góc của nút
                        ),
                      ),
                        child: const Text('Sign up',
                        style: TextStyle(
                          color: Colors.white, // set màu sắc của chữ bên trong nút
                          fontWeight: FontWeight.bold,
                          fontSize: 30,
                        ),),
                        onPressed: () async {
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
                          Navigator.pop(context);
                                  },
                        ),
                  ),
                  // Padding(
                  //   padding: const EdgeInsets.fromLTRB(0, 30, 0, 40),
                  //   child: SizedBox(
                  //     width: double.infinity,
                  //     height: 52,
                  //     child: ElevatedButton(
                  //       onPressed: () {
                  //         print(_nameController.text);
                  //         print(_phoneController.text);
                  //         print(_emailController.text);
                  //         print(_passController.text);
                  //         if (!formGlobalKey.currentState!.validate()) {
                  //           return;
                  //           // use the email provided here
                  //         }
                  //         List<Device> list = [];
                  //         _firAuth.signUp(
                  //             _emailController.text,
                  //             _passController.text,
                  //             Users(
                  //                 phone: int.parse(_phoneController.text),
                  //                 name: _nameController.text,
                  //                 devices: list));
                  //         Navigator.pop(context);
                  //       },
                  //       child: const Text(
                  //         "Sign up",
                  //         style: const TextStyle(
                  //             color: Color(0xff64abbf), fontSize: 18),
                  //       ),
                  //     ),
                  //   ),
                  // ),
                  Container(
                    margin: EdgeInsets.only(top: 30),
                    child: Row(
                    // ignore: sort_child_properties_last
                    children: <Widget>[
                      const Text('Already a User?'),
                      TextButton(
                        child: const Text(
                          'Sigin Now',
                          style: TextStyle(fontSize: 20),
                        ),
                        onPressed: () {
                          Navigator.pop(context);
                        },
                      ),
                    ],
                    mainAxisAlignment: MainAxisAlignment.center,
                  ),
                  ),
                  // Padding(
                  //   padding: const EdgeInsets.fromLTRB(70, 0, 0, 40),
                  //   child: Row(children: <Widget>[
                  //     const Text('Already a User ?'),
                  //     TextButton(
                  //       onPressed: () async {
                  //         Navigator.pop(context);
                  //       },
                  //       child: const Text('Sigin Now',
                  //           style: TextStyle(fontSize: 20)),
                  //     )
                  //   ]),
                  // )
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
