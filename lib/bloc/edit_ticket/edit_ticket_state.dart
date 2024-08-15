part of 'edit_ticket_bloc.dart';

enum EditTicketStatus { initial, loading, success, failure }

extension EditTicketStatusX on EditTicketStatus {
  bool get isLoadingOrSuccess => [
    EditTicketStatus.loading,
    EditTicketStatus.success,
  ].contains(this);
}

final class EditTicketState extends Equatable {
  const EditTicketState({
    this.status = EditTicketStatus.initial,
    this.initialTicket,
    this.title = '',
    this.description = '',
    this.name = '',
    this.phone = '',
    this.address = '',
    this.dateTime = '',
    this.subtotal = 0.0,
    this.taxes = 0.0,
    this.total = 0.0,
  });

  final EditTicketStatus status;
  final Ticket? initialTicket;
  final String title;
  final String description;
  final String name;
  final String phone;
  final String address;
  final String dateTime;
  final double subtotal;
  final double taxes;
  final double total;

  bool get isNewTicket => initialTicket == null;

  EditTicketState copyWith({
    EditTicketStatus? status,
    Ticket? initialTicket,
    String? title,
    String? description,
    String? name,
    String? phone,
    String? address,
    String? dateTime,
    double? subtotal,
    double? taxes,
    double? total,
  }) {
    return EditTicketState(
      status: status ?? this.status,
      initialTicket: initialTicket ?? this.initialTicket,
      title: title ?? this.title,
      description: description ?? this.description,
      name: name ?? this.name,
      phone: phone ?? this.phone,
      address: address ?? this.address,
      dateTime: dateTime ?? this.dateTime,
      subtotal: subtotal ?? this.subtotal,
      taxes: taxes ?? this.subtotal,
      total: total ?? this.total,
    );
  }

  @override
  List<Object?> get props => [
    status,
    initialTicket,
    title,
    description,
    name,
    phone,
    address,
    dateTime,
    subtotal,
    taxes,
    total
  ];
}

