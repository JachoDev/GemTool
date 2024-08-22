part of 'ticket_generation_bloc.dart';

enum TicketGenerationStatus { initial, loading, success, failure }

final class TicketGenerationState extends Equatable {
  const TicketGenerationState({
    this.status = TicketGenerationStatus.initial,
    this.bytes,
    this.apiKey = '',
    this.generatedTicket,
    this.isATicket = false,
  });

  final TicketGenerationStatus status;
  final Uint8List? bytes;
  final String apiKey;
  final Ticket? generatedTicket;
  final bool isATicket;

  TicketGenerationState copyWith({
    TicketGenerationStatus Function()? status,
    Uint8List Function()? bytes,
    String Function()? apiKey,
    Ticket Function()? generatedTicket,
    bool Function()? isATicket,

  }) {
    return TicketGenerationState(
      status: status != null ? status() : this.status,
      bytes: bytes != null ? bytes() : this.bytes,
      apiKey: apiKey != null ? apiKey() : this.apiKey,
      generatedTicket: generatedTicket != null ? generatedTicket() : this.generatedTicket,
      isATicket: isATicket != null ? isATicket() : this.isATicket,
    );
  }

  @override
  List<Object?> get props => [ status, bytes, apiKey, generatedTicket, isATicket ];
}
