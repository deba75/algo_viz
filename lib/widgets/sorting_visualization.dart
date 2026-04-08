import 'package:flutter/material.dart';

class SortingVisualization extends StatelessWidget {
   final List<int> array;
  final Set<int> highlightedIndices;
  const SortingVisualization({super.key,
   required this.array,
    this.highlightedIndices= const{},
    });

 
  

  @override
  Widget build(BuildContext context){
    return Row(
      children: array.map((value){
        final isHighlighted = highlightedIndices.contains(array.indexOf(value));
        return Expanded(
          child: AnimatedContainer(
            duration: Duration(milliseconds: 150),
            height: value*3.0,

            decoration: BoxDecoration(
              color: isHighlighted? Colors.red : Colors.blue, 
            borderRadius: 
            const BorderRadius.vertical(top: Radius.circular(4)),
            ),
            
          ),

        );
      }).toList(),

      );
  }
}