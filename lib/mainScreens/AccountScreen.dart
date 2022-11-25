import 'package:flutter/material.dart';
import '../MovieDatabase.dart';

class AccountScreen extends StatefulWidget {
  const AccountScreen({Key? key}) : super(key: key);

  @override
  State<AccountScreen> createState() => _AccountScreenState();
}

class _AccountScreenState extends State<AccountScreen> {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        ListTile(
          leading: FlutterLogo(),
          title: Text('These ListTiles are expanded '),
        ),
        ListTile(
          trailing: FlutterLogo(),
          title: Text('to fill the available space.'),
        ),
      ],
    );
  }
}