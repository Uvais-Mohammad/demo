import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'sf_state.dart';

class SfCubit extends Cubit<SfState> {
  SfCubit() : super(const SfState());

  void changeSelectedIndex(int index) {
    emit(state.copyWith(selectedIndex: index));
  }

  void reset() {
    emit(const SfState());
  }

  void setHasInterNetConnection({bool status = false}) {
    emit(
      state.copyWith(
        hasInternetConnection: status,
      ),
    );
  }
}
