// import 'dart:convert' as convert;
// import 'package:http/http.dart' as http;

// void main(List<String> arguments) async {
//   // This example uses the Google Books API to search for books about http.
//   // https://developers.google.com/books/docs/overview
//   var url =
//   Uri.parse('http://ergast.com/api/f1/circuits.json?limit=300');
//
//   // Await the http get response, then decode the json-formatted response.
//   var response = await http.get(url);
//   if (response.statusCode == 200) {
//     var jsonResponse =
//     convert.jsonDecode(response.body) as Map<String, dynamic>;
//     var circuitsData = jsonResponse['MRData']['CircuitTable']['Circuits'];
//
//     List<Circuits> circuits = (circuitsData as List).map((item) => Circuits.fromJson(item)).toList();
//     // print('Number of books about http: $itemCount.');
//     circuits.forEach((circuit) {
//       print('Circuit Name: ${circuit.circuitName}');
//     });
//
//     print('Number of circuits: ${circuits.length}');
//   } else {
//     print('Request failed with status: ${response.statusCode}.');
//   }
// }

class Circuits {
  final String? circuitId;
  final String? url;
  final String? circuitName;
  final Location? location;

  Circuits({
    this.circuitId,
    this.url,
    this.circuitName,
    this.location,
  });

  Circuits.fromJson(Map<String, dynamic> json)
      : circuitId = json['circuitId'] as String?,
        url = json['url'] as String?,
        circuitName = json['circuitName'] as String?,
        location = (json['Location'] as Map<String,dynamic>?) != null ? Location.fromJson(json['Location'] as Map<String,dynamic>) : null;

  Map<String, dynamic> toJson() => {
    'circuitId' : circuitId,
    'url' : url,
    'circuitName' : circuitName,
    'Location' : location?.toJson()
  };
}

class Location {
  final String? lat;
  final String? long;
  final String? locality;
  final String? country;

  Location({
    this.lat,
    this.long,
    this.locality,
    this.country,
  });

  Location.fromJson(Map<String, dynamic> json)
      : lat = json['lat'] as String?,
        long = json['long'] as String?,
        locality = json['locality'] as String?,
        country = json['country'] as String?;

  Map<String, dynamic> toJson() => {
    'lat' : lat,
    'long' : long,
    'locality' : locality,
    'country' : country
  };
}