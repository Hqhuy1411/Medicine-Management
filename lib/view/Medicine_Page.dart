import 'package:app/model/Medicine.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class MedicinePage extends StatelessWidget {
  const MedicinePage({super.key});
  static String routeName = '/Medicine';

  @override
  Widget build(BuildContext context) {
    final info = ModalRoute.of(context)!.settings.arguments as Medicine;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Medicine'),
      ),
      body: ListView(
        padding: const EdgeInsets.all(8),
        children: <Widget>[
          Card(
            elevation: 4.0, // Add a drop shadow to the card
            margin: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                children: [
                  Icon(Icons.devices),
                  SizedBox(width: 16.0),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // ignore: prefer_interpolation_to_compose_strings
                        Text('Medicine Name:' + info.name,
                            style: Theme.of(context).textTheme.headline6),
                        Text('Medicine Description ' + info.description,
                            style: Theme.of(context).textTheme.subtitle1),
                        Text(info.Tousage(),
                            style: Theme.of(context).textTheme.subtitle1)
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          Card(
            elevation: 4.0, // Add a drop shadow to the card
            margin: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                children: [
                  Icon(
                    Icons.alarm,
                    size: 50,
                  ),
                  SizedBox(width: 32.0),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // ignore: prefer_interpolation_to_compose_strings
                        const Text('MORNING'),
                        Text(
                            DateFormat.jm()
                                .format(info.usage.mor.time)
                                .toString(),
                            style: Theme.of(context).textTheme.headline6),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          Card(
            elevation: 4.0, // Add a drop shadow to the card
            margin: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                children: [
                  Icon(
                    Icons.alarm,
                    size: 50,
                  ),
                  SizedBox(width: 32.0),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // ignore: prefer_interpolation_to_compose_strings
                        const Text('AFTERNOON'),
                        Text(
                            DateFormat.jm()
                                .format(info.usage.noon.time)
                                .toString(),
                            style: Theme.of(context).textTheme.headline6),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          Card(
            elevation: 4.0, // Add a drop shadow to the card
            margin: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                children: [
                  Icon(
                    Icons.alarm,
                    size: 50,
                  ),
                  SizedBox(width: 32.0),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      // ignore: prefer_const_literals_to_create_immutables
                      children: [
                        // ignore: prefer_interpolation_to_compose_strings
                        const Text('EVENING'),
                        Text(
                            DateFormat.jm()
                                .format(info.usage.even.time)
                                .toString(),
                            style: Theme.of(context).textTheme.headline6),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
