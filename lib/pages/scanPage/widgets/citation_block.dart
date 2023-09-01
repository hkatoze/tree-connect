import "package:flutter/material.dart";
import 'package:treeconnect/constant.dart';

class CitationBlock extends StatefulWidget {
  const CitationBlock({Key? key}) : super(key: key);

  @override
  State<CitationBlock> createState() => _CitationBlockState();
}

class _CitationBlockState extends State<CitationBlock> {
  @override
  Widget build(BuildContext context) {
    return Flexible(
        flex: 3,
        child: Container(
          decoration: BoxDecoration(
              color: Color(0xFFc1e9d9),
              image: DecorationImage(
                  fit: BoxFit.fill,
                  image: AssetImage("assets/images/header_background.png"))),
          child: Container(
              margin: EdgeInsets.symmetric(
                horizontal: width(context, 0.1),
              ),
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: height(context, 0.05),
                    ),
                    Text(
                      "Connecte ta plante !",
                      style: TextStyle(
                          fontSize: 25,
                          color: Colors.white,
                          fontWeight: FontWeight.bold),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                        "Qui vient de planter un arbre,doit apprendre à patienter avant d'en recueillir les fruits.",
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.white,
                        )),
                    SizedBox(
                      height: height(context, 0.1),
                    ),
                  ])),
        ));
  }
}
