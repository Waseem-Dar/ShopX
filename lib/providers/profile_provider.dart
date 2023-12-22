import 'dart:async';
import 'dart:developer';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'apis.dart';


String about = "I FeeL HaPpY  😊 ❤";

final aboutProvider = StateProvider<String>((ref) => about);

// C:\Users\Hp\Downloads\flutter_windows_3.7.8-stable\flutter\bin

final userDataProvider = Provider((ref) {
final user = Apis.auth.currentUser!;
  return user;
});

final animationProvider = StateNotifierProvider<AnimationNotifier, String>((ref) {
  final name = ref.watch(userDataProvider);

  return AnimationNotifier(name.displayName.toString());
});

class AnimationNotifier extends StateNotifier<String> {
  final String name;
  int currentIndex = 0;
  bool reverse = false;
  late Timer _timer;

  AnimationNotifier(this.name,) : super("") {
    _timer = Timer.periodic(const Duration(seconds: 1), _updateState);
  }

  void _updateState(Timer timer) {
    if (reverse) {
      if (currentIndex < name.length) {
        state += name[currentIndex];
        currentIndex++;
      } else {
        reverse = !reverse;
      }
    } else if (state.isNotEmpty) {
      state = state.substring(0, state.length - 1);
    } else {
      reverse = !reverse;
      currentIndex = 0;
    }
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }
}

