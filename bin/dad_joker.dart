import 'package:dad_joker/dad_joker.dart' as dad_joker;
import 'dart:convert'; 
import 'dart:io';
import 'package:http/http.dart' as http;

void main(List<String> arguments) {

  print('Benvingut al generador de bromes JokeAPI:\n');
  
  int? tipus = askForType();

  String? lang = askForLanguage();
  
  
  fetchJoke();
}

int? askForType(){
  do{
    print('Escull l\'estructura de la broma:\n\t1. Simple \n\t2. Dos parts\n\n\tOpcio:');
    String? input = stdin.readLineSync();
  
    if (input != null){
    
      int? number = int.tryParse(input);

      if (numer != null){

        switch(number){

          case 1:
            return 1;
            break;

          case 2:
            return 2;
            break;

          default:
            print('Cap d\'ou escull una opcio valida :/\n');
            break;
        }

      }else{

        switch(input.toLowerCase()){

          case 'simple':
            return 1;
            break;

          case 'dos parts':
            return 2;
            break;

          default:
            print('Cap d\'ou escull una opcio valida :/\n');
            break;
        }

      }

    }else{
      print('Cap d\'ou escull una opcio valida :/\n');
    }

  }while(true);
  return null;
}

String? askForLanguage(){
  do{
    print('Escull l\'idioma de la broma:\n
          \t1. Czech(cs)\n\t2. Deutsch(de)\n\t3. English(en)\n\t4. Espanol(es)\n\t5. francaise(fr)\n\t6. portugues(pt)\n\n\tOpcio:');

    String? input = stdin.readLineSync();

    
  }while(true);
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
