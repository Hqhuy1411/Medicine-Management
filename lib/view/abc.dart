import 'dart:convert';
import 'package:flutter/material.dart';

import '../model/Medicine.dart';
import 'package:http/http.dart' as http;
import 'package:time_picker_widget/time_picker_widget.dart' as tpk;

import '../utils/Row.dart';
import 'lib/view/Scrollable_widget.dart';

class App extends StatefulWidget {
  final List<Medicine> list;
  const App({Key? key, required this.list}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<App> {
  // @override
  // void initState() {
  //   super.initState();
  //   fetchAlbum();
  // }

  // void fetchAlbum() async {
  //   final response = await http
  //       .get(Uri.parse('https://api.jsonbin.io/v3/b/64141d94c0e7653a05895f00'));

  //   if (response.statusCode == 200) {
  //     //return Album.fromJson(jsonDecode(response.body));;
  //     var list = jsonDecode(response.body);

  //     List<Medicine> medicines = [];
  //     for (var i in list['record']) {
  //       var data = i as Map<String, dynamic>;
  //       medicines.add(Medicine.fromJson(data));
  //     }
  //     setState(() {
  //       _medicines = medicines;
  //     });
  //   } else {
  //     throw Exception('Failed to load album');
  //   }
  // }
  DateTime dateS = DateTime(2023, 1, 1);
  DateTime dateC = DateTime(2023, 1, 1);
  DateTime dateT = DateTime(2023, 1, 1);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
          decoration: BoxDecoration(
              image: DecorationImage(
                  image: AssetImage("images/bg.png"), fit: BoxFit.cover)),
          padding: EdgeInsets.fromLTRB(30, 0, 30, 0),
          // child:
          child: Column(children: [
            SizedBox(
              height: 60,
            ),
            Row(
              children: [
                SizedBox(
                  width: 30,
                ),
                Text('MORNING'),
                SizedBox(
                  width: 30,
                ),
                Expanded(
                  child: ElevatedButton(
                      child: dateS.hour == 0
                          ? Text("Select Time")
                          : Text('${dateS.hour}' ': ${dateS.minute}'),
                      style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all<Color>(
                              Color(0xff64abbf))),
                      onPressed: () async {
                        final time = await pickTime(0);
                        if (time == null) return;
                        final newtime = DateTime(dateS.year, dateS.month,
                            dateS.day, time.hour, time.minute);
                        setState(() {
                          dateS = newtime;
                          widget.list.forEach((element) {
                            element.usage.mor.time = dateS;
                          });
                        });
                        print('Sang');
                      }),
                )
              ],
            ),
            Row(
              children: [
                SizedBox(
                  width: 30,
                ),
                Text('AFTERNOON'),
                SizedBox(
                  width: 13,
                ),
                Expanded(
                  child: ElevatedButton(
                      child: dateC.hour == 0
                          ? Text("Select Time")
                          : Text('${dateC.hour}' ': ${dateC.minute}'),
                      style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all<Color>(
                              Color(0xff64abbf))),
                      onPressed: () async {
                        final time = await pickTime(1);
                        if (time == null) return;
                        final newtime = DateTime(dateC.year, dateC.month,
                            dateC.day, time.hour, time.minute);
                        setState(() {
                          dateC = newtime;
                          widget.list.forEach((element) {
                            element.usage.noon.time = dateC;
                          });
                        });
                        print('Trua');
                      }),
                )
              ],
            ),
            Row(
              children: [
                SizedBox(
                  width: 36,
                ),
                Text('EVENING'),
                SizedBox(
                  width: 30,
                ),
                Expanded(
                  child: ElevatedButton(
                      child: dateT.hour == 0
                          ? Text("Select Time")
                          : Text('${dateT.hour}' ': ${dateT.minute}'),
                      style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all<Color>(
                              Color(0xff64abbf)),
                          fixedSize:
                              MaterialStateProperty.all<Size>(Size(100, 30))),
                      onPressed: () async {
                        final time = await pickTime(2);
                        if (time == null) return;
                        final newtime = DateTime(dateT.year, dateT.month,
                            dateT.day, time.hour, time.minute);
                        setState(() {
                          dateT = newtime;
                          widget.list.forEach((element) {
                            element.usage.even.time = dateT;
                          });
                        });
                        print('Toi');
                      }),
                )
              ],
            ),
            ScrollableWidget(child: buildDataTable(widget.list))
          ])),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pop(context, widget.list);
        },
      ),
    );
  }

  void fillTime(int buoi, List<Medicine> list) {
    if (buoi == 0) {
      setState(() {
        list.forEach((element) {
          element.usage.mor.time = dateS;
        });
      });
    }
    if (buoi == 1) {
      setState(() {
        list.forEach((element) {
          element.usage.noon.time = dateC;
        });
      });
    }
    if (buoi == 2) {
      setState(() {
        for (var e in list) {
          print(e.name);
        }
      });
    }
  }

  Widget buildDataTable(List<Medicine> list) {
    final columns = [
      'Ten Thuoc',
      'Mo Ta',
      'So Luong',
      'Sang',
      'Chieu',
      'Toi',
    ];
    return DataTable(
      columns: getColumns(columns),
      rows: getRows(list),
    );
  }

  List<DataColumn> getColumns(List<String> columns) {
    return columns.map((String column) {
      return DataColumn(
        label: Text(column),
      );
    }).toList();
  }

  List<DataRow> getRows(List<Medicine> medicines) =>
      medicines.map((Medicine medicine) {
        final cells = [
          medicine.name,
          medicine.description,
          medicine.quantity,
          medicine.usage.mor.quantity,
          medicine.usage.noon.quantity,
          medicine.usage.even.quantity,
        ];
        return DataRow(
          cells: Utils.modelBuilder(cells, (index, cell) {
            return DataCell(Text('$cell'), showEditIcon: true, onTap: () async {
              final edit = await openDialog(medicine, index);
              print(edit);
              switch (index) {
                case 0:
                  medicine.name = edit.toString();
                  break;
                case 1:
                  medicine.description = edit.toString();
                  break;
                case 2:
                  medicine.quantity = int.parse(edit.toString());
                  break;
                case 3:
                  medicine.usage.mor.quantity = edit.toString();
                  break;
                case 4:
                  medicine.usage.noon.quantity = edit.toString();
                  break;
                case 5:
                  medicine.usage.even.quantity = edit.toString();
                  break;
                default:
              }
              print(medicine.name);
              setState(() {
                for (var e in medicines) {}
              });
              // DateTime dateS = DateTime(2023, 1, 1);
              // final time = await pickTime();
              // if (time == null) return;
              // final newtime = DateTime(
              //     dateS.year, dateS.month, dateS.day, time.hour, time.minute);
              // setState(() {
              //   if (index == 4) medicine.usage.mor.time = newtime;
              //   if (index == 6) medicine.usage.noon.time = newtime;
              //   if (index == 8) medicine.usage.even.time = newtime;
              // });
            });
          }),
        );
      }).toList();
  Future<TimeOfDay?> pickTime(int buoi) {
    int min = 0;
    int max = 0;
    if (buoi == 0) {
      min = 5;
      max = 9;
    } else if (buoi == 1) {
      min = 10;
      max = 15;
    } else {
      min = 16;
      max = 21;
    }
    return tpk.showCustomTimePicker(
        context: context,
        onFailValidation: (context) => print('Unavailable selection'),
        initialTime: buoi == 0
            ? TimeOfDay(hour: 7, minute: 0)
            : buoi == 1
                ? TimeOfDay(hour: 11, minute: 30)
                : TimeOfDay(hour: 18, minute: 30),
        selectableTimePredicate: (time) =>
            time!.minute % 15 == 0 && time.hour >= min && time.hour <= max);
  }

  Future openDialog(Medicine medicine, int index) {
    var controller2;
    switch (index) {
      case 0:
        controller2 = TextEditingController(text: medicine.name);
        break;
      case 1:
        controller2 = TextEditingController(text: medicine.description);
        break;
      case 2:
        controller2 = TextEditingController(text: medicine.quantity.toString());
        break;
      case 3:
        controller2 =
            TextEditingController(text: medicine.usage.mor.quantity.toString());
        break;
      case 4:
        controller2 = TextEditingController(
            text: medicine.usage.noon.quantity.toString());
        break;
      case 5:
        controller2 = TextEditingController(
            text: medicine.usage.even.quantity.toString());
        break;
      default:
    }
    return showDialog(
        context: context,
        builder: (context) => AlertDialog(
              title: const Text('Edit'),
              content: TextField(
                controller: controller2,
                decoration: const InputDecoration(
                    hintText: 'You Edit', border: OutlineInputBorder()),
              ),
              actions: [
                ElevatedButton(
                  child: const Text('Done'),
                  onPressed: () => Navigator.of(context).pop(controller2.text),
                )
              ],
            ));
  }
}
