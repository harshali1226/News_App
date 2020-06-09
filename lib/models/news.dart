import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class IndividualNews {

  final String author;
  final String title;
  final String description;
  final String imageUrl;
  final String content;

  IndividualNews({this.author, this.title, this.description, this.imageUrl,this.content});
}

class News with ChangeNotifier {
  List<IndividualNews> _items = [];
  final String id;

  News({this.id});

  List<IndividualNews> get item {
    return [..._items];
  }

  Future<void> getData(String id) async {
    var url = '';
    // if (id == '1') {
    //   url = 'http://newsapi.org/v2/everything?q=bitcoin&from=2020-05-01&sortBy=publishedAt&apiKey=7706d6029a90418084f72cfca49d5d8e';
    // } else {
      if (id == '2') {
        url = 'http://newsapi.org/v2/top-headlines?country=us&category=business&apiKey=7706d6029a90418084f72cfca49d5d8e';
      } else {
        if (id == '3') {
          url = 'http://newsapi.org/v2/everything?q=apple&from=2020-05-31&to=2020-05-31&sortBy=popularity&apiKey=7706d6029a90418084f72cfca49d5d8e';
        } else {
          if (id == '4') {
            url = 'http://newsapi.org/v2/top-headlines?sources=techcrunch&apiKey=7706d6029a90418084f72cfca49d5d8e';
          } else {
            url = 'http://newsapi.org/v2/everything?domains=wsj.com&apiKey=7706d6029a90418084f72cfca49d5d8e';
          }
        }
      }
    // }
    var urltoImage = '';
    var authorName = '';
    var newstitle = '';
    var newsdescription = '';
    var newscontent = '';
    final response = await http.get(url);
    final extractedData = json.decode(response.body) as Map<String, dynamic>;
    final List<IndividualNews> loadedItems = [];
    if (extractedData['status'] == 'ok') {
      for (int i = 0; i < extractedData['articles'].length; i++) {
        if(extractedData['articles'][i]['urlToImage'] == null){
          urltoImage = 'https://thumbs.dreamstime.com/z/news-world-globe-earth-vector-icon-web-newsletter-app-symbol-news-world-globe-vector-icon-web-newsletter-app-linear-symbol-139070657.jpg';
        }else{
          urltoImage = extractedData['articles'][i]['urlToImage'];
        }
        if(extractedData['articles'][i]['author'] == null){
          authorName = 'Author Name Unavilable';
        }else{
          authorName = extractedData['articles'][i]['author'];
        }
        if(extractedData['articles'][i]['title'] == null){
          newstitle = 'Title Unavilable';
        }else{
          newstitle = extractedData['articles'][i]['title'];
        }
        if(extractedData['articles'][i]['description'] == null){
          newsdescription = 'Description Unavilable';
        }else{
          newsdescription = extractedData['articles'][i]['description'];
        }if(extractedData['articles'][i]['content'] == null){
          newscontent = 'Content Unavilable';
        }else{
          newscontent = extractedData['articles'][i]['content'];
        }
        loadedItems.add(IndividualNews(
          author: authorName,
          title: newstitle,
          description: newsdescription,
          imageUrl: urltoImage,
          content: newscontent
        ));
      }
      _items = loadedItems;
      notifyListeners();
    }
  }
}
