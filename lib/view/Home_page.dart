import 'package:app/model/Usage.dart';
import 'package:app/model/Users.dart';
import 'package:app/view/text_dialog_widget.dart';
import 'package:flutter/material.dart';
import '../firebase_store/fire_base_auth.dart';
import '../model/Medicine.dart';
import '../utils/Row.dart';
import 'Scrollable_widget.dart';

class HomePage extends StatefulWidget {
  static String routeName = '/Home';
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  var _firAuth = FirAuth();

  TextEditingController nameMedicine = new TextEditingController();
  TextEditingController descripMedicine = new TextEditingController();
  TextEditingController quantityMedicine = new TextEditingController(text: '0');

  @override
  Widget build(BuildContext context) {
    var info = ModalRoute.of(context)!.settings.arguments as Users;
    return Scaffold(
      body: ScrollableWidget(child: buildDataTable(info)),
      floatingActionButton: FloatingActionButton(
          onPressed: (() {
            _displayTextInputDialog(context, info);
          }),
          child: const Icon(Icons.add)),
    );
  }

  Widget buildDataTable(Users users) {
    final columns = ['Ten Thuoc', 'Mo Ta', 'So Luong', 'Sang', 'Chieu', 'Toi'];

    return DataTable(
      columns: getColumns(columns),
      rows: getRows(users.medicines, users.uid),
    );
  }

  List<DataColumn> getColumns(List<String> columns) {
    return columns.map((String column) {
      return DataColumn(
        label: Text(column),
      );
    }).toList();
  }

  late Medicine medicine;

  List<DataRow> getRows(List<Medicine> medicines, String uid) =>
      medicines.map((Medicine medicine) {
        final cells = [
          medicine.name,
          medicine.description,
          medicine.quantity,
          medicine.usage.mor,
          medicine.usage.noon,
          medicine.usage.even
        ];

        return DataRow(
          cells: Utils.modelBuilder(cells, (index, cell) {
            return DataCell(Text('$cell'), showEditIcon: true, onTap: () async {
              final nameEdit = await openDialog(medicine);
              List<Medicine> list = medicines
                  .map((e) => e == medicine ? e.copy(name: nameEdit) : e)
                  .toList();
              setState(() {
                medicines.clear();
                for (var element in list) {
                  medicines.add(element);
                }
                _firAuth.UpdateMedicine(medicines, uid);
              });
            });
          }),
        );
      }).toList();

  Future openDialog(Medicine medicine) {
    TextEditingController controller2 =
        TextEditingController(text: medicine.name);
    return showDialog(
        context: context,
        // ignore: prefer_const_constructors
        builder: (context) => AlertDialog(
              title: const Text('Edit'),
              content: TextField(
                controller: controller2,
                decoration: const InputDecoration(
                    hintText: 'You name', border: OutlineInputBorder()),
              ),
              actions: [
                ElevatedButton(
                  child: const Text('Done'),
                  onPressed: () => Navigator.of(context).pop(controller2.text),
                )
              ],
            ));
  }

  Future<void> _displayTextInputDialog(BuildContext context, Users info) async {
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text('TextField in Dialog'),
            content: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Form(
                  child: Column(
                children: <Widget>[
                  TextFormField(
                    // ignore: prefer_const_constructors
                    controller: nameMedicine,
                    decoration: InputDecoration(
                      labelText: 'Name',
                      icon: const Icon(Icons.account_box),
                    ),
                  ),
                  TextFormField(
                    // ignore: prefer_const_constructors
                    controller: descripMedicine,
                    // ignore: prefer_const_constructors
                    decoration: InputDecoration(
                      labelText: 'Description',
                      icon: const Icon(Icons.email),
                    ),
                  ),
                  TextFormField(
                    // ignore: prefer_const_constructors
                    controller: quantityMedicine,
                    keyboardType: TextInputType.number,
                    decoration: const InputDecoration(
                      labelText: 'Quantity',
                      icon: Icon(Icons.message),
                    ),
                  ),
                ],
              )),
            ),
            actions: <Widget>[
              ElevatedButton(
                child: Text('CANCEL'),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
              ElevatedButton(
                child: Text('OK'),
                onPressed: () {
                  setState(() {
                    medicine = Medicine(
                        name: nameMedicine.text,
                        quantity: int.parse(quantityMedicine.text),
                        description: descripMedicine.text,
                        usage: Usage());
                    _firAuth.AddMedicine(medicine, info.uid);
                    info.medicines.add(medicine);
                    Navigator.pop(context);
                  });
                  nameMedicine.text = '';
                  quantityMedicine.text = '';
                },
              ),
            ],
          );
        });
  }
}
