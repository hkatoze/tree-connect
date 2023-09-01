import "package:flutter/material.dart";
import 'package:fluttertoast/fluttertoast.dart';
import 'package:flutter_blue/flutter_blue.dart';
import 'package:liquid_pull_to_refresh/liquid_pull_to_refresh.dart';

import 'package:treeconnect/constant.dart';

class Network extends StatefulWidget {
  final int periphericRssi;
  const Network({Key? key, required this.periphericRssi}) : super(key: key);

  @override
  State<Network> createState() => _NetworkState();
}

class _NetworkState extends State<Network> {
  @override
  Container rssiGraph(int rssi) {
    if (rssi >= 70 && rssi <= 90) {
      return Container(
        child: Row(crossAxisAlignment: CrossAxisAlignment.end, children: [
          NetworkLine(number: 1, isActivated: true),
          SizedBox(
            width: 2,
          ),
          NetworkLine(number: 2, isActivated: false),
          SizedBox(
            width: 2,
          ),
          NetworkLine(number: 3, isActivated: false),
          SizedBox(
            width: 2,
          ),
          NetworkLine(number: 4, isActivated: false),
        ]),
      );
    } else if (rssi >= 60 && rssi <= 70) {
      return Container(
        child: Row(crossAxisAlignment: CrossAxisAlignment.end, children: [
          NetworkLine(number: 1, isActivated: true),
          SizedBox(
            width: 2,
          ),
          NetworkLine(number: 2, isActivated: true),
          SizedBox(
            width: 2,
          ),
          NetworkLine(number: 3, isActivated: false),
          SizedBox(
            width: 2,
          ),
          NetworkLine(number: 4, isActivated: false),
        ]),
      );
    } else if (rssi >= 50 && rssi <= 60) {
      return Container(
        child: Row(crossAxisAlignment: CrossAxisAlignment.end, children: [
          NetworkLine(number: 1, isActivated: true),
          SizedBox(
            width: 2,
          ),
          NetworkLine(number: 2, isActivated: true),
          SizedBox(
            width: 2,
          ),
          NetworkLine(number: 3, isActivated: true),
          SizedBox(
            width: 2,
          ),
          NetworkLine(number: 4, isActivated: false),
        ]),
      );
    } else if (rssi < 50) {
      return Container(
        child: Row(crossAxisAlignment: CrossAxisAlignment.end, children: [
          NetworkLine(number: 1, isActivated: true),
          SizedBox(
            width: 2,
          ),
          NetworkLine(number: 2, isActivated: true),
          SizedBox(
            width: 2,
          ),
          NetworkLine(number: 3, isActivated: true),
          SizedBox(
            width: 2,
          ),
          NetworkLine(number: 4, isActivated: true),
        ]),
      );
    } else {
      return Container(
        child: Row(crossAxisAlignment: CrossAxisAlignment.end, children: [
          NetworkLine(number: 1, isActivated: false),
          SizedBox(
            width: 2,
          ),
          NetworkLine(number: 2, isActivated: false),
          SizedBox(
            width: 2,
          ),
          NetworkLine(number: 3, isActivated: false),
          SizedBox(
            width: 2,
          ),
          NetworkLine(number: 4, isActivated: false),
        ]),
      );
    }
  }

  Widget build(BuildContext context) {
    return Container(
      child: Column(children: [
        rssiGraph(widget.periphericRssi * (-1)),
        SizedBox(
          height: 1,
        ),
        Container(
            child: Text(
          widget.periphericRssi.toString(),
          style: TextStyle(color: Color(0xFFabc9ba), fontSize: 12),
        ))
      ]),
    );
  }
}

class NetworkLine extends StatefulWidget {
  final double number;
  final bool isActivated;
  const NetworkLine({Key? key, required this.number, required this.isActivated})
      : super(key: key);

  @override
  State<NetworkLine> createState() => _NetworkLineState();
}

class _NetworkLineState extends State<NetworkLine> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: widget.number == 1
          ? 15
          : (widget.number == 2
              ? 20
              : widget.number == 3
                  ? 25
                  : 30),
      width: 4,
      decoration: BoxDecoration(
          color: widget.isActivated ? Color(0xFF7ab99c) : Color(0xFFc5e7d4),
          borderRadius: BorderRadius.circular(5)),
    );
  }
}

class PeriphericItem extends StatefulWidget {
  final String periphericName;
  final int periphericRssi;
  const PeriphericItem(
      {Key? key, required this.periphericName, required this.periphericRssi})
      : super(key: key);

  @override
  State<PeriphericItem> createState() => _PeriphericItemState();
}

class _PeriphericItemState extends State<PeriphericItem> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      margin:
          EdgeInsets.symmetric(horizontal: width(context, 0.1), vertical: 10),
      width: width(context, 0.79),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(25), color: Color(0XFFFFFFFF)),
      child: Row(children: [
        Network(
          periphericRssi: widget.periphericRssi,
        ),
        SizedBox(
          width: 20,
        ),
        Container(
            child: Text(
          widget.periphericName,
          style: TextStyle(color: Color(0xFF7caa9a), fontSize: 20),
        ))
      ]),
    );
  }
}

class ScanReturn extends StatefulWidget {
  const ScanReturn({Key? key}) : super(key: key);

  @override
  State<ScanReturn> createState() => _ScanReturnState();
}

class _ScanReturnState extends State<ScanReturn> {
  List<String> scanResultsListDeviceName = [];
  List<int> scanResultsListDeviceRssi = [];
  bool isScanning = false;

  FlutterBlue flutterBlue = FlutterBlue.instance;

  Future<void> onRefresh() async {
    await Future.delayed(Duration(milliseconds: 1000));

    setState(() {
      scanPeriphefics();
      Fluttertoast.showToast(
          msg: scanResultsListDeviceName.length.toString() +
              "${scanResultsListDeviceName.length <= 1 ? " périphérique trouvé" : "périphériques trouvés"}",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          backgroundColor: Colors.green,
          textColor: Colors.white,
          fontSize: 16.0);
    });
  }

  void scanPeriphefics() {
    flutterBlue.startScan(timeout: Duration(seconds: 4));

//listen scan results
    var subscription = flutterBlue.scanResults.listen((results) {
      for (ScanResult r in results) {
        setState(() {
          scanResultsListDeviceName.clear();
          scanResultsListDeviceName.add(r.device.name);
          scanResultsListDeviceRssi.clear();
          scanResultsListDeviceRssi.add(r.rssi);
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Flexible(
        flex: 7,
        child: LiquidPullToRefresh(
            borderWidth: 0,
            springAnimationDurationInMilliseconds: 100,
            animSpeedFactor: 2.0,
            showChildOpacityTransition: true,
            backgroundColor: Color(0xFF7ab99c),
            color: Color(0xFFc1e9d9),
            onRefresh: onRefresh,
            child: ListView.builder(
                itemCount: scanResultsListDeviceName.length == 0
                    ? 1
                    : scanResultsListDeviceName.length,
                itemBuilder: (context, index) =>
                    scanResultsListDeviceName.length == 0
                        ? Container(
                            margin: EdgeInsets.symmetric(
                                vertical: height(context, 0.2)),
                            child: Text(
                              "Aucun périphériques bluetooth\ntrouvés",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ))
                        : PeriphericItem(
                            periphericName: scanResultsListDeviceName[index],
                            periphericRssi: scanResultsListDeviceRssi[index],
                          ))));
  }
}
