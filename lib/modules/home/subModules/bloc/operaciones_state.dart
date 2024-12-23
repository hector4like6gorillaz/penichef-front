part of 'operaciones_bloc.dart';

class OperacionesState extends Equatable {
  const OperacionesState({
    this.state = ApiState.initial,
    this.name = "",
    this.picture = "",
  });

  final ApiState state;
  final String name;
  final String picture;
  OperacionesState copyWith({
    ApiState? state,
    String? name,
    String? picture,
  }) {
    return OperacionesState(
      state: state ?? this.state,
      name: name ?? this.name,
      picture: picture ?? this.picture,
    );
  }

  @override
  List<Object?> get props => [
        state,
        name,
        picture,
      ];
}
