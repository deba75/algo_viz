import 'package:algoviz/models/arrayState.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class SortingAlgorithm {
  //bubble sort

  static Future<void> bubbleSort(Arraystate state, int speed, VoidCallback onComplete) async{

final array = state.array;
final n= array.length;
bool sorting = true;

for( int i=0; i<n-1 &&sorting; i++){
  for(int j=0; j<n-i-1 &&sorting; j++){
    state.updateHighlights({j,j+1});
    await Future.delayed(Duration(milliseconds:speed));

    if(array[j]>array[j+1]){
      final temp= array[j];
      array[j]=array[j+1];
      array[j+1]= temp;
      state.updateHighlights(state.highlighted);
    }


  }
}

state.updateHighlights({});
onComplete();


  }

static Future<void> selectionSort(Arraystate state, int speed, VoidCallback onComplete) async {
final array = state.array;
final n= array.length;
bool sorting = true;


for(int i=0; i<n-1 &&sorting; i++){
  int minIdx=i;
  state.updateHighlights({i});
  await Future.delayed(Duration(milliseconds: speed));

  for(int j= i+1; j<n&& sorting; j++){
    state.updateHighlights({i,j});
    await Future.delayed(Duration(milliseconds: speed ));

    if(array[j]<array[minIdx]){
      minIdx= j;
    }
  }


  if(minIdx!= i){
    final temp= array[i];
    array[i]=array[minIdx];
    array[minIdx]=temp;
    state.updateHighlights(state.highlighted);
  }
}
state.updateHighlights({});
onComplete();

}



}