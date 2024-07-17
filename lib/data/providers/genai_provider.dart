
import 'package:google_generative_ai/google_generative_ai.dart';

class GenaiProvider {
    Future<String?> sendPrompt() async {

      const apiKey = 'AIzaSyAkt1eUEy0PjhKUhu3LicGK7viureJc2xE';
      // The Gemini 1.5 models are versatile and work with both text-only and multimodal prompts
      final model = GenerativeModel(model: 'gemini-1.5-flash', apiKey: apiKey);
      final content = [Content.text('Write a story about a magic backpack in spanish.')];
      final response = await model.generateContent(content);
      print(response.candidates[0].text);

      return response.text;
    }
}