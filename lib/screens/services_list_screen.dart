import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../bloc/spa_bloc.dart';
import '../bloc/spa_event.dart';
import '../bloc/spa_state.dart';
import '../utils/constants.dart';
import '../widgets/service_card.dart';
import 'service_detail_screen.dart';

class ServicesListScreen extends StatefulWidget {
  const ServicesListScreen({super.key});

  @override
  State<ServicesListScreen> createState() => _ServicesListScreenState();
}

class _ServicesListScreenState extends State<ServicesListScreen> {
  @override
  void initState() {
    super.initState();
    // Fetch the services when screen loads
    context.read<SpaBloc>().add(LoadServicesEvent());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: const Text('Nos Services', style: AppStyles.titleMedium),
        backgroundColor: AppColors.background,
        elevation: 0,
        centerTitle: true,
        iconTheme: const IconThemeData(color: AppColors.textMain),
      ),
      body: BlocBuilder<SpaBloc, SpaState>(
        builder: (context, state) {
          if (state is SpaLoading || state is SpaInitial) {
            return const Center(
              child: CircularProgressIndicator(color: AppColors.primary),
            );
          } else if (state is SpaError) {
            return Center(
              child: Text(
                state.message,
                style: AppStyles.bodyLarge.copyWith(color: Colors.red),
              ),
            );
          } else if (state is SpaLoaded) {
            if (state.services.isEmpty) {
              return const Center(child: Text('Aucun service disponible.'));
            }
            return ListView.builder(
              padding: const EdgeInsets.only(top: 8, bottom: 24),
              itemCount: state.services.length,
              itemBuilder: (context, index) {
                final service = state.services[index];
                return ServiceCard(
                  service: service,
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>
                            ServiceDetailScreen(service: service),
                      ),
                    );
                  },
                );
              },
            );
          }
          return const SizedBox.shrink();
        },
      ),
    );
  }
}
