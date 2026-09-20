import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AnimationState extends ChangeNotifier {
  bool enabled = true;

  void setEnabled(bool value) {
    enabled = value;
    notifyListeners();
  }
}

// Глобальная переменная для доступа без ref (нужна для трея)
final globalAnimationState = AnimationState();

final animationProvider = ChangeNotifierProvider<AnimationState>((ref) {
  return globalAnimationState;
});
