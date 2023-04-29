import 'package:app/utils/vadilator.dart';
import 'package:app/view/Dashboard_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

import '../firebase_store/fire_base_auth.dart';

class ChangePasswordPage extends StatefulWidget {
  const ChangePasswordPage({super.key});

  @override
  State<ChangePasswordPage> createState() => _ChangePasswordPageState();
}

class _ChangePasswordPageState extends State<ChangePasswordPage> {
  var _firAuth = FirAuth();

  late TextEditingController _oldPasswordController;
  late TextEditingController _newPasswordController;
  late TextEditingController _confirmNewPasswordController;
  GlobalKey<FormState> formGlobalKey = new GlobalKey<FormState>();
  User user = FirebaseAuth.instance.currentUser!;

  @override
  void initState() {
    super.initState();
    _oldPasswordController = TextEditingController();
    _newPasswordController = TextEditingController();
    _confirmNewPasswordController = TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   title: Text('Change Password'),
      // ),
      body: Container(
        decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage("images/bg.png"), fit: BoxFit.cover)),
        key: formGlobalKey,
        // padding: const EdgeInsets.all(16.0),
        padding: EdgeInsets.fromLTRB(50, 0, 50, 0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
                  width: 340,
                  height: 50,
                  color: Color(0xff64abbf),
                  margin: EdgeInsets.only(top: 30, bottom: 40, left: 20, right: 20),
                  child: Stack(
                    children: [
                      // Positioned(
                      //   top: 5, // set vị trí đứng từ trên xuống, dựa vào giá trị y
                      //   left: 5, // set vị trí đứng từ phải qua, dựa vào giá trị x
                      //   child: IconButton(
                      //     icon: Icon(
                      //             Icons.arrow_back_outlined,
                      //             color: Color(0xFFFFFFFF),
                      //           ),
                      //     onPressed: () {
                      //       Navigator.push(
                      //         context,
                      //         MaterialPageRoute(builder: (context) => DashBoardPage()),
                      //       );
                      //       // Navigator.pop(context);
                      //     },
                      //   ),
                      // ),
                      Positioned(
                        // top: 30, // set vị trí đứng từ trên xuống, dựa vào giá trị y
                        // left: 0, // set vị trí đứng từ trái qua, dựa vào giá trị x
                        // right: 0,
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
                    ],
                  ),
                ),
            Text(
              'Old Password:',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(
              height: 8,
            ),
            TextFormField(
              controller: _oldPasswordController,
              obscureText: true,
              validator: (value) {
                if (value?.length == 1) {
                  return 'Please enter some text';
                }
                return null;
              },
            ),
            SizedBox(
              height: 16,
            ),
            Text(
              'New Password:',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(
              height: 8,
            ),
            TextField(
              controller: _newPasswordController,
              obscureText: true,
            ),
            SizedBox(
              height: 16,
            ),
            Text(
              'Confirm New Password:',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(
              height: 8,
            ),
            TextField(
              controller: _confirmNewPasswordController,
              obscureText: true,
            ),
            SizedBox(
              height: 32,
            ),
            Container(
              margin: EdgeInsets.only(top: 20, bottom: 0, left: 90, right: 90),
                height: 50,
              child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                  primary: Color(0xff64abbf), // set màu sắc của nút
                  // onPrimary: Colors.white, // set màu sắc của chữ
                  // padding: EdgeInsets.symmetric(vertical: 40.0, horizontal: 70.0), // set kích thước của nút
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30.0), // set độ bo góc của nút
                  ),
                ),
                  child: const Text('Save Changes',
                   style: TextStyle(
                    color: Colors.white, // set màu sắc của chữ bên trong nút
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                  ),),
                  onPressed: () async {
                    // Save new password
                String oldPassword = _oldPasswordController.text;
                String newPassword = _newPasswordController.text;
                String confirmNewPassword = _confirmNewPasswordController.text;

                if (oldPassword.isNotEmpty &&
                    newPassword.isNotEmpty &&
                    confirmNewPassword.isNotEmpty) {
                  if (newPassword == confirmNewPassword) {
                    print(newPassword);
                    try {
                      // Re-authenticate user
                      User user = FirebaseAuth.instance.currentUser!;
                      AuthCredential credential = EmailAuthProvider.credential(
                          email: user.email!, password: oldPassword);
                      await user.reauthenticateWithCredential(credential);

                      await user.updatePassword(newPassword);
                      Navigator.pop(context);
                    } catch (e) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text(e.toString()),
                        ),
                      );
                    }
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text(
                            'New password and Confirm new password do not match.'),
                      ),
                    );
                  }
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text('Please fill in all fields.'),
                    ),
                  );
                }
              },
                ),
            ),
            
            // ElevatedButton(
            //   onPressed: () async {
            //     // Save new password
            //     String oldPassword = _oldPasswordController.text;
            //     String newPassword = _newPasswordController.text;
            //     String confirmNewPassword = _confirmNewPasswordController.text;

            //     if (oldPassword.isNotEmpty &&
            //         newPassword.isNotEmpty &&
            //         confirmNewPassword.isNotEmpty) {
            //       if (newPassword == confirmNewPassword) {
            //         print(newPassword);
            //         try {
            //           // Re-authenticate user
            //           User user = FirebaseAuth.instance.currentUser!;
            //           AuthCredential credential = EmailAuthProvider.credential(
            //               email: user.email!, password: oldPassword);
            //           await user.reauthenticateWithCredential(credential);

            //           await user.updatePassword(newPassword);
            //           Navigator.pop(context);
            //         } catch (e) {
            //           ScaffoldMessenger.of(context).showSnackBar(
            //             SnackBar(
            //               content: Text(e.toString()),
            //             ),
            //           );
            //         }
            //       } else {
            //         ScaffoldMessenger.of(context).showSnackBar(
            //           SnackBar(
            //             content: Text(
            //                 'New password and Confirm new password do not match.'),
            //           ),
            //         );
            //       }
            //     } else {
            //       ScaffoldMessenger.of(context).showSnackBar(
            //         SnackBar(
            //           content: Text('Please fill in all fields.'),
            //         ),
            //       );
            //     }
            //   },
            //   child: Text('Save Changes'),
            // ),
          ],
        ),
      ),
    );
  }
}
