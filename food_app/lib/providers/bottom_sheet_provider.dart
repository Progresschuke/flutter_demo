import 'package:flutter_riverpod/flutter_riverpod.dart';

//created to show a bottomsheet for first time users immediately after sign up

class BottomSheetStateNotifier extends StateNotifier<bool> {
  BottomSheetStateNotifier() : super(false);

  void showBottomSheet() {
    state = true;
  }

  void removeBottomSheet() {
    state = false;
  }
}

final bottomSheetProvider =
    StateNotifierProvider<BottomSheetStateNotifier, bool>((ref) {
  return BottomSheetStateNotifier();
});
