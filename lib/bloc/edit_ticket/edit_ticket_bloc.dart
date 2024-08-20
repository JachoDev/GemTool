import 'dart:io';
import 'dart:typed_data';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:tickets_repository/tickets_repository.dart';

part 'edit_ticket_event.dart';
part 'edit_ticket_state.dart';

class EditTicketBloc extends Bloc<EditTicketEvent, EditTicketState> {
  EditTicketBloc({
    required TicketsRepository ticketsRepository,
    required Ticket? initialTicket,
  })  : _ticketsRepository = ticketsRepository,
        super(
          EditTicketState(
            initialTicket: initialTicket,
            title: initialTicket?.title ?? '',
            description: initialTicket?.description ?? '',
            name: initialTicket?.name ?? '',
            phone: initialTicket?.phone ?? '',
            address: initialTicket?.address ?? '',
            dateTime: initialTicket?.dateTime ?? '',
            subtotal: initialTicket?.subtotal ?? 0.0,
            taxes: initialTicket?.taxes ?? 0.0,
            total: initialTicket?.total ?? 0.0,
          ),
      ) {
    on<EditTicketTitleChanged>(_onTitleChanged);
    on<EditTicketDescriptionChanged>(_onDescriptionChanged);
    on<EditTicketNameChanged>(_onNameChanged);
    on<EditTicketPhoneChanged>(_onPhoneChanged);
    on<EditTicketAddressChanged>(_onAddressChanged);
    on<EditTicketDateTimeChanged>(_onDateTimeChanged);
    on<EditTicketSubtotalChanged>(_onSubtotalChanged);
    on<EditTicketTaxesChanged>(_onTaxesChanged);
    on<EditTicketTotalChanged>(_onTotalChanged);
    on<EditTicketSubmitted>(_onSubmitted);
  }

  final TicketsRepository _ticketsRepository;

  void _onTitleChanged(
        EditTicketTitleChanged event,
        Emitter<EditTicketState> emit,
      ){
    emit(state.copyWith(title: event.title));
  }

  void _onDescriptionChanged(
        EditTicketDescriptionChanged event,
        Emitter<EditTicketState> emit,
      ){
    emit(state.copyWith(description: event.description));
  }

  void _onNameChanged(
        EditTicketNameChanged event,
        Emitter<EditTicketState> emit,
      ) {
    emit(state.copyWith(name: event.name));
  }

  void _onPhoneChanged(
        EditTicketPhoneChanged event,
        Emitter<EditTicketState> emit,
      ) {
    emit(state.copyWith(phone: event.phone));
  }

  void  _onAddressChanged(
        EditTicketAddressChanged event,
        Emitter<EditTicketState> emit,
      ) {
    emit(state.copyWith(address: event.address));
  }

  void _onDateTimeChanged(
        EditTicketDateTimeChanged event,
        Emitter<EditTicketState> emit,
      ) {
    emit(state.copyWith(dateTime: event.dateTime));
  }

  void _onSubtotalChanged(
        EditTicketSubtotalChanged event,
        Emitter<EditTicketState> emit
      ) {
    emit(state.copyWith(subtotal: event.subtotal));
  }

  void _onTaxesChanged(
        EditTicketTaxesChanged event,
        Emitter<EditTicketState> emit,
      ) {
    emit(state.copyWith(taxes: event.taxes));
  }

  void _onTotalChanged(
       EditTicketTotalChanged event,
      Emitter<EditTicketState> emit,
      ) {
    emit(state.copyWith(total: event.total));
  }

  Future<void> _onSubmitted(
        EditTicketSubmitted event,
        Emitter<EditTicketState> emit,
      ) async {
    emit(state.copyWith(status: EditTicketStatus.loading));
    final ticket = (state.initialTicket ?? Ticket(title: '')).copyWith(
      title: state.title,
      description: state.description,
      name: state.name,
      phone: state.phone,
      address: state.address,
      dateTime: state.dateTime,
      subtotal: state.subtotal,
      taxes: state.taxes,
      total: state.total,
    );

    try {
      await _ticketsRepository.saveTicket(ticket);
      emit(state.copyWith(status: EditTicketStatus.success));

    } catch (e) {
      emit(state.copyWith(status: EditTicketStatus.failure));
    }

  }
}
