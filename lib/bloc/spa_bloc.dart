import 'package:flutter_bloc/flutter_bloc.dart';
import '../services/mock_spa_service.dart';
import 'spa_event.dart';
import 'spa_state.dart';

class SpaBloc extends Bloc<SpaEvent, SpaState> {
  final MockSpaService spaService;

  SpaBloc({required this.spaService}) : super(SpaInitial()) {
    on<LoadServicesEvent>(_onLoadServices);
    on<SelectDateEvent>(_onSelectDate);
    on<SelectTimeSlotEvent>(_onSelectTimeSlot);
    on<ConfirmBookingEvent>(_onConfirmBooking);
  }

  Future<void> _onLoadServices(
    LoadServicesEvent event,
    Emitter<SpaState> emit,
  ) async {
    emit(SpaLoading());
    try {
      final services = await spaService.getServices();
      emit(SpaLoaded(services: services));
    } catch (e) {
      emit(SpaError('Échec du chargement des services : $e'));
    }
  }

  void _onSelectDate(SelectDateEvent event, Emitter<SpaState> emit) {
    if (state is SpaLoaded) {
      final currentState = state as SpaLoaded;
      emit(
        currentState.copyWith(
          selectedDate: event.date,
          isBookingConfirmed: false,
        ),
      );
    }
  }

  void _onSelectTimeSlot(SelectTimeSlotEvent event, Emitter<SpaState> emit) {
    if (state is SpaLoaded) {
      final currentState = state as SpaLoaded;
      emit(
        currentState.copyWith(
          selectedTimeSlot: event.timeSlot,
          isBookingConfirmed: false,
        ),
      );
    }
  }

  Future<void> _onConfirmBooking(
    ConfirmBookingEvent event,
    Emitter<SpaState> emit,
  ) async {
    if (state is SpaLoaded) {
      final currentState = state as SpaLoaded;

      if (currentState.selectedDate == null ||
          currentState.selectedTimeSlot == null) {
        emit(
          SpaError(
            'Veuillez d\'abord sélectionner une date et un créneau horaire.',
          ),
        );
        emit(currentState);
        return;
      }

      // Simulate a booking process delay
      emit(SpaLoading());
      await Future.delayed(const Duration(seconds: 1));

      emit(currentState.copyWith(isBookingConfirmed: true));
    }
  }
}
