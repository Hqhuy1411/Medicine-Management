// import 'package:app/model/Device.dart';
// import 'package:app/view/abc.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';

// class MyModalBottomSheet extends StatefulWidget {
//   Device item;
//   MyModalBottomSheet({Key? key, required this.item}) : super(key: key);

//   @override
//   State<MyModalBottomSheet> createState() => _MyWidgetState(item);
// }

// class _MyWidgetState extends State<MyModalBottomSheet> {
//   late Device device;
//   void initState() {
//     super.initState();
//     device = widget.item;
//   }

//   TextEditingController nameMedicine =
//       new TextEditingController(text: "Thiet bi so" + device.id.toString());
//   TextEditingController descripMedicine =
//       new TextEditingController(text: widget.item.description);
//   TextEditingController quantityMedicine =
//       new TextEditingController(text: widget.item.patient.fullname);

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text("EDIT"),
//       ),
//       body: Container(
//           child: Padding(
//               padding: const EdgeInsets.all(8.0),
//               child: Form(
//                   child: Column(children: <Widget>[
                // TextFormField(
                //   controller: nameMedicine,
                //   decoration: InputDecoration(
                //     labelText: 'Name',
                //   ),
                // ),
                // TextFormField(
                //   controller: descripMedicine,
                //   decoration: InputDecoration(
                //     labelText: 'Description',
                //     icon: const Icon(Icons.email),
                //   ),
                // ),
                // TextFormField(
                //   controller: quantityMedicine,
                //   decoration: const InputDecoration(
                //     labelText: 'Name Patient',
                //     icon: Icon(Icons.message),
                //   ),
                // ),
//                 ElevatedButton(
//                   onPressed: () {
//                     setState(() {
//                       widget.item.description = descripMedicine.text;
//                       widget.item.patient.fullname = quantityMedicine.text;
//                     });
//                   },
//                   child: const Text('Save'),
//                 ),
//               ])))),
//     );
//   }
// }
