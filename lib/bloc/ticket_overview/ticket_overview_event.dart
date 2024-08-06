part of 'ticket_overview_bloc.dart';

sealed class TicketOverviewEvent extends Equatable {
  const TicketOverviewEvent();

  @override
  List<Object> get props => [];
}

final class TicketOverviewSubscriptionRequested extends TicketOverviewEvent {
  const TicketOverviewSubscriptionRequested();
}

final class TicketOverviewTicketCompletionToggled extends TicketOverviewEvent {
  const TicketOverviewTicketCompletionToggled({
    required this.ticket,
  });

  final Ticket ticket;

  @override
  List<Object> get props => [ticket];
}

final class TicketOverviewTicketDeleted extends TicketOverviewEvent {
  const TicketOverviewTicketDeleted(this.ticket);

  final Ticket ticket;

  @override
  List<Object> get props => [ticket];
}

final class TicketOverviewUndoDeletionRequested extends TicketOverviewEvent {
  const TicketOverviewUndoDeletionRequested();
}

final class TicketOverviewFilterChanged extends TicketOverviewEvent {
  const TicketOverviewFilterChanged(this.filter);

  final TicketViewFilter filter;
}

class TicketOverviewToggleAllRequested extends TicketOverviewEvent {
  const TicketOverviewToggleAllRequested();
}

class TicketOverviewClearSelectedRequested extends TicketOverviewEvent {
  const TicketOverviewClearSelectedRequested();
}

class TicketOverviewAddNewTicket extends TicketOverviewEvent {
  const TicketOverviewAddNewTicket();
}
