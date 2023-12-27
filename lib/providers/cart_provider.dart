import 'dart:developer';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shopapp/screens/home_screen.dart';



final itemsProvider = StateNotifierProvider<ItemsNotifier, List<dynamic>>((ref) {
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



final CartItemsCountProvider = Provider<int>((ref) {
  final items = ref.watch(cartStreamProvider);
  return items.value!.docs.length;
});



final itemCountsProvider = StateNotifierProvider<ItemCountsNotifier, List<int>>((ref) {
  final cartList = ref.watch(cartStreamProvider);
  return ItemCountsNotifier(List<int>.generate(cartList.value!.docs.length, (index) => 1));
});


class ItemCountsNotifier extends StateNotifier<List<int>> {
  ItemCountsNotifier(List<int> initialCounts) : super(initialCounts);

  void increment(int index) {
    if (index >= 0 && index < state.length) {
      state[index]++;

    }
  }

  void decrement(int index) {
    if (index >= 0 && index < state.length && state[index] > 1) {
      state[index]--;
    }
  }
}

//
// final totalPriceProvider = Provider<double>((ref) {
//   final cartList = ref.watch(itemsProvider);
//   final itemCounts = ref.watch(itemCountsProvider);
//
//   double total = 0;
//
//   for (int i = 0; i < cartList.length; i++) {
//     total += cartList[i]['price'] * itemCounts[i];
//     log("${itemCounts[i]}");
//   }
//   return total;
// });
//
