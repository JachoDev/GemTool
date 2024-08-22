import 'dart:convert';
import 'dart:typed_data';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:gemtool/data/providers/genai_provider.dart';
import 'package:tickets_repository/tickets_repository.dart';

part 'ticket_generation_event.dart';
part 'ticket_generation_state.dart';

class TicketGenerationBloc extends Bloc<TicketGenerationEvent, TicketGenerationState> {
  TicketGenerationBloc({
    required TicketsRepository ticketRepository,
    required Uint8List bytes,
  }) : _ticketsRepository = ticketRepository,
        super(TicketGenerationState(bytes: bytes)) {
    on<TicketGenerationSendPrompt>(_onSendPrompt);
    on<TicketGenerationApiKeyRequest>(_apiKeyRequest);
  }

  final TicketsRepository _ticketsRepository;

  Future<void> _onSendPrompt(
      TicketGenerationSendPrompt event,
      Emitter<TicketGenerationState> emit,
      ) async {
    final GenaiProvider genaiProvider = GenaiProvider();

    try {
      final ticketGenerated = await genaiProvider.sendPrompt(state.bytes, state.apiKey);
      final  ticketJson = json.decode(ticketGenerated!)[0];
      final Ticket ticket = Ticket.fromJson(ticketJson);
      emit(state.copyWith(
        generatedTicket: () => ticket,
        status: () => TicketGenerationStatus.success,
      ));
    } catch (e) {
      emit(state.copyWith(
        status: () => TicketGenerationStatus.failure,
      ));
    }

  }

  void _onVerifyTicket() {

  }

  Future<void> _apiKeyRequest(
      TicketGenerationApiKeyRequest event,
      Emitter<TicketGenerationState> emit,
      ) async {
    //await _ticketsRepository.saveApiKey('');
    await emit.forEach(
      _ticketsRepository.getApiKey(),
      onData: (apiKeyStorage) => state.copyWith(
        status: () => TicketGenerationStatus.loading,
        apiKey: () => apiKeyStorage.first,
      ),
      onError: (_, __) => state.copyWith(
        status: () => TicketGenerationStatus.failure,
      ),
    );
  }
}
