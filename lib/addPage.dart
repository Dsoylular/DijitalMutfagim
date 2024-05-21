import 'package:google_generative_ai/google_generative_ai.dart';

const apiKey = 'AIzaSyBQig-uH6FnwL-9H8RkxLSuaTCqDs0xnX0';

Future<String?> talkWithGemini(List<String> malzemeler, List<String> limitler) async {
  final model = GenerativeModel(model: 'gemini-pro', apiKey: apiKey);
  String ingredients = _getIngredients(malzemeler);
  String limitations = _getLimitations(limitler);
  final message =
      "Elimde $ingredients var. Bu malzemelerin hepsini kullanmak zorunda değilim. Bana yapabileceğim $limitations bir yemek tarifi.";
  final content = Content.text(message);
  final response = await model.generateContent([content]);
  // print("Response from gemini is: ${response.text}");
  return response.text;
}

String _getLimitations(List<String> limitations) {
  return limitations.join(', ');
}

String _getIngredients(List<String> malzemeler) {
  return malzemeler.join(', ');
}
