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
    this.address = '',
    this.isATicket = false,
  }) : assert(
      id == null || id.isNotEmpty,
      'id must either be null or not empty'
    ),
    id = id ?? const Uuid().v4();

  final String id;

  final String title;

  final String description;

  final String address;

  final bool  isATicket;

  Ticket copyWith({
    String? id,
    String? title,
    String? description,
    String? address,
    bool? isATicket,
  }) {
    return Ticket(
      id: id ?? this.id,
      title: title ?? this.title,
      description: description ?? this.description,
      address: address ?? this.address,
      isATicket: isATicket ?? this.isATicket,
    );
  }

  static Ticket fromJson(JsonMap json) => _$TicketFromJson(json);

  JsonMap toJson() => _$TicketToJson(this);

  @override
  List<Object> get props => [id, title, description, isATicket];
}