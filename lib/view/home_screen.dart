import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:news_aapp/view/categories_screen.dart';
import 'package:news_aapp/view/news_detail_screen.dart';
import 'package:news_aapp/view_model/news_view_model.dart';

import '../model/news_channal_headlines_model.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}
enum NewsFilterList{ bbcNews,aryNews, cnn,jeoNews,aljazera,abcNews}

class _HomeScreenState extends State<HomeScreen> {
  NewsFilterList? selectedMenu;
  NewsViewModel newsViewModel=NewsViewModel();
  final format=DateFormat('MMMM dd yyyy');
  String name='bbc-news';
  @override
  Widget build(BuildContext context) {
    final height=MediaQuery.sizeOf(context).height*1;
    final width=MediaQuery.sizeOf(context).width*1;
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: (){
            Navigator.push(context, MaterialPageRoute(builder: (context)=>CategoriesScreen()));
          },
          icon: Image.asset('assets/images/category_icon.png',height: 30,width: 30,),
        ),
        title: Center(child: Text('News',style: GoogleFonts.poppins(fontWeight: FontWeight.w700,fontSize: 24),)),
        actions: [
          PopupMenuButton<NewsFilterList>(
          initialValue: selectedMenu,
          icon: Icon(Icons.more_vert,color: Colors.black,),
          onSelected: (NewsFilterList item){
            if(NewsFilterList.bbcNews.name==item.name){
              name='bbc-news';
            }
            if(NewsFilterList.aryNews.name==item.name){
              name='ary-news';
            }
            if(NewsFilterList.aryNews.name==item.name){
              name='al-jazeera-english';
            }
            if(NewsFilterList.aryNews.name==item.name){
              name='abc-news';
            }
           // newsViewModel.fetchNewsChannelHeadlineApi();
            setState(() {
           selectedMenu=item;
            });
          },
          itemBuilder: (BuildContext context)=><PopupMenuEntry<NewsFilterList>>[
          PopupMenuItem<NewsFilterList>(
              value: NewsFilterList.bbcNews,
              child:Text('bbcNews'),
          ),
            PopupMenuItem<NewsFilterList>(
              value: NewsFilterList.aryNews,
              child:Text('aryNews'),
            ),
            PopupMenuItem<NewsFilterList>(
              value: NewsFilterList.aljazera,
              child:Text('Al-jazera'),
            ),
            PopupMenuItem<NewsFilterList>(
              value: NewsFilterList.aljazera,
              child:Text('AbcNews'),
            )
          ]
          )
        ],
      ),
      body: ListView(
        children: [
          SizedBox(
            height: height*.55,
            width: width,
            child: FutureBuilder<NewsChannelHeadlinesModel>(
              future: newsViewModel.fetchNewsChannelHeadlineApi(name),
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
                scrollDirection: Axis.horizontal,
                  itemCount:snapshot.data!.articles!.length ,
                  itemBuilder: (context,index){
                  DateTime dateTime=DateTime.parse(snapshot.data!.articles![index].publishedAt.toString());
                return InkWell(
                  onTap: (){
                    Navigator.push(context, MaterialPageRoute(builder: (context)=>NewsDetailScreen(
                        newImage:snapshot.data!.articles![index].urlToImage.toString(),
                        title: snapshot.data!.articles![index].title.toString(),
                        dateTime: snapshot.data!.articles![index].publishedAt.toString(),
                        content: snapshot.data!.articles![index].content.toString(),
                        description: snapshot.data!.articles![index].description.toString(),
                    source: snapshot.data!.articles![index].source!.name.toString(),
                    )));
                  },
                  child: SizedBox(
                    child: Stack(
                      alignment: Alignment.center,
                      children: [
                       Container(
                         width:width*0.9,
                         height: height*0.9,
                         padding: EdgeInsets.symmetric(horizontal: height*0.02),
                         child: ClipRRect(
                           borderRadius: BorderRadius.circular(15),
                           child: CachedNetworkImage(
                             imageUrl: snapshot.data!.articles![index].urlToImage.toString(),
                             fit: BoxFit.cover,
                             placeholder: (context, url)=>Container(child: spinKit2,),
                             errorWidget:(context,url,error)=>Icon(Icons.error_outline,color: Colors.red,) ,
                           ),
                         ),
                       ),
                        Positioned(
                          bottom: 20,
                          child: Card(
                            elevation: 5,
                            color: Colors.white,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Container(
                              alignment: Alignment.bottomCenter,
                              padding: EdgeInsets.all(15),
                              height: height*0.22,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Container(
                                    width: width*0.7,
                                    child: Text(
                                      snapshot.data!.articles![index].title.toString(),
                                      style: GoogleFonts.poppins(fontSize: 17,fontWeight: FontWeight.bold),
                                      maxLines: 2,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ),
                                  Spacer(),
                                  Container(
                                    width:width*0.7,
                                    child:Row(
                                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          snapshot.data!.articles![index].source!.name.toString(),
                                          style: GoogleFonts.poppins(fontSize: 12,fontWeight: FontWeight.w600),
                                          maxLines: 2,
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                        Text(
                                          format.format(dateTime),
                                          style: GoogleFonts.poppins(fontSize: 12,fontWeight: FontWeight.w500),
                                          maxLines: 2,
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                      ],
                                    )

                                  )
                                ],
                              ),
                            ),
                          ),
                        )
                      ],

                    ),
                  ),
                );
              });
                }

              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: FutureBuilder<NewsChannelHeadlinesModel>(
              future: newsViewModel.fetchNewsChannelHeadlineApi('crypto-coins-news'),
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
    );
  }
}
const spinKit2=SpinKitFadingCircle(
  color: Colors.amber,
  size: 50,
);