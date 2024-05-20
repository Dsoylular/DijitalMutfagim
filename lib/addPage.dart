import 'package:flutter/material.dart';
import 'package:google_generative_ai/google_generative_ai.dart';

import 'appColors.dart';

const apiKey = 'AIzaSyBQig-uH6FnwL-9H8RkxLSuaTCqDs0xnX0';

final TextEditingController _textFieldController = TextEditingController();


// Widget buildBlankPage() {
//   return Container(
//     padding: const EdgeInsets.all(10),
//     child: Center(
//       child: Column(
//         children: [
//           Container(
//             decoration: BoxDecoration(
//               borderRadius: BorderRadius.circular(10),
//               border: Border.all(color: Colors.orange),
//             ),
//             child: Padding(
//               padding: const EdgeInsets.all(8.0),
//               child: RichText(
//                 textAlign: TextAlign.center,
//                 text: const TextSpan(
//                   style: TextStyle(fontSize: 20, color: Colors.black),
//                   children: <TextSpan>[
//                     TextSpan(
//                       text: 'Merhabalar',
//                       style: TextStyle(
//                         color: Colors.orange,
//                         fontWeight: FontWeight.bold,
//                       ),
//                     ),
//                     TextSpan(
//                       text: ', hadi beraber\nbir tarif oluşturalım!',
//                       style: TextStyle(
//                         fontWeight: FontWeight.bold,
//                         fontSize: 20,
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//             ),
//           ),
//           const SizedBox(height: 45),
//           Padding(
//             padding: const EdgeInsets.symmetric(horizontal: 10),
//             child: Row(
//               children: [
//                 Expanded(
//                   child: Container(
//                     decoration: BoxDecoration(
//                       color: cream,
//                       borderRadius: BorderRadius.circular(10),
//                     ),
//                     child: TextField(
//                       controller: _textFieldController,
//                       decoration: InputDecoration(
//                         hintText: 'Malzemeleri giriniz...',
//                         border: OutlineInputBorder(
//                           borderRadius: BorderRadius.circular(10),
//                           borderSide: BorderSide.none,
//                         ),
//                         contentPadding: const EdgeInsets.symmetric(horizontal: 10, vertical: 14),
//                       ),
//                     ),
//                   ),
//                 ),
//                 const SizedBox(width: 10),
//                 ElevatedButton(
//                   onPressed: () {
//                     final text = _textFieldController.text;
//                     print('Text Field Content: $text');
//                     _textFieldController.clear();
//                   },
//                   style: ElevatedButton.styleFrom(
//                     backgroundColor: Colors.orange,
//                     shape: RoundedRectangleBorder(
//                       borderRadius: BorderRadius.circular(10),
//                     ),
//                   ),
//                   child: const Text(
//                     'Ekle',
//                     style: TextStyle(color: Colors.white),
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         ],
//       ),
//     ),
//   );
// }

Future<void> _talkWithGemini(List<String> malzemeler, List<String> limitler) async {
  final model = GenerativeModel(model: 'gemini-pro', apiKey: apiKey);
  String ingredients = _getIngredients(malzemeler);
  String limitations = _getLimitations(limitler);
  final message =
      "Elimde $ingredients var. Bu malzemelerin hepsini kullanmak zorunda değilim. Bana yapabileceğim $limitations bir yemek tarifi.";
  final content = Content.text(message);
  final response = await model.generateContent([content]);
  print("Response from gemini is: ${response.text}");
}

String _getLimitations(List<String> limitations) {
  return limitations.join(', ');
}

String _getIngredients(List<String> malzemeler) {
  return malzemeler.join(', ');
}
