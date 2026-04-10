import 'package:flutter/material.dart';
import 'dart:math';

class Arraystate extends ChangeNotifier {
  List<int> array= [];
  Set<int> highlighted= {};

int comparison=0;
int swaps=0;
DateTime? startTime;
Duration? elapsedTime;

int _size= 25;

int get size=> _size;
void resetStats(){
  comparison =0;
  swaps=0;
  startTime=null;
  elapsedTime =null;
  highlighted.clear();
  notifyListeners();

}

void generateRandomArray([int? newSize]){
  if(newSize != null) _size= newSize.clamp(10,100);
  final random= Random();
  array = List.generate(_size, (_)=>
   50+ random.nextInt(250));

   resetStats();
}


void generatePreset(String type){
  final n = _size;
  switch(type){
    case 'nearly_sorted':
    array= List.generate(n,(i)=> i*3+(i%5));
    break;
    case 'reverse':
    array= List.generate(n,(i)=> n-i);
    break;

    case 'sorted':
    array = List.generate(n, (i)=>i*3);
    break;

    default:
    generateRandomArray();

    return;
  }
  resetStats();
}

void updateHighlights(Set<int> indices){
  highlighted= indices;
  notifyListeners();

}

void incrementComparison(){
  comparison++;

  notifyListeners();
}

void incrementSwap(){
  swaps++;
  notifyListeners();

}

void startTimer(){
  startTime = DateTime.now();
  elapsedTime= null;
}

void stopTimer(){
  if(startTime !=null){
    elapsedTime = DateTime.now().difference(startTime!);
  }
}
 }