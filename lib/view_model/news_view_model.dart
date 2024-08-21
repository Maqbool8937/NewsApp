
import 'package:news_aapp/repository/news_repository.dart';

import '../model/categories_news_model.dart';
import '../model/news_channal_headlines_model.dart';

class NewsViewModel{

  final _rep=NewsRepository();
  Future<NewsChannelHeadlinesModel>fetchNewsChannelHeadlineApi(String channelName)async{
    final response=await _rep.fetchNewsChannelHeadlineApi(channelName);
    return response;

  }
  Future<CategoriesNewsModel>fetchCategoriesNewsModelApi(String category)async{
    final response=await _rep.fetchCategoriesNewsModelApi(category);
    return response;
  }
}
