import 'package:flutter/material.dart';
import 'dart:math';

class Arraystate extends ChangeNotifier {
  List<int> array= [];
  Set<int> highlighted= {};


void generateRandomArray(int size){
  final random= Random();

  array = List.generate(size, (_)=> (10+ random.nextInt(300)) );

  highlighted.clear();
  notifyListeners();
}
   void updateHighlights(Set<int> indices) {
  highlighted = indices;
  notifyListeners(); // MUST be here
}

void clearHighlights(Set<int> indices){
  highlighted = indices;
  notifyListeners();
}
}