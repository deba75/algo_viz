import 'package:algoviz/models/arrayState.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class SortingAlgorithm {
  //bubble sort

  static Future<void> bubbleSort(
    Arraystate state,
    int speed,
    VoidCallback onComplete,
  ) async {
    final array = state.array;
    final n = array.length;
    bool sorting = true;

    for (int i = 0; i < n - 1 && sorting; i++) {
      for (int j = 0; j < n - i - 1 && sorting; j++) {
        state.updateHighlights({j, j + 1});
        await Future.delayed(Duration(milliseconds: speed));

        if (array[j] > array[j + 1]) {
          final temp = array[j];
          array[j] = array[j + 1];
          array[j + 1] = temp;
          state.updateHighlights(state.highlighted);
        }
      }
    }

    state.updateHighlights({});
    onComplete();
  }

  // selectionSort
  static Future<void> selectionSort(
    Arraystate state,
    int speed,
    VoidCallback onComplete,
  ) async {
    final array = state.array;
    final n = array.length;
    bool sorting = true;

    for (int i = 0; i < n - 1 && sorting; i++) {
      int minIdx = i;
      state.updateHighlights({i});
      await Future.delayed(Duration(milliseconds: speed));

      for (int j = i + 1; j < n && sorting; j++) {
        state.updateHighlights({i, j});
        await Future.delayed(Duration(milliseconds: speed));

        if (array[j] < array[minIdx]) {
          minIdx = j;
        }
      }

      if (minIdx != i) {
        final temp = array[i];
        array[i] = array[minIdx];
        array[minIdx] = temp;
        state.updateHighlights(state.highlighted);
      }
    }
    state.updateHighlights({});
    onComplete();
  }

  // merge sort
  static Future<void> mergeSort(
    Arraystate state,
    int speed,
    VoidCallback onComplete,
  ) async {
    final array = state.array;

    state.startTimer();
    state.resetStats();

    await _mergesortHelper(state, array, 0, array.length-1, speed);

    state.stopTimer();
    state.updateHighlights({});
    onComplete();
  }
  static Future<void> _mergesortHelper(
    Arraystate state,
    List<int> array,
    int left,
    int right,
    int speed,
  ) async{
    if(left>= right) return;

    int mid= left+ (right-left)~/ 2;


    state.updateHighlights({left, mid, right});
    await Future.delayed(Duration(milliseconds: speed));
    await _mergesortHelper(state, array, left, mid, speed);
    await _mergesortHelper(state, array, mid+1, right, speed);
    
    await _merge(state, array, left, mid, right, speed);
     }

     static Future<void> _merge(
      Arraystate state,
      List<int> array,
      int left,
      int mid,
      int right,
      int speed,
     ) async{
      final leftArr = array.sublist( left, mid+1);
      final rightArr = array.sublist(mid+1, right+1);

      int i=0, j=0, k=left;

      for(int x= left; x<= right; x++){
        state.updateHighlights({x});
        await Future.delayed(Duration(milliseconds: speed ~/ 3));
      }

      while(i<leftArr.length && j< rightArr.length){
        state.incrementComparison();

        state.updateHighlights(({left+1, mid+1+j}));
        await Future.delayed(Duration(milliseconds: speed));


        if(leftArr[i]<= rightArr[j]){
          array[k]= leftArr[i];
          i++;
        }
        else{
          array[k]= rightArr[j];
          j++;
          state.incrementSwap();

        }
        state.notifyListeners();
        k++;
      }

      while(j<rightArr.length){
        array[k]= rightArr[j];
        state.notifyListeners();
        j++;
        k++;
        await Future.delayed(Duration(milliseconds: speed~/ 2));
      }
     }




 

  // divide and Conquer(quicksort)

  static Future<void> quickSort(
    Arraystate state,
    int speed,
    int low,
    int high,
    VoidCallback onComplete,
  ) async {
    if (low < high) {
      int pi = await partition(state, low, high, speed);
      await quickSort(state, speed, low, pi - 1, onComplete);
      await quickSort(state, speed, pi + 1, high, onComplete);
    }

    if (low == 0 && high == state.array.length - 1) {
      state.updateHighlights({});
      onComplete();
    }
  }

  static Future<int> partition(
    Arraystate state,
    int low,
    int high,
    int speed,
  ) async {
    final array = state.array;
    int pivot = array[high];
    int i = low - 1;

    for (int j = low; j < high; j++) {
      state.updateHighlights({j, high});
      await Future.delayed(Duration(milliseconds: speed));

      if (array[j] < pivot) {
        i++;
        final temp = array[i];
        array[i] = array[j];
        array[j] = temp;
        state.updateHighlights({i, j});
        await Future.delayed(Duration(milliseconds: speed));
      }
    }

    final temp = array[i + 1];
    array[i + 1] = array[high];
    array[high] = temp;
    state.updateHighlights({i + 1});
    await Future.delayed(Duration(milliseconds: speed));

    return i + 1;
  }

  static Future<void> insertionSort(
    Arraystate state,
    int speed,
    VoidCallback onComplete,
  ) async {
    final array = state.array;
    final n = array.length;
    bool sorting = true;

    state.startTimer();

    for (int i = 0; i < n && sorting; i++) {
      int key = array[i];

      int j = i - 1;

      state.updateHighlights({i});
      await Future.delayed(Duration(milliseconds: speed));

      while (j >= 0 && array[j] > key && sorting) {
        state.incrementComparison();
        state.updateHighlights({j, j + 1});
        await Future.delayed(Duration(milliseconds: speed ~/ 2));

        array[j + 1] = array[j];
        state.incrementSwap();
        state.notifyListeners();

        j--;
      }

      array[j + 1] = key;
      state.updateHighlights({});
      onComplete();
    }
  }
}
