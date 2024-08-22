part of 'ticket_generation_bloc.dart';

sealed class TicketGenerationEvent extends Equatable {
  const TicketGenerationEvent();

  @override
  List<Object> get props => [];
}

final class TicketGenerationSendPrompt extends TicketGenerationEvent {
  const TicketGenerationSendPrompt();
}

final class TicketGenerationApiKeyRequest extends TicketGenerationEvent {
  const TicketGenerationApiKeyRequest();
}

final class TicketGenerationSaveTicketAndBytes extends TicketGenerationEvent {
  const TicketGenerationSaveTicketAndBytes();
}
