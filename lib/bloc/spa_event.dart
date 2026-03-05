import 'package:equatable/equatable.dart';

abstract class SpaEvent extends Equatable {
  const SpaEvent();

  @override
  List<Object?> get props => [];
}

class LoadServicesEvent extends SpaEvent {}

class SelectDateEvent extends SpaEvent {
  final DateTime date;

  const SelectDateEvent(this.date);

  @override
  List<Object?> get props => [date];
}

class SelectTimeSlotEvent extends SpaEvent {
  final String timeSlot;

  const SelectTimeSlotEvent(this.timeSlot);

  @override
  List<Object?> get props => [timeSlot];
}

class ConfirmBookingEvent extends SpaEvent {
  final String serviceId;

  const ConfirmBookingEvent(this.serviceId);

  @override
  List<Object?> get props => [serviceId];
}
