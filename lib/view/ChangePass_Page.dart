import 'package:app/utils/vadilator.dart';
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
      appBar: AppBar(
        title: Text('Change Password'),
      ),
      body: Padding(
        key: formGlobalKey,
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
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
            ElevatedButton(
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
              child: Text('Save Changes'),
            ),
          ],
        ),
      ),
    );
  }
}
