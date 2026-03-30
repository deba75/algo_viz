import 'package:algoviz/algorithms/sorting_algorithm.dart';
import 'package:algoviz/widgets/sorting_visualization.dart';
import 'package:flutter/material.dart';
import 'package:algoviz/models/arrayState.dart';
import 'package:provider/provider.dart';

class VisualizerScreen extends StatefulWidget {
  final String algorithm;

  const VisualizerScreen({super.key, required this.algorithm});

  @override
  State<VisualizerScreen> createState() => _VisualizerScreenState();
}

class _VisualizerScreenState extends State<VisualizerScreen> {
  late Arraystate arrayState;
  bool isSorting = false;
  int speed = 300;

  @override
  void initState() {
    super.initState();
    arrayState = Arraystate()..generateRandomArray(25);
  }

  Future<void> _startSorting() async {
    if (isSorting) return;
    setState(() => isSorting = true);

    final onComplete = () {
      if (mounted) setState(() => isSorting = false);
    };

    try {
      switch (widget.algorithm.toLowerCase()) {
        case 'bubble sort':
          await SortingAlgorithm.bubbleSort(arrayState, speed, onComplete);

          break;

        case 'selection sort':
          await SortingAlgorithm.selectionSort(arrayState, speed, onComplete);
          break;

        default:
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('${widget.algorithm} not implemented yet')),
          );
          onComplete();
      }
    } catch (e) {
      onComplete();
    }
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return ChangeNotifierProvider.value(
      value: arrayState,
      child: Scaffold(
        appBar: AppBar(
          title: Text(widget.algorithm),
          actions: [
            IconButton(
              icon: const Icon(Icons.refresh),
              onPressed: isSorting
                  ? null
                  : () => arrayState.generateRandomArray(25),
              tooltip: 'New Array',
            ),
          ],
        ),

        body: Column(
          children: [
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Consumer<Arraystate>(
                  builder: (context, state, child) => SortingVisualization(
                    array: state.array,
                    highlightedIndices: state.highlighted,
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  // Speed Control
                  Row(
                    children: [
                      const Text('Speed: '),
                      Expanded(
                        child: Slider(
                          value: speed.toDouble(),
                          min: 50,
                          max: 1000,
                          divisions: 19,
                          label: '${speed}ms',
                          onChanged: (value) {
                            setState(() => speed = value.round());
                          },
                        ),
                      ),
                      Text('${speed}ms'),
                    ],
                  ),

                  const SizedBox(height: 16),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      ElevatedButton.icon(
                        onPressed: isSorting ? null : () => arrayState.generateRandomArray(25),
                        icon: const Icon(Icons.shuffle),
                        label: const Text('Randomize'),
                      ),
                      ElevatedButton.icon(
                        onPressed: isSorting ? null : _startSorting,
                        icon: const Icon(Icons.play_arrow),
                        label: const Text('Start'),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.green,
                        ),
                      ),
                      ElevatedButton.icon(
                        onPressed: () => setState(() => isSorting = false),
                        icon: const Icon(Icons.pause),
                        label: const Text('Stop'),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
        ),
      );
  }
}
