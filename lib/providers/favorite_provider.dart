import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';


final favoriteItemsProvider = StateNotifierProvider<ItemsNotifier, List<dynamic>>((ref) {
  return ItemsNotifier();
});

class ItemsNotifier extends StateNotifier<List<dynamic>> {
  ItemsNotifier() : super([]);

  void addItem(var item) {
    state = [...state, item];
  }

  void removeItem(var item) {
    state = List.from(state)..remove(item);
  }
}








