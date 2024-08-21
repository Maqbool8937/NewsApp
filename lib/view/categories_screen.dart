import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:news_aapp/model/categories_news_model.dart';
import 'package:news_aapp/model/news_channal_headlines_model.dart';

import '../view_model/news_view_model.dart';


class CategoriesScreen extends StatefulWidget {
  const CategoriesScreen({super.key});

  @override
  State<CategoriesScreen> createState() => _CategoriesScreenState();
}

class _CategoriesScreenState extends State<CategoriesScreen> {

  List<String>categoriesList=[
    
    'crypto-coins-news',
    'ary-news',
    'entertainment-weekly',
    'financial-post',
    'new-york-magazine',
    'vice-news',
    'al-jazeera-english',
    'abc-news',
    // 'Business',
    //  'Technology'

  ];
  NewsViewModel newsViewModel=NewsViewModel();
  final format=DateFormat('MMMM dd yyyy');
  String categoryname='crypto-coins-news';
  @override
  Widget build(BuildContext context) {
    final height=MediaQuery.sizeOf(context).height*1;
    final width=MediaQuery.sizeOf(context).width*1;
    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          children: [
            SizedBox(
              height: 50,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: categoriesList.length,
                  itemBuilder:(cintext,index){
                  return InkWell(
                    onTap: (){
                      categoryname=categoriesList[index];
                      setState(() {

                      });
                    },
                    child: Padding(
                      padding: const EdgeInsets.only(right: 12),
                      child: Container(
                        decoration: BoxDecoration(
                          color: categoryname==categoriesList[index]?Colors.blue:Colors.grey,
                          borderRadius: BorderRadius.circular(20.0)
                        ),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 12),
                          child: Center(child: Text(categoriesList[index].toString(),style: GoogleFonts.poppins(fontSize: 12,color: Colors.white),)),
                        ),
                      ),
                    ),
                  );
                  } ),
            ),
            Expanded(
              child: FutureBuilder<NewsChannelHeadlinesModel>(
                future: newsViewModel.fetchNewsChannelHeadlineApi(categoryname),
                builder: (BuildContext context, snapshot){
                  if(snapshot.connectionState==ConnectionState.waiting){
                    return Center(
                      child: SpinKitCircle(
                        size: 40,
                        color: Colors.blue,
                      ),
                    );
                  }else{
                    return ListView.builder(
                      shrinkWrap: true,
                        itemCount:snapshot.data!.articles!.length ,
                        itemBuilder: (context,index){
                          DateTime dateTime=DateTime.parse(snapshot.data!.articles![index].publishedAt.toString());
                          return Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              children: [
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(15),
                                  child: CachedNetworkImage(
                                    imageUrl: snapshot.data!.articles![index].urlToImage.toString(),
                                    fit: BoxFit.cover,
                                    height:height*0.18,
                                    width:width*0.3,
                                    placeholder: (context, url)=>Container(child: SpinKitCircle(
                                      size: 40,
                                      color: Colors.blue,
                                    ),),
                                    errorWidget:(context,url,error)=>Icon(Icons.error_outline,color: Colors.red,) ,
                                  ),
                                ),

                                Expanded(
                                  child: Container(
                                      height:height*0.18,
                                      padding: const EdgeInsets.only(left: 15),
                                      child:Column(
                                        children: [
                                          Text(snapshot.data!.articles![index].title.toString(),
                                          style: GoogleFonts.poppins(color: Colors.black,fontSize:15,fontWeight: FontWeight.w700,),
                                            maxLines: 2,
                                            overflow:TextOverflow.ellipsis,
                                          ),
                                          Spacer(),
                                          Row(
                                            children: [
                                              Expanded(
                                                child: Text(snapshot.data!.articles![index].source!.name.toString(),
                                                  style: GoogleFonts.poppins(color: Colors.black,fontSize:11,fontWeight: FontWeight.w500,),
                                                  maxLines: 2,
                                                  overflow:TextOverflow.ellipsis,
                                                ),
                                              ),
                                              Text(format.format(dateTime),
                                                style: GoogleFonts.poppins(color: Colors.black,fontSize:11,fontWeight: FontWeight.w500,),
                                                maxLines: 2,
                                                overflow:TextOverflow.ellipsis,
                                              ),
                                            ],
                                          )
                                        ],
                                      )
                                ),
                                ),
                              ],
                            ),
                          );
                        });
                  }
              
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
