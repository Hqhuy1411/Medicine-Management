import 'dart:convert';
import 'package:flutter/material.dart';

import '../model/Medicine.dart';
import 'package:http/http.dart' as http;

import '../utils/Row.dart';
import 'lib/view/Scrollable_widget.dart';

class App extends StatefulWidget {
  const App({Key? key}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<App> {
  List<Medicine> _medicines = [];

  @override
  void initState() {
    super.initState();
    fetchAlbum();
  }

  void fetchAlbum() async {
    final response = await http
        .get(Uri.parse('https://api.jsonbin.io/v3/b/64141d94c0e7653a05895f00'));

    if (response.statusCode == 200) {
      //return Album.fromJson(jsonDecode(response.body));;
      var list = jsonDecode(response.body);

      List<Medicine> medicines = [];
      for (var i in list['record']) {
        var data = i as Map<String, dynamic>;
        medicines.add(Medicine.fromJson(data));
      }
      setState(() {
        _medicines = medicines;
      });
    } else {
      throw Exception('Failed to load album');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ScrollableWidget(child: buildDataTable(_medicines)),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pop(context, _medicines);
        },
      ),
    );
  }

  Widget buildDataTable(List<Medicine> list) {
    final columns = ['Ten Thuoc', 'Mo Ta', 'So Luong', 'Sang', 'Chieu', 'Toi'];
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
          medicine.usage.mor.getTime(),
          medicine.usage.noon.getTime(),
          medicine.usage.even.getTime(),
        ];
        return DataRow(
          cells: Utils.modelBuilder(cells, (index, cell) {
            final showEditIcon = index == 3 || index == 4 || index == 5;
            return DataCell(Text('$cell'), showEditIcon: showEditIcon,
                onTap: () async {
              DateTime dateS = DateTime(2023, 1, 1);

              final time = await pickTime();
              if (time == null) return;
              final newtime = DateTime(
                  dateS.year, dateS.month, dateS.day, time.hour, time.minute);
              setState(() {
                if (index == 3) medicine.usage.mor.time = newtime;
                if (index == 4) medicine.usage.noon.time = newtime;
                if (index == 5) medicine.usage.even.time = newtime;
              });
            });
          }),
        );
      }).toList();
  Future<TimeOfDay?> pickTime() => showTimePicker(
      context: context, initialTime: TimeOfDay(hour: 7, minute: 0));
}
