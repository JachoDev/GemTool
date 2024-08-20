// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ticket.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Ticket _$TicketFromJson(Map<String, dynamic> json) => Ticket(
      title: json['title'] as String? ?? '',
      id: json['id'] as String?,
      description: json['description'] as String? ?? '',
      name: json['name'] as String? ?? '',
      phone: json['phone'] as String? ?? '',
      address: json['address'] as String? ?? '',
      dateTime: json['dateTime'] as String? ?? '',
      subtotal: (json['subtotal'] as num?)?.toDouble() ?? 0.0,
      taxes: (json['taxes'] as num?)?.toDouble() ?? 0.0,
      total: (json['total'] as num?)?.toDouble() ?? 0.0,
      isSelected: json['isSelected'] as bool? ?? false,
      isATicket: json['isATicket'] as bool? ?? true,
      imageBytes: json['imageBytes'] as String? ?? '',
    );

Map<String, dynamic> _$TicketToJson(Ticket instance) => <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'description': instance.description,
      'name': instance.name,
      'phone': instance.phone,
      'address': instance.address,
      'dateTime': instance.dateTime,
      'subtotal': instance.subtotal,
      'taxes': instance.taxes,
      'total': instance.total,
      'isSelected': instance.isSelected,
      'isATicket': instance.isATicket,
      'imageBytes': instance.imageBytes,
    };
