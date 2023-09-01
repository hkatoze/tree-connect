import "package:flutter/material.dart";
import 'package:treeconnect/pages/scanPage/scan_page.dart';

void main() {
  runApp(TreeConnect());
}

class TreeConnect extends StatelessWidget {
  const TreeConnect({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: ScanPage(),
    );
  }
}
