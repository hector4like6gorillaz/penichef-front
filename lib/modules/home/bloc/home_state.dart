part of 'home_bloc.dart';

class HomeState extends Equatable {
  const HomeState({
    this.state = ApiState.initial,
    this.numero = 50,
    this.name = "",
    this.picture = "",
  });

  final ApiState state;
  final int numero;
  final String name;
  final String picture;

  HomeState copyWith({
    ApiState? state,
    int? numero,
    String? name,
    String? picture,
  }) {
    return HomeState(
      state: state ?? this.state,
      numero: numero ?? this.numero,
      name: name ?? this.name,
      picture: picture ?? this.picture,
    );
  }

  @override
  List<Object?> get props => [
        state,
        numero,
        name,
        picture,
      ];
}
