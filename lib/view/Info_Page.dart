import 'package:app/view/Dashboard_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

import '../firebase_store/fire_base_auth.dart';
import '../model/Users.dart';
import 'Home_Page.dart';

class InfoPage extends StatefulWidget {
  const InfoPage({super.key});

  @override
  State<InfoPage> createState() => _InfoPageState();
}

class _InfoPageState extends State<InfoPage> {
  var _firAuth = FirAuth();

  final email = FirebaseAuth.instance.currentUser!.email;
  @override
  Widget build(BuildContext context) {
    var info = ModalRoute.of(context)!.settings.arguments as Users;
    TextEditingController nameController =
        TextEditingController(text: info.name);
    TextEditingController emailController = TextEditingController(text: email);
    TextEditingController phoneController =
        TextEditingController(text: info.phone.toString());
    return Scaffold(
      appBar: AppBar(
        title: Text('Edit Profile'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Name:',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(
              height: 8,
            ),
            TextField(
              controller: nameController,
            ),
            SizedBox(
              height: 16,
            ),
            Text(
              'Phone:',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(
              height: 8,
            ),
            TextField(
              controller: phoneController,
            ),
            SizedBox(
              height: 16,
            ),
            Text(
              'Email:',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(
              height: 8,
            ),
            TextField(controller: emailController, enabled: false),
            SizedBox(
              height: 32,
            ),
            ElevatedButton(
              onPressed: () {
                // Save changes to user's profile
                _firAuth.updateUser(
                    nameController.text, phoneController.text, info.uid);
                info.name = nameController.text;
                info.phone = int.parse(phoneController.text);
                Navigator.pushNamed(context, HomePage.routeName,
                    arguments: info);
              },
              child: Text('Save Changes'),
            ),
          ],
        ),
      ),
    );
  }
}
