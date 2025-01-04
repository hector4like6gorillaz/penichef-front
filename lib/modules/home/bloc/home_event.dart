part of 'home_bloc.dart';

abstract class HomeEvent extends Equatable { 
  const HomeEvent();

  @override
  List<Object> get props => [];
}

class HomeSumaEvent extends HomeEvent {
  final String op;
  const HomeSumaEvent({required this.op});
}

class GetPokemonByIdEvent extends HomeEvent {
  final int id;
  const GetPokemonByIdEvent({required this.id});
}
