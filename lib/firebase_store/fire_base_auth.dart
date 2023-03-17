// ignore_for_file: unused_local_variable

import 'dart:convert';

import 'package:app/model/Box.dart';
import 'package:app/model/Device.dart';
import 'package:app/model/Medicine.dart';
import 'package:app/model/Users.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';

class FirAuth {
  final FirebaseAuth _fireBaseAuth = FirebaseAuth.instance;

  void signUp(String email, String pass, Users user_) {
    _fireBaseAuth
        .createUserWithEmailAndPassword(email: email, password: pass)
        .then((user) {
      _createUser(user.user!.uid, user_);
    }).catchError((err) {
      print("err: " + err.toString());
    });
  }

  Future<Users?> singIn(String email, String password) async {
//     _fireBaseAuth
//         .signInWithEmailAndPassword(email: email, password: password)
//         .then((user) async {
//       print("Dang nhap thanh cong");
//       var ref = FirebaseDatabase.instance
//           .ref()
//           .child("users")
//           .onValue
//           .listen((event) async {
//          final data = Map<String, dynamic>.from(event.snapshot.value as Map);
//         data.forEach((key, value) {
//           print('UID and info :$value');
//           var data1 = Map<String, dynamic>.from(value as Map);
//           print('keys ' '$key');
//           Users? users = _getInfoUser(key, data1, user.user!.uid);
//           print(users?.Info());
//         });
//       });

// // Print the data of the snapshot
//     }).catchError((err) {
//       print("Dang nhap tht bai");
//     });
    UserCredential userCredential = await _fireBaseAuth
        .signInWithEmailAndPassword(email: email, password: password);
    User? user = userCredential.user;
    print(user!.uid);
    return getInfoUser(user.uid);
  }

  void changePassword(
      User user, String currentPassword, String newPassword) async {
    final cred = EmailAuthProvider.credential(
        email: user.email.toString(), password: currentPassword);

    user.reauthenticateWithCredential(cred).then((value) {
      user.updatePassword(newPassword).then((_) {
        //Success, do something
        print("Cap nhat thanh cong");
      }).catchError((error) {
        throw error;
      });
    }).catchError((err) {});
  }

  Users? _getInfoUser(String keys, Map<String, dynamic> values, String uid) {
    if (keys == uid) {
      var user = Users.fromJson(values);
      user.uid = uid;
      return user;
    }
    return null;
  }

  Future<Users> getInfoUser(String udi) async {
    var users;
    var ref = FirebaseDatabase.instance.ref().child("users");
    DatabaseEvent event = await ref.orderByKey().equalTo(udi).once();
    final data = Map<String, dynamic>.from(event.snapshot.value as Map);
    data.forEach((key, value) {
      var data1 = Map<String, dynamic>.from(value as Map);
      users = Users.fromJson(data1);
      users.uid = udi;
    });
    return Future.value(users);
  }

  _createUser(String userId, Users user) {
    var ref = FirebaseDatabase.instance.ref().child("users");
    ref.child(userId).set(user.toJson()).then((vl) {
      print("on value: SUCCESSED");
    }).catchError((err) {
      print("err: " + err.toString());
    }).whenComplete(() {
      print("completed");
    });
  }

  void AddMedicine(Device device, String userId) async {
    var order = await getInfoUser(userId);
    order.devices.add(device);
    print(order.devices[0].id);
    var ref = FirebaseDatabase.instance.ref().child("users");
    ref.child(userId).update(
        {"devices": order.devices.map((e) => e.toJson()).toList()}).then((vl) {
      print("on value: SUCCESSED");
    }).catchError((err) {
      print("err: " + err.toString());
    }).whenComplete(() {
      print("completed");
    });
  }

  void UpdateDevice(Users user) async {
    var order = await getInfoUser(user.uid);
    order.devices = user.devices;
    var ref = FirebaseDatabase.instance.ref().child("users");
    ref.child(user.uid).update(
        {"devices": order.devices.map((e) => e.toJson()).toList()}).then((vl) {
      print("on value: SUCCESSED");
    }).catchError((err) {
      print("err: " + err.toString());
    }).whenComplete(() {
      print("completed");
    });
  }

  void AddMedicine3(Box box, int device, String userId) async {
    var order = await getInfoUser(userId);
    order.devices.forEach((e1) => {
          if (e1.id == device) {e1.boxs.add(box)}
        });

    var ref = FirebaseDatabase.instance.ref().child("users");
    ref.child(userId).update(
        {"devices": order.devices.map((e) => e.toJson()).toList()}).then((vl) {
      print("on value: SUCCESSED");
    }).catchError((err) {
      print("err: " + err.toString());
    }).whenComplete(() {
      print("completed");
    });
  }

  void AddMedicine2(
      Medicine medicine, int device, int box, String userId) async {
    var order = await getInfoUser(userId);
    order.devices.forEach((e1) => {
          if (e1.id == device)
            {
              e1.boxs.forEach((e2) => {
                    if (e2.id == box) {e2.medicines.add(medicine)}
                  })
            }
        });

    var ref = FirebaseDatabase.instance.ref().child("users");
    ref.child(userId).update(
        {"devices": order.devices.map((e) => e.toJson()).toList()}).then((vl) {
      print("on value: SUCCESSED");
    }).catchError((err) {
      print("err: " + err.toString());
    }).whenComplete(() {
      print("completed");
    });
  }

  void UpdateMedicine(Box box, int device, String userId) async {
    var order = await getInfoUser(userId);
    order.devices.forEach((e1) => {
          if (e1.id == device)
            {
              e1.boxs.forEach((e2) => {
                    if (e2.id == box.id) {e2.medicines = box.medicines}
                  })
            }
        });

    var ref = FirebaseDatabase.instance.ref().child("users");
    ref.child(userId).update(
        {"devices": order.devices.map((e) => e.toJson()).toList()}).then((vl) {
      print("on value: SUCCESSED");
    }).catchError((err) {
      print("err: " + err.toString());
    }).whenComplete(() {
      print("completed");
    });
  }

  void updateUser(String name, String phone, String uid) async {
    var ref = FirebaseDatabase.instance.ref().child("users");
    ref
        .child(uid)
        .update({"name": name, "phone": int.parse(phone)})
        .then((vl) => print("on value: SUCCESSED"))
        .catchError((err) {
          print("err: " + err.toString());
        })
        .whenComplete(() {
          print("completed");
        });
  }

  Future<bool> checkEmailExists(String email) async {
    List<String> methods =
        await _fireBaseAuth.fetchSignInMethodsForEmail(email);
    return methods.length > 0;
  }

  Future deleteData() async {
    try {
      await FirebaseDatabase.instance
          .ref()
          .child("users")
          .child("8IXddhgOE7PVc96mE7Q1jMkVqqA3")
          .child("medicines")
          .child("0")
          .remove();
    } catch (e) {
      return false;
    }
  }
}
