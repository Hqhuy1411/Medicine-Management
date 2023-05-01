// import 'package:firebase_auth/firebase_auth.dart';
import 'package:app/model/Box.dart';
import 'package:app/model/Device.dart';
import 'package:app/model/Medicine.dart';
import 'package:app/model/Patient.dart';
import 'package:app/model/TimeSlot.dart';
import 'package:app/model/Usage.dart';
import 'package:app/model/Users.dart';
import 'package:app/utils/Notification.dart';
import 'package:app/view/Box_Page.dart';
import 'package:app/view/Dashboard_page.dart';
import 'package:app/view/Device_Page.dart';
import 'package:app/view/Home_Page.dart';
import 'package:app/view/Medicine_Page.dart';
import 'package:app/view/Register_page.dart';
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
        DashBoardPage.routeName: (context) => const DashBoardPage(),
        DevicePage.routeName: ((context) => const DevicePage()),
        BoxPage.routeName: ((context) => const BoxPage()),
        MedicinePage.routeName: ((context) => const MedicinePage()),
        HomePage.routeName: (context) => const HomePage()
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
  NotificationsService notificationsService = NotificationsService();
  var _firAuth = FirAuth();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  // List<Medicine> list = [
  //   Medicine(
  //       name: "Thuoc sot",
  //       description: "Dau dau",
  //       quantity: 56,
  //       usage: Usage(mor: 2, noon: 2, even: 2)),
  //   Medicine(
  //       name: "Thuoc xo", description: "Dau bung", quantity: 21, usage: Usage())
  // ];

  @override
  void initState() {
    super.initState();
    notificationsService.initializeNotification();
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
              margin: EdgeInsets.only(top: 70, bottom: 20, left: 20, right: 20),
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
              // child: Stack(
              //   children: <Widget>[
              //     Positioned(
              //       top: 0,
              //       left: 0,
              //       right: 0,
              //       bottom: 0,
              //       child: Image.asset('images/icon_app.png', fit: BoxFit.cover),
              //       icon: Icon(
              //                   Icons.email_outlined,
              //                   color: Color(0xFFFFFFFF),
              //                 ),
              //     ),
              //   ],
              // ),
            ),

            Container(
              width: 70,
              height: 70,
              // padding: EdgeInsets.only(right: 5.0),
              // margin: EdgeInsets.symmetric(horizontal: 40),
              margin: EdgeInsets.only(top: 20, bottom: 0, left: 40, right: 40),
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
            // Container(
            //   padding: const EdgeInsets.all(10),
            //   child: Row(children: [
            //     Icon(Icons.account_circle_sharp),
            //     SizedBox(width: 10),
            //     Expanded(
            //         child: TextField(
            //       controller: emailController,
            //       decoration: const InputDecoration(
            //         border: OutlineInputBorder(),
            //         labelText: 'Email',
            //       ),
            //     ))
            //   ]),
            // ),
            Container(
              width: 70,
              height: 70,
              // padding: EdgeInsets.only(right: 5.0),
              margin: EdgeInsets.symmetric(horizontal: 40),
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
            // Container(
            //   padding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
            //   child: Row(children: [
            //     Icon(Icons.lock),
            //     SizedBox(width: 10),
            //     Expanded(
            //         child: TextField(
            //       obscureText: true,
            //       controller: passwordController,
            //       decoration: const InputDecoration(
            //         border: OutlineInputBorder(),
            //         labelText: 'Password',
            //       ),
            //     ))
            //   ]),
            // ),
            // SizedBox(width: 20),
            Container(
              margin: EdgeInsets.only(top: 10),
              child: Align(
                alignment: Alignment.centerRight,
                child: TextButton(
                  onPressed: () async {
                    //forgot password screen
                    // var order =
                    //     await _firAuth.getInfoUser("cCfa3TzR9NfQfWwsuLX1NBligBo2");
                    // print(order.Info());
                    // order.medicines.add(Medicine(
                    //     name: "Thuoc lac", description: "phe", quantity: 41));
                    // print(order.Info());

                    // _firAuth.deleteData();

                    // var millis = 1677690817000;
                    // var dt = DateTime.fromMillisecondsSinceEpoch(millis);
                    // print(DateFormat.jm().format(dt));
                    // var od =
                    //     await _firAuth.getInfoUser("8IXddhgOE7PVc96mE7Q1jMkVqqA3");
                    // print(od.name);
                    //notificationsService.sendNotification();
                    // notificationsService.sendNotification(
                    //     // e.getMedicine().usage.even.time.hour,
                    //     // e.getMedicine().usage.even.time.minute);
                    //     1,
                    //     8);
                  },
                  child: const Text(
                    'Forgot Password',
                  ),
                ),
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
                    'Login',
                    style: TextStyle(
                      color: Colors.white, // set màu sắc của chữ bên trong nút
                      fontWeight: FontWeight.bold,
                      fontSize: 30,
                    ),
                  ),
                  onPressed: () async {
                    if (nameController.text.isNotEmpty ||
                        passwordController.text.isNotEmpty ||
                        emailController.text.isNotEmpty) {
                      print(passwordController.text);
                      Users? user = await _firAuth.singIn(
                          emailController.text, passwordController.text);
                      print(user!.Info());
                      if (user != null) {
                        print(user.uid);
                        user.devices.forEach((element) {
                          element.boxs.forEach((e) {
                            if (e.getMedicine() != null) {
                              notificationsService.sendNotification(
                                  element.id!,
                                  e.id,
                                  e.getMedicine().usage.mor.time.hour,
                                  e.getMedicine().usage.mor.time.minute);
                              notificationsService.sendNotification(
                                  element.id!,
                                  e.id,
                                  e.getMedicine().usage.noon.time.hour,
                                  e.getMedicine().usage.noon.time.minute);
                              notificationsService.sendNotification(
                                  element.id!,
                                  e.id,
                                  e.getMedicine().usage.even.time.hour,
                                  e.getMedicine().usage.even.time.minute);
                              // 1,
                              // 5);
                            }
                          });
                        });
                        Navigator.pushNamed(context, HomePage.routeName,
                            arguments: user);
                      }
                      // _firAuth.singIn(
                      //     emailController.text, passwordController.text);
                      // Navigator.pushNamed(
                      //   context,
                      //   HomePage.routeName,
                      // );
                      // _firAuth.signUp(
                      //     emailController.text,
                      //     passwordController.text,
                      //     Users(
                      //       phone: int.parse(phoneController.text),
                      //       name: nameController.text,
                      //     ));

                      // Users user = Users(
                      //     phone: int.parse(phoneController.text),
                      //     name: nameController.text,
                      //     medicines: list);

                      // print(user.toJson());
                    }
                  },
                )),
            Container(
              margin: EdgeInsets.only(top: 30),
              child: Row(
                // ignore: sort_child_properties_last
                children: <Widget>[
                  const Text('Creating new account'),
                  TextButton(
                    child: const Text(
                      'Here',
                      style: TextStyle(fontSize: 20),
                    ),
                    onPressed: () {
                      //signup screen
                      // TEST update
                      // DateTime time = DateTime.now();
                      // Usage usage = Usage(
                      //     mor: TimeSlot(time: time, quantity: 1),
                      //     noon: TimeSlot(time: time, quantity: 1),
                      //     even: TimeSlot(time: time, quantity: 1));
                      // Medicine medicine = Medicine(
                      //     name: "Thuoc ke",
                      //     description: "phe",
                      //     quantity: 12,
                      //     usage: usage);
                      // List<Medicine> listMe = [medicine, medicine];
                      // Box box = Box(name: "Box1", medicines: listMe);
                      // Box box2 = Box(name: "Box2", medicines: listMe);
                      // List<Box> listBo = [box, box2];
                      // Device device = Device(
                      //     name: "Thiet bi so 1",
                      //     patient: Patient(id: "012dx", fullname: "Nguyen Van B"),
                      //     boxs: [box]);
                      // print(device.toJson().toString());

                      // _firAuth.AddMedicine(
                      //     device, "8IXddhgOE7PVc96mE7Q1jMkVqqA3");
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const RegisterPage()));
                    },
                  )
                ],
                mainAxisAlignment: MainAxisAlignment.center,
              ),
            ),
          ],
        ));
  }
}
