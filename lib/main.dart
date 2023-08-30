// import 'package:firebase_auth/firebase_auth.dart';

import 'package:app/model/Users.dart';
import 'package:app/view/Box_Page.dart';
import 'package:app/view/Device_Page.dart';
import 'package:app/view/Medicine_Page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'firebase_options.dart';
import 'firebase_store/fire_base_auth.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  static const String _title = 'Smart Medicine Box App';

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      routes: {
        DevicePage.routeName: ((context) => const DevicePage()),
        BoxPage.routeName: ((context) => const BoxPage()),
        MedicinePage.routeName: ((context) => const MedicinePage()),
      },
      title: _title,
      home: Scaffold(
        // appBar: AppBar(title: const Text(_title)),
        body: const MyStatefulWidget(),
      ),
    );
  }
}

class MyStatefulWidget extends StatefulWidget {
  const MyStatefulWidget({Key? key}) : super(key: key);

  @override
  State<MyStatefulWidget> createState() => _MyStatefulWidgetState();
}

class _MyStatefulWidgetState extends State<MyStatefulWidget> {
  var _firAuth = FirAuth();
  TextEditingController emailController =
      TextEditingController(text: "hung@gmail.com");
  TextEditingController passwordController = TextEditingController(text: 'abc');

  @override
  void initState() {
    super.initState();
  }

  bool _isObscured = true;
  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage("images/bg.png"), fit: BoxFit.cover)),
        padding: const EdgeInsets.all(10),
        child: ListView(
          children: <Widget>[
            // Container(
            //     alignment: Alignment.center,
            //     padding: const EdgeInsets.all(10),
            //     child: const Text(
            //       'SMART MEDICINE BOX',
            //       style: TextStyle(
            //           color: Colors.blue,
            //           fontWeight: FontWeight.w500,
            //           fontSize: 30),
            //     )),
            Container(
              width: 120,
              height: 50,
              color: Color(0xff64abbf),
              // margin: EdgeInsets.symmetric(vertical: 100, horizontal: 50),
              margin: EdgeInsets.only(top: 30, bottom: 20, left: 20, right: 20),
              // alignment: Alignment.center,
              // decoration: BoxDecoration(
              //   color: Color(0xff64abbf),
              // ),
              child: Center(
                child: Text(
                  'SMART MEDICINE BOX',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 15.0,
                  ),
                ),
              ),
            ),
            // SizedBox(width: 20),
            Container(
              width: 150,
              height: 150,
              // margin: EdgeInsets.symmetric(vertical: 20, horizontal: 185),
              margin:
                  EdgeInsets.only(top: 20, bottom: 20, left: 130, right: 130),
              decoration: BoxDecoration(
                color: Color(0xff64abbf),
                image: DecorationImage(
                  image: AssetImage('images/icon_app.png'),
                  fit: BoxFit.cover,
                ),
                borderRadius: BorderRadius.circular(10),
              ),
            ),
            Container(
              width: 150,
              height: 70,
              // padding: EdgeInsets.only(right: 5.0),
              // margin: EdgeInsets.symmetric(horizontal: 40),
              margin: EdgeInsets.only(top: 20, bottom: 0, left: 20, right: 20),
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
                      controller: emailController,
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
                        hintText: 'Your Email', // placeholder
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
            Container(
              width: 70,
              height: 70,
              // padding: EdgeInsets.only(right: 5.0),
              margin: EdgeInsets.only(top: 0, bottom: 0, left: 20, right: 20),
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
                      obscureText: _isObscured,
                      controller: passwordController,
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
                        hintText: 'Your Password', // placeholder
                        hintStyle: TextStyle(
                          color: Colors.grey, // màu placeholder
                          fontSize: 15, // kích thước placeholder
                        ),
                        suffixIcon: IconButton(
                          icon: Icon(_isObscured
                              ? Icons.visibility_off
                              : Icons.visibility),
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
            // SizedBox(width: 30),
            Container(
                margin:
                    EdgeInsets.only(top: 20, bottom: 0, left: 90, right: 90),
                height: 50,
                // padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    primary: Color(0xff64abbf), // set màu sắc của nút
                    // onPrimary: Colors.white, // set màu sắc của chữ
                    // padding: EdgeInsets.symmetric(vertical: 40.0, horizontal: 70.0), // set kích thước của nút
                    shape: RoundedRectangleBorder(
                      borderRadius:
                          BorderRadius.circular(30.0), // set độ bo góc của nút
                    ),
                  ),
                  child: const Text(
                    'GO',
                    style: TextStyle(
                      color: Colors.white, // set màu sắc của chữ bên trong nút
                      fontWeight: FontWeight.bold,
                      fontSize: 30,
                    ),
                  ),
                  onPressed: () async {
                    if (passwordController.text.isNotEmpty ||
                        emailController.text.isNotEmpty) {
                      print(passwordController.text);
                      Users? user =
                          await _firAuth.singIn("hung@gmail.com", "Huy1234");
                      print(user!.Info());
                      final item = user.devices[1];
                      final obSend = {"item": item, "uid": user.uid};
                      Navigator.pushNamed(context, DevicePage.routeName,
                          arguments: obSend);
                    }
                  },
                )),
          ],
        ));
  }
}
