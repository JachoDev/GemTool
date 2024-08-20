part of 'ticket_overview_bloc.dart';

enum TicketOverviewStatus { initial, loading, success, failure }

extension TicketOverviewStatusX on TicketOverviewStatus {
  bool get isLoadingOrSuccess => [
    TicketOverviewStatus.success,
  ].contains(this);
}

final class TicketOverviewState extends Equatable {
  const TicketOverviewState({
    this.status = TicketOverviewStatus.initial,
    this.tickets = const [],
    this.filter = TicketViewFilter.all,
    this.lastDeletedTicket,
  });

  final TicketOverviewStatus status;
  final List<Ticket> tickets;
  final TicketViewFilter filter;
  final Ticket? lastDeletedTicket;

  Iterable<Ticket> get filteredTickets => filter.applyAll(tickets);

  TicketOverviewState copyWith({
    TicketOverviewStatus Function()? status,
    List<Ticket> Function()? tickets,
    TicketViewFilter Function()? filter,
    Ticket? Function()? lastDeletedTicket,
  }) {
    return TicketOverviewState(
      status: status != null ? status() : this.status,
      tickets: tickets != null ? tickets() : this.tickets,
      filter: filter != null ? filter() : this.filter,
      lastDeletedTicket: lastDeletedTicket != null ? lastDeletedTicket() :
          this.lastDeletedTicket,
    );
  }

  @override
  List<Object?> get props => [status, tickets, filter, lastDeletedTicket];

}

