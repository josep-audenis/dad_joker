import 'package:dad_joker/dad_joker.dart' as dad_joker;
import 'dart:convert'; 
import 'package:http/http.dart' as http;

void main(List<String> arguments) {
  fetchJoke();
}

Future<void> fetchJoke() async{
  final url = Uri.parse('https://v2.jokeapi.dev/joke/Any?lang=es');

  try{

    final response = await http.get(url);

    switch(response.statusCode){
      case 200:
        
        final data = jsonDecode(response.body);

        if (data.containsKey('joke')) {
          print('La broma: \n-${data['joke']}');
        } else if (data.containsKey('setup') && data.containsKey('delivery')) {
          print('La broma: \n-${data['setup']} \n-${data['delivery']}');
        } else {
          print('Format rarete: ${data}');
        }

        break;
      case 500 || 523:
        print('Servidor no disponible');
        break;
      case 429:
        print('Tranqui bro, masses bromes per minut. Estas trist? Demana ajuda :)');
        break;
      default:
        print('Nose que passa ${response.statusCode}');
        break;
    }

  }catch (e) {
    print('Un error tonto: $e');
  }
}
