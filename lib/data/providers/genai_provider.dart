
import 'dart:io';

import 'package:google_generative_ai/google_generative_ai.dart';
import 'package:ticket_api/ticket_api.dart';

class GenaiProvider {

    Future<String?> sendPrompt() async {
      const apiKey = '';
      final file = File('assets/images/ticket-zara-1.jpg');
      // The Gemini 1.5 models are versatile and work with both text-only and multimodal prompts
      final model = GenerativeModel(
        model: 'gemini-1.5-flash',
        apiKey: apiKey,
        generationConfig:
        GenerationConfig(
          responseMimeType: 'application/json',
          responseSchema: Schema.array(
            description: '',
            items: Schema.object(
              properties: {
                'title' : Schema.string(description: 'Title of the ticket', nullable: false),
                'description' : Schema.string(description: 'Very short resume of ticket information'),
                'name' : Schema.string(description: 'Name of the business that emit the ticket'),
                'phone' : Schema.string(description: 'Phone number of the business that emit the ticket'),
                'address' : Schema.string(description: 'Address of the business that emit the ticket'),
                'dateTime' : Schema.string(description: 'Date and time of the ticket'),
                'subtotal' : Schema.number(description: 'subtotal of the ticket, amount before taxes', format: 'double'),
                'taxes' : Schema.number(description: 'taxes of the ticket', format: 'double'),
                'total' : Schema.number(description: 'total amount of the ticket, sum of subtotal and taxes', format: 'double'),
              },
            ),
          ),
        ),
      );
      final content = [Content.text('Write a story about a magic backpack in spanish.'), Content.data('image/jpeg', file.readAsBytesSync())];
      final response = await model.generateContent(content, );
      model.generateContentStream(content);
      print(response.candidates[0].text);

      return response.text;
    }
}