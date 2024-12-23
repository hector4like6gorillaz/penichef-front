part of 'operaciones_bloc.dart';

abstract class OperacionesEvent extends Equatable {
  const OperacionesEvent();

  @override
  List<Object> get props => [];
}

class GetApiEvent extends OperacionesEvent {}
