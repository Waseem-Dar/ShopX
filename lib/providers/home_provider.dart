import 'dart:convert';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;



Future<List<dynamic>> getProduct()async{
  http.Response response = await http.get(Uri.parse("https://fakestoreapi.com/products")) ;
  var data = jsonDecode(response.body.toString());
  if(response.statusCode == 200){
    return List.from(data);
  }else{
    return [];
  }
}

final futureProductProvider = FutureProvider((ref) => getProduct());




