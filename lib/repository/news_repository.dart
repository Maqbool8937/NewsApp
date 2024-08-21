import 'dart:convert';


import 'package:flutter/foundation.dart';
import 'package:http/http.dart'as http;
import 'package:news_aapp/model/categories_news_model.dart';
import 'package:news_aapp/model/news_channal_headlines_model.dart';
class NewsRepository{
  Future<NewsChannelHeadlinesModel>fetchNewsChannelHeadlineApi(String channelName)async{
    String url='https://newsapi.org/v2/top-headlines?sources=${channelName}&apiKey=fc95902e5cf9437299e882b1486842a6';
    final response=await http.get(Uri.parse(url));
    if(kDebugMode){
      print(response.body);
    }
    if(response.statusCode==200){
      final body=jsonDecode(response.body);
      return NewsChannelHeadlinesModel.fromJson(body);
    }
    throw Exception('Error');
  }
  Future<CategoriesNewsModel>fetchCategoriesNewsModelApi(String category)async{
    String url='  https://newsapi.org/v2/everything?q=${category}&apiKey=fc95902e5cf9437299e882b1486842a6';
   // String url='https://newsapi.org/v2/everything?domains=${category}.com,thenextweb.com&apiKey=fc95902e5cf9437299e882b1486842a6';

    final response=await http.get(Uri.parse(url));
    if(kDebugMode){
      print(response.body);
    }
    if(response.statusCode==200){
      final body=jsonDecode(response.body);
      return CategoriesNewsModel.fromJson(body);
    }
    throw Exception('Error');
  }
}