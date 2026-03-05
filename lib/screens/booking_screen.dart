import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import '../bloc/spa_bloc.dart';
import '../bloc/spa_event.dart';
import '../bloc/spa_state.dart';
import '../models/service_model.dart';
import '../utils/constants.dart';

class BookingScreen extends StatefulWidget {
  final ServiceModel service;

  const BookingScreen({super.key, required this.service});

  @override
  State<BookingScreen> createState() => _BookingScreenState();
}

class _BookingScreenState extends State<BookingScreen> {
  final List<String> availableTimeSlots = ['9h', '10h', '11h', '14h', '15h'];

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: const Text('Réservation', style: AppStyles.titleMedium),
        backgroundColor: Colors.transparent,
        elevation: 0,
        iconTheme: const IconThemeData(color: AppColors.textMain),
      ),
      body: BlocConsumer<SpaBloc, SpaState>(
        listener: (context, state) {
          if (state is SpaError) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.message),
                backgroundColor: Colors.red,
                behavior: SnackBarBehavior.floating,
                margin: EdgeInsets.only(
                  bottom: size.height - 200,
                  left: 20.0,
                  right: 20.0,
                ),
              ),
            );
          } else if (state is SpaLoaded && state.isBookingConfirmed) {
            _showConfirmationDialog();
          }
        },
        builder: (context, state) {
          DateTime? selectedDate;
          String? selectedTimeSlot;
          bool isLoading = state is SpaLoading;

          if (state is SpaLoaded) {
            selectedDate = state.selectedDate;
            selectedTimeSlot = state.selectedTimeSlot;
          }

          return Stack(
            children: [
              Container(
                padding: const EdgeInsets.all(24.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(widget.service.name, style: AppStyles.titleLarge),
                    const SizedBox(height: 8),
                    Text(
                      'Durée : ${widget.service.durationMinutes} min',
                      style: AppStyles.bodyMedium,
                    ),
                    const SizedBox(height: 32),

                    // Date Picker Section
                    const Text(
                      'Sélectionnez une date',
                      style: AppStyles.titleMedium,
                    ),
                    const SizedBox(height: 16),
                    InkWell(
                      onTap: () async {
                        final DateTime? picked = await showDatePicker(
                          context: context,
                          initialDate: selectedDate ?? DateTime.now(),
                          firstDate: DateTime.now(),
                          lastDate: DateTime.now().add(
                            const Duration(days: 30),
                          ),
                          builder: (context, child) {
                            return Theme(
                              data: Theme.of(context).copyWith(
                                colorScheme: const ColorScheme.light(
                                  primary: AppColors
                                      .primary, // header background color
                                  onPrimary: Colors.white, // header text color
                                  onSurface:
                                      AppColors.textMain, // body text color
                                ),
                              ),
                              child: child!,
                            );
                          },
                        );
                        if (picked != null && mounted) {
                          context.read<SpaBloc>().add(SelectDateEvent(picked));
                        }
                      },
                      borderRadius: BorderRadius.circular(12),
                      child: Container(
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          color: AppColors.surface,
                          border: Border.all(
                            color: AppColors.primary.withOpacity(0.3),
                          ),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Row(
                          children: [
                            const Icon(
                              Icons.calendar_today,
                              color: AppColors.primary,
                            ),
                            const SizedBox(width: 16),
                            Text(
                              selectedDate != null
                                  ? DateFormat(
                                      'dd MMMM yyyy',
                                      'fr_FR',
                                    ).format(selectedDate)
                                  : 'Choisir la date',
                              style: AppStyles.bodyLarge,
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: 32),

                    // Time Slot Section
                    const Text(
                      'Sélectionnez une heure',
                      style: AppStyles.titleMedium,
                    ),
                    const SizedBox(height: 16),
                    Wrap(
                      spacing: 12,
                      runSpacing: 12,
                      children: availableTimeSlots.map((slot) {
                        final isSelected = slot == selectedTimeSlot;
                        return ChoiceChip(
                          label: Text(slot),
                          selected: isSelected,
                          onSelected: (selected) {
                            if (selected) {
                              context.read<SpaBloc>().add(
                                SelectTimeSlotEvent(slot),
                              );
                            }
                          },
                          selectedColor: AppColors.primary,
                          backgroundColor: AppColors.surface,
                          labelStyle: TextStyle(
                            color: isSelected
                                ? Colors.white
                                : AppColors.textMain,
                            fontWeight: isSelected
                                ? FontWeight.bold
                                : FontWeight.normal,
                          ),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                            side: BorderSide(
                              color: isSelected
                                  ? AppColors.primary
                                  : Colors.grey.shade300,
                            ),
                          ),
                        );
                      }).toList(),
                    ),
                    Spacer(),
                    SizedBox(
                      width: double.infinity,
                      height: 56,
                      child: ElevatedButton(
                        onPressed: () {
                          context.read<SpaBloc>().add(
                            ConfirmBookingEvent(widget.service.id),
                          );
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.primary,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(28),
                          ),
                        ),
                        child: const Text(
                          'Confirmer',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 50),
                  ],
                ),
              ),

              if (isLoading)
                Container(
                  color: Colors.black.withOpacity(0.3),
                  child: const Center(
                    child: CircularProgressIndicator(color: AppColors.primary),
                  ),
                ),
            ],
          );
        },
      ),
    );
  }

  void _showConfirmationDialog() {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          title: const Column(
            children: [
              Icon(Icons.check_circle, color: Colors.green, size: 60),
              SizedBox(height: 16),
              Text('Réservation Confirmée', textAlign: TextAlign.center),
            ],
          ),
          content: Text(
            'Votre rendez-vous pour ${widget.service.name} a été enregistré avec succès. À bientôt !',
            textAlign: TextAlign.center,
          ),
          actions: [
            Center(
              child: ElevatedButton(
                onPressed: () {
                  // Pop Dialog
                  Navigator.of(context).pop();
                  // Pop BookingScreen
                  Navigator.of(context).pop();
                  // Pop ServiceDetailScreen back to Services List
                  Navigator.of(context).pop();
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primary,
                  minimumSize: const Size(120, 40),
                ),
                child: const Text(
                  'Retour à l\'accueil',
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}
