// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'sf_cubit.dart';

class SfState extends Equatable {
  const SfState({this.selectedIndex = 0, this.hasInternetConnection = true});
  final int selectedIndex;
  final bool hasInternetConnection;
  @override
  List<Object> get props => [selectedIndex, hasInternetConnection];

  SfState copyWith({
    int? selectedIndex,
    bool? hasInternetConnection,
  }) {
    return SfState(
      selectedIndex: selectedIndex ?? this.selectedIndex,
      hasInternetConnection:
          hasInternetConnection ?? this.hasInternetConnection,
    );
  }
}
