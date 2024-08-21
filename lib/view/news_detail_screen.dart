import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
class NewsDetailScreen extends StatefulWidget {
  String newImage,title,content,description,dateTime,source;
   NewsDetailScreen({super.key,required this.newImage,required this.title,
  required this.dateTime,required this.content,required this.description,required this.source
  });

  @override
  State<NewsDetailScreen> createState() => _NewsDetailScreenState();
}

class _NewsDetailScreenState extends State<NewsDetailScreen> {
  final format=DateFormat('MMMM dd yyyy');

  @override
  Widget build(BuildContext context) {
    DateTime dateTime=DateTime.parse(widget.dateTime);
    final height=MediaQuery.sizeOf(context).height*1;
    final width=MediaQuery.sizeOf(context).width*1;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: Stack(
        children: [
          Container(
            height: height*0.45,
            child: ClipRRect(
             borderRadius: BorderRadius.only(
               topLeft: Radius.circular(10),
               topRight: Radius.circular(40)
             ),
              child: CachedNetworkImage(
                imageUrl: widget.newImage,
                fit: BoxFit.cover,
                placeholder: (context,url)=>Center(child: CircularProgressIndicator(),),
              ),
            ),
          ),
          Container(
            height: height*0.6,
            margin: EdgeInsets.only(top:height* 0.4),
            padding: EdgeInsets.only(top: 20,left: 20,right: 20),
            decoration: BoxDecoration(
              color: Colors.white,
            ),
            child: ListView(
              children: [
                Text(widget.title,style: GoogleFonts.poppins(fontSize: 20,color: Colors.black,fontWeight: FontWeight.w700),),
                SizedBox(height: height*0.02,),
                Row(
                  children: [
                    Expanded(child: Text(widget.source,style: GoogleFonts.poppins(fontSize: 13,color: Colors.black,fontWeight: FontWeight.w700),)),
                    Text(format.format(dateTime),style: GoogleFonts.poppins(fontSize: 12,color: Colors.black,fontWeight: FontWeight.w500),),


                  ],

                ),
                SizedBox(height: height*0.03,),
                Text(widget.description,style: GoogleFonts.poppins(
                  fontSize: 16,color: Colors.black,fontWeight: FontWeight.w600,),overflow: TextOverflow.ellipsis,maxLines: 3,),
              ],
            ),
          )
        ],
      ),
    );
  }
}
