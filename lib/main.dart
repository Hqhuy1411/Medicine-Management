// import 'package:firebase_auth/firebase_auth.dart';
import 'package:app/model/Box.dart';
import 'package:app/model/Device.dart';
import 'package:app/model/Medicine.dart';
import 'package:app/model/Patient.dart';
import 'package:app/model/TimeSlot.dart';
import 'package:app/model/Usage.dart';
import 'package:app/model/Users.dart';
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

  static const String _title = 'Sample App';

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
        appBar: AppBar(title: const Text(_title)),
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
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.all(10),
        child: ListView(
          children: <Widget>[
            Container(
                alignment: Alignment.center,
                padding: const EdgeInsets.all(10),
                child: const Text(
                  'HELLO',
                  style: TextStyle(
                      color: Colors.blue,
                      fontWeight: FontWeight.w500,
                      fontSize: 30),
                )),
            Container(
                alignment: Alignment.center,
                padding: const EdgeInsets.all(10),
                child: const Text(
                  'Log in',
                  style: TextStyle(fontSize: 20),
                )),
            Container(
              padding: const EdgeInsets.all(10),
              child: TextField(
                controller: emailController,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Email',
                ),
              ),
            ),
            // Container(
            //   padding: const EdgeInsets.all(10),
            //   child: TextField(
            //     controller: nameController,
            //     decoration: const InputDecoration(
            //       border: OutlineInputBorder(),
            //       labelText: 'Name',
            //     ),
            //   ),
            // ),
            // Container(
            //   padding: const EdgeInsets.all(10),
            //   child: TextField(
            //     controller: phoneController,
            //     decoration: const InputDecoration(
            //       border: OutlineInputBorder(),
            //       labelText: 'Phone',
            //     ),
            //   ),
            // ),
            Container(
              padding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
              child: TextField(
                obscureText: true,
                controller: passwordController,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Password',
                ),
              ),
            ),
            TextButton(
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
                var od =
                    await _firAuth.getInfoUser("8IXddhgOE7PVc96mE7Q1jMkVqqA3");
                print(od.name);
              },
              child: const Text(
                'Forgot Password',
              ),
            ),
            Container(
                height: 50,
                padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                child: ElevatedButton(
                  child: const Text('Login'),
                  onPressed: () async {
                    if (nameController.text.isNotEmpty ||
                        passwordController.text.isNotEmpty ||
                        emailController.text.isNotEmpty) {
                      print(passwordController.text);
                      Users? user = await _firAuth.singIn(
                          emailController.text, passwordController.text);
                      print(user!.Info());
                      if (user != null) {
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
            Row(
              // ignore: sort_child_properties_last
              children: <Widget>[
                const Text('Does not have account?'),
                TextButton(
                  child: const Text(
                    'Sign up',
                    style: TextStyle(fontSize: 20),
                  ),
                  onPressed: () {
                    //signup screen
                    // TEST update
                    DateTime time = DateTime.now();
                    Usage usage = Usage(
                        mor: TimeSlot(time: time, quantity: 1),
                        noon: TimeSlot(time: time, quantity: 1),
                        even: TimeSlot(time: time, quantity: 1));
                    Medicine medicine = Medicine(
                        name: "Thuoc ke",
                        description: "phe",
                        quantity: 12,
                        usage: usage);
                    List<Medicine> listMe = [medicine, medicine];
                    Box box = Box(name: "Box1", medicines: listMe);
                    Box box2 = Box(name: "Box2", medicines: listMe);
                    List<Box> listBo = [box, box2];
                    Device device = Device(
                        name: "Thiet bi so 1",
                        patient: Patient(id: "012dx", fullname: "Nguyen Van B"),
                        boxs: [box]);
                    print(device.toJson().toString());

                    _firAuth.AddMedicine(
                        device, "8IXddhgOE7PVc96mE7Q1jMkVqqA3");
                    // Navigator.push(
                    //     context,
                    //     MaterialPageRoute(
                    //         builder: (context) => const RegisterPage()));
                  },
                )
              ],
              mainAxisAlignment: MainAxisAlignment.center,
            ),
          ],
        ));
  }
}
