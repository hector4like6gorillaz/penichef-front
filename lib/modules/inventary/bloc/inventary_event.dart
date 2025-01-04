part of 'inventary_bloc.dart';

abstract class InventaryEvent extends Equatable {
  const InventaryEvent();

  @override
  List<Object> get props => [];
}

class GetInventaryEvent extends InventaryEvent {}

class GetInventaryPageEvent extends InventaryEvent {
  final String ep;
  const GetInventaryPageEvent({required this.ep});
}
 