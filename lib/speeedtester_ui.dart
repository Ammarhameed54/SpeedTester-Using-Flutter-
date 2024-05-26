import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'package:syncfusion_flutter_gauges/gauges.dart';
import 'package:flutter_internet_speed_test/flutter_internet_speed_test.dart';

class SpeedTester extends StatefulWidget {
  const SpeedTester({super.key});

  @override
  State<SpeedTester> createState() => _SpeedTesterState();
}

class _SpeedTesterState extends State<SpeedTester> {
  double displayProgress = 0.0;
  double _downloadspeed = 0.0;
  double _uploadspeed = 0.0;
  double displaySpeed = 0.0;
  bool service = false;
  bool testingStarted = false;
  String? ip;
  String? isp;
  String? asn;
  String unitText = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 10, 30, 73),
      appBar: AppBar(
        title: const Text(
          "SpeedTester",
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: const Color.fromARGB(255, 10, 30, 73),
        elevation: 0,
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.only(top: 10),
        child: Column(
          children: [
            const Text(
              "Progress",
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 22,
                  fontWeight: FontWeight.bold),
            ),
            const SizedBox(
              height: 10,
            ),
            LinearPercentIndicator(
              percent: displayProgress / 100.0,
              progressColor: Colors.greenAccent,
              lineHeight: 20,
              center: Text(
                "${displayProgress.toStringAsFixed(1)}%",
                style: const TextStyle(fontSize: 15),
              ),
              barRadius: const Radius.circular(10),
            ),
            const SizedBox(height: 10),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Downloading Speed",
                        style: TextStyle(
                            color: Colors.white, fontWeight: FontWeight.bold),
                      ),
                      Text(
                        "Uploading Speed",
                        style: TextStyle(
                            color: Colors.white, fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        _downloadspeed.toStringAsFixed(2) + unitText,
                        style: const TextStyle(
                            color: Colors.white, fontWeight: FontWeight.bold),
                      ),
                      Text(
                        _uploadspeed.toStringAsFixed(2) + unitText,
                        style: const TextStyle(
                            color: Colors.white, fontWeight: FontWeight.bold),
                      ),
                    ],
                  )
                ],
              ),
            ),
            const SizedBox(
              height: 30,
            ),
            SfRadialGauge(
              axes: [
                RadialAxis(
                  radiusFactor: 0.90,
                  minorTicksPerInterval: 1,
                  tickOffset: 3,
                  useRangeColorForAxis: true,
                  showLastLabel: true,
                  axisLabelStyle: const GaugeTextStyle(color: Colors.white),
                  interval: 4,
                  minimum: 0,
                  maximum: 50,
                  ranges: [
                    GaugeRange(
                      color: const Color.fromARGB(255, 100, 181, 248),
                      startValue: 0,
                      endValue: 50,
                      startWidth: 10,
                      endWidth: 15,
                    ),
                  ],
                  pointers: [
                    NeedlePointer(
                      value: displaySpeed,
                      needleColor: Colors.white,
                      enableAnimation: true,
                      knobStyle: const KnobStyle(color: Colors.black),
                    )
                  ],
                  annotations: [
                    GaugeAnnotation(
                      widget: Text(
                        displaySpeed.toStringAsFixed(2) + unitText,
                        style: const TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 20),
                      ),
                      angle: 90,
                      positionFactor: 0.7,
                    )
                  ],
                )
              ],
            ),
            const SizedBox(
              height: 10,
            ),
            Text(
              service
                  ? "Selecting Server.... "
                  : "IP : ${ip ?? '__'} | Asp: ${asn ?? '__'} | Isp : ${isp ?? '__'}",
              style: const TextStyle(
                  color: Colors.white, fontWeight: FontWeight.bold),
            ),
            const SizedBox(
              height: 10,
            ),
            ElevatedButton(
                style: ElevatedButton.styleFrom(
                    backgroundColor: const Color.fromARGB(255, 100, 181, 248)),
                onPressed: () {
                  testing();
                },
                child: const Text("Start"))
          ],
        ),
      ),
    );
  }

  testing() {
    final speedTest = FlutterInternetSpeedTest();
    speedTest.startTesting(
      onStarted: () {
        setState(() {
          testingStarted = true;
        });
      },
      onCompleted: (TestResult download, TestResult upload) {
        setState(() {
          unitText = download.unit == SpeedUnit.kbps ? 'Kb/s' : 'Mb/s';
          _downloadspeed = download.transferRate;
          displayProgress = 100.0;
          displaySpeed = _downloadspeed;
        });
        setState(() {
          unitText = download.unit == SpeedUnit.kbps ? 'Kb/s' : 'Mb/s';
          _uploadspeed = upload.transferRate;
          displayProgress = 100.0;
          displaySpeed = _uploadspeed;
          testingStarted = false;
        });
      },
      onProgress: (double percent, TestResult data) {
        setState(() {
          unitText = data.unit == SpeedUnit.kbps ? 'Kb/s' : 'Mb/s';
          if (data.type == TestType.download) {
            _downloadspeed = data.transferRate;
            displaySpeed = _downloadspeed;
            displayProgress = percent;
          } else {
            _uploadspeed = data.transferRate;
            displaySpeed = _uploadspeed;
            displayProgress = percent;
          }
        });
      },
      onError: (String errorMessage, String speedTestError) {
        if (kDebugMode) {
          print("error : $errorMessage$speedTestError");
        }
      },
      onDefaultServerSelectionInProgress: () {
        setState(() {
          service = true;
        });
      },
      onDefaultServerSelectionDone: (Client? client) {
        setState(() {
          service = false;
          ip = client!.ip;
          asn = client.asn;
          isp = client.isp;
        });
      },
      onDownloadComplete: (TestResult data) {
        setState(() {
          unitText = data.unit == SpeedUnit.kbps ? 'Kb/s' : 'Mb/s';
          _downloadspeed = data.transferRate;
          displaySpeed = _downloadspeed;
        });
      },
      onUploadComplete: (TestResult data) {
        setState(() {
          unitText = data.unit == SpeedUnit.kbps ? 'Kb/s' : 'Mb/s';
          _uploadspeed = data.transferRate;
          displaySpeed = _uploadspeed;
        });
      },
      // onCancel: () {

      // },
    );
  }
}
