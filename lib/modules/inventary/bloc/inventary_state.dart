part of 'inventary_bloc.dart';

class InventaryState extends Equatable {
  const InventaryState({
    this.state = ApiState.initial,
    this.inventaryData,
  });
  final ApiState state;
  final InventaryData? inventaryData;

  InventaryState copyWith({
    ApiState? state,
    InventaryData? inventaryData,
  }) {
    return InventaryState(
      state: state ?? this.state,
      inventaryData: inventaryData ?? this.inventaryData,
    );
  }

  @override
  List<Object?> get props => [
        state,
        inventaryData,
      ];
}
 