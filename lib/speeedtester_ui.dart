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
  double displayProgress = 0.2;
  final double _downloadspeed = 0.0;
  final double _uploadspeed = 0.0;
  double displaySpeed = 0.0;
  bool service = false;
  String? isp;
  String? asp;
  String? asn;

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
              percent: displayProgress,
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
                        _downloadspeed.toStringAsFixed(2),
                        style: const TextStyle(
                            color: Colors.white, fontWeight: FontWeight.bold),
                      ),
                      Text(
                        _uploadspeed.toStringAsFixed(2),
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
                  maximum: 25,
                  ranges: [
                    GaugeRange(
                      color: const Color.fromARGB(255, 100, 181, 248),
                      startValue: 0,
                      endValue: 24,
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
                        displaySpeed.toStringAsFixed(2),
                        style: const TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 25),
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
                  : "IP : ${isp ?? '__'} | Asp: ${asn ?? '__'} | Isp : ${isp ?? '__'}",
              style: const TextStyle(
                  color: Colors.white, fontWeight: FontWeight.bold),
            ),
            const SizedBox(
              height: 10,
            ),
            ElevatedButton(
                style: ElevatedButton.styleFrom(
                    backgroundColor: const Color.fromARGB(255, 100, 181, 248)),
                onPressed: () {},
                child: const Text("Start"))
          ],
        ),
      ),
    );
  }
  testing(){

    
    final speedTest = FlutterInternetSpeedTest();
    speedTest.startTesting(
        useFastApi: true/false //true(default)
        onStarted: () {
          // TODO
        },
        onCompleted: (TestResult download, TestResult upload) {
          // TODO
        },
        onProgress: (double percent, TestResult data) {
          // TODO
        },
        onError: (String errorMessage, String speedTestError) {
          // TODO
        },
        onDefaultServerSelectionInProgress: () {
          // TODO
          //Only when you use useFastApi parameter as true(default)
        },
        onDefaultServerSelectionDone: (Client? client) {
          // TODO
          //Only when you use useFastApi parameter as true(default)
        },
        onDownloadComplete: (TestResult data) {
          // TODO
        },
        onUploadComplete: (TestResult data) {
          // TODO
        },
        onCancel: () {
        // TODO Request cancelled callback
        },
    );
  }
 
}
