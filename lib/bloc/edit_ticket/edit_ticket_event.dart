part of 'edit_ticket_bloc.dart';

sealed class EditTicketEvent extends Equatable {
  const EditTicketEvent();

  @override
  List<Object> get props => [];
}

final class EditTicketTitleChanged extends EditTicketEvent {
  const EditTicketTitleChanged(this.title);

  final String title;

  @override
  List<Object> get props => [title];
}

final class EditTicketDescriptionChanged extends EditTicketEvent {
  const EditTicketDescriptionChanged(this.description);

  final String description;

  @override
  List<Object> get props => [description];
}

final class EditTicketNameChanged extends EditTicketEvent {
  const EditTicketNameChanged(this.name);

  final String name;

  @override
  List<Object> get props => [name];
}

final class EditTicketPhoneChanged extends EditTicketEvent {
  const EditTicketPhoneChanged(this.phone);

  final String phone;

  @override
  List<Object> get props => [phone];
}

final class EditTicketAddressChanged extends EditTicketEvent {
  const EditTicketAddressChanged(this.address);

  final String address;

  @override
  List<Object> get props => [address];
}

final class EditTicketDateTimeChanged extends EditTicketEvent {
  const EditTicketDateTimeChanged(this.dateTime);

  final String dateTime;

  @override
  List<Object> get props => [dateTime];
}

final class EditTicketSubtotalChanged extends EditTicketEvent {
  const EditTicketSubtotalChanged(this.subtotal);

  final double subtotal;

  @override
  List<Object> get props => [subtotal];
}

final class EditTicketTaxesChanged extends EditTicketEvent {
  const EditTicketTaxesChanged(this.taxes);

  final double taxes;

  @override
  List<Object> get props => [taxes];
}

final class EditTicketTotalChanged extends EditTicketEvent {
  const EditTicketTotalChanged(this.total);

  final double total;

  @override
  List<Object> get props => [total];
}

final class EditTicketSubmitted extends EditTicketEvent {
  const EditTicketSubmitted();
}