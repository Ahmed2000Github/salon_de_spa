import 'package:equatable/equatable.dart';
import '../models/service_model.dart';

abstract class SpaState extends Equatable {
  const SpaState();

  @override
  List<Object?> get props => [];
}

class SpaInitial extends SpaState {}

class SpaLoading extends SpaState {}

class SpaLoaded extends SpaState {
  final List<ServiceModel> services;
  final DateTime? selectedDate;
  final String? selectedTimeSlot;
  final bool isBookingConfirmed;

  const SpaLoaded({
    required this.services,
    this.selectedDate,
    this.selectedTimeSlot,
    this.isBookingConfirmed = false,
  });

  SpaLoaded copyWith({
    List<ServiceModel>? services,
    DateTime? selectedDate,
    String? selectedTimeSlot,
    bool? isBookingConfirmed,
  }) {
    return SpaLoaded(
      services: services ?? this.services,
      selectedDate: selectedDate ?? this.selectedDate,
      selectedTimeSlot: selectedTimeSlot ?? this.selectedTimeSlot,
      isBookingConfirmed: isBookingConfirmed ?? this.isBookingConfirmed,
    );
  }

  @override
  List<Object?> get props => [
    services,
    selectedDate,
    selectedTimeSlot,
    isBookingConfirmed,
  ];
}

class SpaError extends SpaState {
  final String message;

  const SpaError(this.message);

  @override
  List<Object?> get props => [message];
}
