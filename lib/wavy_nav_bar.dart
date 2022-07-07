import 'package:flutter/material.dart';
import 'package:wave/config.dart';
import 'package:wave/wave.dart';

class WavingNav extends StatelessWidget {
  const WavingNav({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: const BoxDecoration(
        color: Color.fromRGBO(0, 95, 117, 1),
      ),
      child: WaveWidget(
        config: CustomConfig(
          colors: [
            const Color.fromARGB(143, 221, 226, 232),
            const Color.fromARGB(104, 221, 226, 232),
          ],
          durations: [
            9200,
            7100,
          ],
          heightPercentages: [
            0.85,
            0.80,
          ],
        ),
        size: const Size(double.infinity, 250),
        waveAmplitude: 0,
      ),
    );
  }
}