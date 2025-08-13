import 'dart:developer';
import 'dart:isolate';
import 'dart:math' as random;
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class IsolatePage extends StatefulWidget {
  const IsolatePage({super.key});

  @override
  State<IsolatePage> createState() => _IsolatePageState();
}

class _IsolatePageState extends State<IsolatePage> {
  List<int> sonlar = [];
  String time = '';

  late final TextEditingController text;

  @override
  void initState() {
    super.initState();
    text = TextEditingController();
  }

  @override
  void dispose() {
    text.dispose();
    super.dispose();
  }

  // Isolate uchun function
  static List<int> generateNumbers(int maxNumber) {
    final randomGen = random.Random();
    final List<int> numbers = List.generate(5000000, (index) {
      final r = randomGen.nextInt(maxNumber);
      final calc = (r * r ~/ 3) ^ (r + 7);
      return calc % maxNumber;
    });

    final List<int> random10 = List.generate(
      10,
      (index) => numbers[randomGen.nextInt(numbers.length)],
    );

    return random10;
  }

  // Isolate orqali random sonlar olish
  Future<void> randomNumberWithIsolate(int maxNumber) async {
    try {
      final Stopwatch stopwatch = Stopwatch()..start();

      final receivePort = ReceivePort();
      await Isolate.spawn((List<dynamic> args) {
        final sendPort = args[0] as SendPort;
        final number = args[1] as int;

        final result = generateNumbers(number);
        sendPort.send(result);
      }, [receivePort.sendPort, maxNumber]);

      final List<int> result = await receivePort.first;

      stopwatch.stop();

      setState(() {
        sonlar = result;
        time = (stopwatch.elapsedMilliseconds / 1000).toStringAsFixed(4);
      });

      log('Generated ${result.length} numbers');
    } catch (e) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('Xato: $e')));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextField(
                controller: text,
                keyboardType: TextInputType.number,
                style: const TextStyle(color: Colors.white),
                decoration: const InputDecoration(
                  hintText: 'Enter max number:',
                  hintStyle: TextStyle(color: Colors.grey),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.white),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.blue),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              Text(
                'Random numbers: ${sonlar.join(', ')}',
                style: const TextStyle(color: Colors.white),
                maxLines: 3,
                overflow: TextOverflow.ellipsis,
              ),
              const SizedBox(height: 20),
              Text(
                'Ketgan vaqt: $time',
                style: const TextStyle(color: Colors.white),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  final number = int.tryParse(text.text);
                  if (number == null || number <= 0) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('Iltimos, musbat son kiriting!'),
                      ),
                    );
                    return;
                  }

                  randomNumberWithIsolate(number);
                },
                child: const Text('Generate Random (Isolate)'),
              ),
              const SizedBox(height: 20),
              Lottie.network(
                'https://lottie.host/ff0abe0f-82a5-40a6-9be7-6503aab9c4e9/rMFPl9l3T4.json',
                errorBuilder: (context, error, stackTrace) => const Text(
                  'Animatsiya yuklanmadi',
                  style: TextStyle(color: Colors.red),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
// import 'dart:developer';
// import 'dart:math' as random;
// import 'package:flutter/material.dart';
// import 'package:flutter/foundation.dart'; // compute uchun
// import 'package:lottie/lottie.dart';

// class IsolatePage extends StatefulWidget {
//   const IsolatePage({super.key});

//   @override
//   State<IsolatePage> createState() => _IsolatePageState();
// }

// class _IsolatePageState extends State<IsolatePage> {
//   List<int> sonlar = [];
//   String time = '';

//   late final TextEditingController text;

//   @override
//   void initState() {
//     super.initState();
//     text = TextEditingController();
//   }

//   @override
//   void dispose() {
//     text.dispose();
//     super.dispose();
//   }

//   // compute uchun function (faqat bitta argument oladi)
//   static List<int> generateNumbers(int maxNumber) {
//     final randomGen = random.Random();
//     final List<int> numbers = List.generate(5000000, (index) {
//       final r = randomGen.nextInt(maxNumber);
//       final calc = (r * r ~/ 3) ^ (r + 7);
//       return calc % maxNumber;
//     });

//     final List<int> random10 = List.generate(
//       10,
//       (index) => numbers[randomGen.nextInt(numbers.length)],
//     );

//     return random10;
//   }

//   // compute bilan ishlash
//   Future<void> randomNumberWithCompute(int maxNumber) async {
//     try {
//       final Stopwatch stopwatch = Stopwatch()..start();

//       // compute ishlatish
//       final List<int> result = await compute(generateNumbers, maxNumber);

//       stopwatch.stop();

//       setState(() {
//         sonlar = result;
//         time = (stopwatch.elapsedMilliseconds / 1000).toStringAsFixed(4);
//       });

//       log('Generated ${result.length} numbers');
//     } catch (e) {
//       ScaffoldMessenger.of(
//         context,
//       ).showSnackBar(SnackBar(content: Text('Xato: $e')));
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.black,
//       body: Center(
//         child: Padding(
//           padding: const EdgeInsets.all(16.0),
//           child: Column(
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: [
//               TextField(
//                 controller: text,
//                 keyboardType: TextInputType.number,
//                 style: const TextStyle(color: Colors.white),
//                 decoration: const InputDecoration(
//                   hintText: 'Enter max number:',
//                   hintStyle: TextStyle(color: Colors.grey),
//                   enabledBorder: OutlineInputBorder(
//                     borderSide: BorderSide(color: Colors.white),
//                   ),
//                   focusedBorder: OutlineInputBorder(
//                     borderSide: BorderSide(color: Colors.blue),
//                   ),
//                 ),
//               ),
//               const SizedBox(height: 20),
//               Text(
//                 'Random numbers: ${sonlar.join(', ')}',
//                 style: const TextStyle(color: Colors.white),
//                 maxLines: 3,
//                 overflow: TextOverflow.ellipsis,
//               ),
//               const SizedBox(height: 20),
//               Text(
//                 'Ketgan vaqt: $time',
//                 style: const TextStyle(color: Colors.white),
//               ),
//               const SizedBox(height: 20),
//               ElevatedButton(
//                 onPressed: () {
//                   final number = int.tryParse(text.text);
//                   if (number == null || number <= 0) {
//                     ScaffoldMessenger.of(context).showSnackBar(
//                       const SnackBar(
//                         content: Text('Iltimos, musbat son kiriting!'),
//                       ),
//                     );
//                     return;
//                   }

//                   randomNumberWithCompute(number);
//                 },
//                 child: const Text('Generate Random (Compute)'),
//               ),
//               const SizedBox(height: 20),
//               Lottie.network(
//                 'https://lottie.host/ff0abe0f-82a5-40a6-9be7-6503aab9c4e9/rMFPl9l3T4.json',
//                 errorBuilder: (context, error, stackTrace) => const Text(
//                   'Animatsiya yuklanmadi',
//                   style: TextStyle(color: Colors.red),
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
