import 'package:flutter/scheduler.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:localsend_app/provider/settings_provider.dart';
import 'package:localsend_app/util/native/platform_check.dart';
import 'package:routerino/routerino.dart';

class SleepState extends StateNotifier<bool> {
  SleepState(super.state);
  void setSleep(bool value) => state = value;
}

final globalSleepState = SleepState(false);

final sleepProvider = StateNotifierProvider<SleepState, bool>((ref) {
  return globalSleepState;
});

final animationProvider = Provider<bool>((ref) {
  final sleeping = ref.watch(sleepProvider);
  final enableAnimations = ref.watch(settingsProvider.select((s) => s.enableAnimations));
  final animations = enableAnimations && !sleeping;

  timeDilation = animations ? 1.0 : 0.00001;

  if (animations) {
    setDefaultRouteTransition();
  } else {
    Routerino.transition = RouterinoTransition.noTransition;
  }

  return animations;
});

void setDefaultRouteTransition() {
  if (checkPlatformIsDesktop()) {
    Routerino.transition = RouterinoTransition.cupertino;
  } else {
    Routerino.transition = RouterinoTransition.material;
  }
}
