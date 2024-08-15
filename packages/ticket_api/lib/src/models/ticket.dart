import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:meta/meta.dart';
import 'package:ticket_api/ticket_api.dart';
import 'package:uuid/uuid.dart';

part 'ticket.g.dart';

@immutable
@JsonSerializable()
class Ticket extends Equatable {

  Ticket({
    required this.title,
    String? id,
    this.description = '',
    this.name = '',
    this.phone = '',
    this.address = '',
    this.dateTime = '',
    this.subtotal = 0.0,
    this.taxes = 0.0,
    this.total = 0.0,
    this.isSelected = false,
    this.isATicket = true,
  }) : assert(
      id == null || id.isNotEmpty,
      'id must either be null or not empty'
    ),
    id = id ?? const Uuid().v4();

  final String id;

  final String title;

  final String description;

  final String name;

  final String phone;

  final String address;

  final String dateTime;

  final double subtotal;

  final double taxes;

  final double total;

  final bool isSelected;

  final bool  isATicket;

  Ticket copyWith({
    String? id,
    String? title,
    String? description,
    String? name,
    String? phone,
    String? address,
    String? dateTime,
    double? subtotal,
    double? taxes,
    double? total,
    bool? isSelected,
    bool? isATicket,
  }) {
    return Ticket(
      id: id ?? this.id,
      title: title ?? this.title,
      description: description ?? this.description,
      name: name ?? this.name,
      phone: phone ?? this.phone,
      address: address ?? this.address,
      dateTime: dateTime ?? this.dateTime,
      subtotal: subtotal ?? this.subtotal,
      taxes: taxes ?? this.taxes,
      total: total ?? this.total,
      isSelected: isSelected ?? this.isSelected,
      isATicket: isATicket ?? this.isATicket,
    );
  }

  static Ticket fromJson(JsonMap json) => _$TicketFromJson(json);

  JsonMap toJson() => _$TicketToJson(this);

  @override
  List<Object> get props => [id, title, description, name, phone, address,
      dateTime, subtotal, taxes, total, isSelected, isATicket];
}