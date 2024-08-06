import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:ticket_api/ticket_api.dart';
import 'package:gemtool/data/data.dart';
import 'package:tickets_repository/tickets_repository.dart';

part 'ticket_overview_event.dart';
part 'ticket_overview_state.dart';

class TicketOverviewBloc extends Bloc<TicketOverviewEvent, TicketOverviewState> {
  TicketOverviewBloc({
    required TicketsRepository ticketsRepository,
  }) : _ticketsRepository = ticketsRepository,
      super(const TicketOverviewState()) {
    on<TicketOverviewSubscriptionRequested>(_onSubscriptionRequested);
    on<TicketOverviewTicketCompletionToggled>(_onTicketCompletionToggled);
    on<TicketOverviewTicketDeleted>(_onTicketDeleted);
    on<TicketOverviewUndoDeletionRequested>(_onUndoDeletionRequested);
    on<TicketOverviewFilterChanged>(_onFilterChanged);
    on<TicketOverviewToggleAllRequested>(_onToggleAllRequested);
    on<TicketOverviewClearSelectedRequested>(_onClearSelectedRequested);
  }

  final TicketsRepository _ticketsRepository;

  Future<void> _onSubscriptionRequested(
        TicketOverviewSubscriptionRequested event,
        Emitter<TicketOverviewState> emit,
      ) async {
    emit(state.copyWith(status: () => TicketOverviewStatus.loading));

    await emit.forEach<List<Ticket>>(
      _ticketsRepository.getTickets(),
      onData: (tickets) => state.copyWith(
        status: () => TicketOverviewStatus.success,
        tickets: () => tickets,
      ),
      onError: (_, __) => state.copyWith(
        status: () => TicketOverviewStatus.failure,
      )
    );
  }

  Future<void> _onTicketCompletionToggled(
        TicketOverviewTicketCompletionToggled event,
        Emitter<TicketOverviewState> emit,
      ) async {
    final newTicket = event.ticket.copyWith();
    await _ticketsRepository.saveTicket(newTicket);
  }

  Future<void> _onTicketDeleted(
        TicketOverviewTicketDeleted event,
        Emitter<TicketOverviewState> emit,
      ) async {
    emit(state.copyWith(lastDeletedTicket: () => event.ticket));
    await _ticketsRepository.deleteTicket(event.ticket.id);
  }

  Future<void> _onUndoDeletionRequested(
        TicketOverviewUndoDeletionRequested event,
        Emitter<TicketOverviewState> emit,
      ) async {
    assert(
      state.lastDeletedTicket != null,
      'Last deleted ticket can not be null',
    );

    final ticket = state.lastDeletedTicket!;
    emit(state.copyWith(lastDeletedTicket: () => null));
    await _ticketsRepository.saveTicket(ticket);
  }

  void _onFilterChanged(
        TicketOverviewFilterChanged event,
        Emitter<TicketOverviewState> emit,
      ) {
    emit(state.copyWith(filter: () => event.filter));
  }

  Future<void> _onToggleAllRequested(
        TicketOverviewToggleAllRequested event,
        Emitter<TicketOverviewState> emit,
      ) async {
    final areAllCompleted = state.tickets.every((ticket) => ticket.isATicket);
  }

  Future<void> _onClearSelectedRequested(
        TicketOverviewClearSelectedRequested event,
        Emitter<TicketOverviewState> emit,
      ) async {

  }

  Future<void> _onAddTap(
        TicketOverviewAddNewTicket event,
        Emitter<TicketOverviewState> emit,
      ) async {
    //emit(state.copyWith(status: TicketOverviewStatus.loading));
  }
}
