import 'package:flutter/material.dart';

import '../model/Medicine.dart';

class AppC extends StatefulWidget {
  final List<Medicine> list;
  const AppC({Key? key, required this.list}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<AppC> {
  @override
  Widget build(BuildContext context) {
    return Table(
      children: [
        TableRow(
          children: [
            TableCell(
              child: RotatedBox(
                quarterTurns: -1,
                child: Text('Header 1'),
              ),
            ),
            TableCell(
              child: Text('Value 1-1'),
            ),
            TableCell(
              child: Text('Value 1-2'),
            ),
            TableCell(
              child: Text('Value 1-3'),
            ),
          ],
        ),
        TableRow(
          children: [
            TableCell(
              child: RotatedBox(
                quarterTurns: -1,
                child: Text('Header 2'),
              ),
            ),
            TableCell(
              child: Text('Value 2-1'),
            ),
            TableCell(
              child: Text('Value 2-2'),
            ),
            TableCell(
              child: Text('Value 2-3'),
            ),
          ],
        ),
        TableRow(
          children: [
            TableCell(
              child: RotatedBox(
                quarterTurns: -1,
                child: Text('Header 3'),
              ),
            ),
            TableCell(
              child: Text('Value 3-1'),
            ),
            TableCell(
              child: Text('Value 3-2'),
            ),
            TableCell(
              child: Text('Value 3-3'),
            ),
          ],
        ),
      ],
    );
  }
}
