
import 'dart:io';
import 'dart:typed_data';
import 'package:camera/camera.dart';
import 'package:image/image.dart' as img;
import 'package:flutter/services.dart';
import 'package:google_generative_ai/google_generative_ai.dart';

class GenaiProvider {

    Future<Uint8List> imageToUint8List(String imagePath) async {
      // Load the image from assets
      final ByteData data = await rootBundle.load(imagePath);

      // Decode the image
      final img.Image image = img.decodeImage(data.buffer.asUint8List())!;

      // Encode theimage as a PNG and return the bytes
      return img.encodePng(image);
    }

    Future<String?> sendPrompt(Uint8List? imageBytes, String apiKey) async {
      final assetimg = await imageToUint8List('assets/images/ticket_zara_1.jpg');
      final model = GenerativeModel(
        model: 'gemini-1.5-pro',
        apiKey: apiKey,
        generationConfig:
        GenerationConfig(
          temperature: 0.5,
          responseMimeType: 'application/json',
          responseSchema: Schema.array(
            description: 'Ticket information',
            items: Schema.object(
              properties: {
                'title' : Schema.string(description: 'Name of the business and date of the ticket emitted', nullable: false),
                'description' : Schema.string(description: 'Very short resume of product or services payed in the ticket'),
                'name' : Schema.string(description: 'Name of the business that emit the ticket'),
                'phone' : Schema.string(description: 'Phone number of the business that emit the ticket'),
                'address' : Schema.string(description: 'Address of the business that emit the ticket, ignore line breaks'),
                'dateTime' : Schema.string(description: 'Date and time of the ticket'),
                'subtotal' : Schema.number(description: 'subtotal of the ticket, amount before taxes', format: 'double'),
                'taxes' : Schema.number(description: 'taxes of the ticket, if there is no taxes or iva return 0.0', format: 'double'),
                'total' : Schema.number(description: 'total amount of the ticket, sum of subtotal and taxes', format: 'double'),
                'isATicket' : Schema.boolean(description: 'Identify if its a ticket for true, if not a ticket false')
              },
            ),
          ),
        ),
      );
      final stringBytes = String.fromCharCodes(imageBytes!);
      final content = [
        Content.text('Get the ticket information, if cannot get a field put "", if not a ticket simulates one.'),
        Content.data('image/jpeg', assetimg),
      ];
      final response = await model.generateContent(content);
      final stringResponse = response.text;

      print(response.text);

      return  stringResponse;
    }
}