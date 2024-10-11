import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'apis.dart';



// final itemsProvider = StateNotifierProvider<ItemsNotifier, List<dynamic>>((ref) {
//   return ItemsNotifier();
// });
//
//
//
// class ItemsNotifier extends StateNotifier<List<dynamic>> {
//   ItemsNotifier() : super([]);
//
//   void addItem(var item) {
//     state = [...state, item];
//   }
//
//   void removeItem(var item) {
//     state = List.from(state)..remove(item);
//   }
// }

final productsStreamProvider =
StreamProvider <QuerySnapshot<Map<String, dynamic>>>((ref) {
  return Apis.getProduct();
});

final favoriteStreamProvider =
StreamProvider<QuerySnapshot<Map<String, dynamic>>>((ref) {
  return Apis.getFavorite();
});
final cartStreamProvider =
StreamProvider<QuerySnapshot<Map<String, dynamic>>>((ref) {
  return Apis.getCart();
});

final CartItemsCountProvider = Provider<int>((ref) {
  final items = ref.watch(cartStreamProvider);
  return items.value!.docs.length;
});

final obscureTextProvider = StateProvider<bool>((ref) => true);



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

