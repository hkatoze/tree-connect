import 'package:flutter/material.dart';
import 'package:treeconnect/pages/scanPage/widgets/citation_block.dart';
import 'package:treeconnect/pages/scanPage/widgets/scanning.dart';



class ScanPage extends StatefulWidget {
  const ScanPage({Key? key}) : super(key: key);

  @override
  State<ScanPage> createState() => _ScanPageState();
}

class _ScanPageState extends State<ScanPage> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
            backgroundColor: Color(0xFFc1e9d9),
            body: Container(
              width: double.infinity,
              height: double.infinity,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [CitationBlock(), ScanReturn()],
              ),
            )));
  }
}
