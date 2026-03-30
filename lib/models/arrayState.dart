import 'package:flutter/material.dart';

class Arraystate extends ChangeNotifier {
  List<int> array= [];
  Set<int> highlighted= {};


void generateRandomArray(int size){
  array = List.generate(size, (_)=> (10+ (DateTime.now().millisecond%300)) );

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