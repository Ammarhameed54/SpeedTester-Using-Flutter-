import 'package:flutter/material.dart';
import 'package:percent_indicator/percent_indicator.dart';

class SpeedTester extends StatefulWidget {
  const SpeedTester({super.key});

  @override
  State<SpeedTester> createState() => _SpeedTesterState();
}

class _SpeedTesterState extends State<SpeedTester> {
  double displayProgress = 0.2;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 10, 30, 73),
      appBar: AppBar(
        title: const Text("SpeedTester"),
        backgroundColor: const Color.fromARGB(255, 10, 35, 73),
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
            const Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Column(
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
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
