import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';

class PostsDetails extends StatefulWidget {
  final String image;
  final String content;
  const PostsDetails({super.key, required this.image, required this.content});

  @override
  State<PostsDetails> createState() => _PostsDetailsState();
}

class _PostsDetailsState extends State<PostsDetails> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: InkWell(
          onTap: () {
            Navigator.pop(context);
          },
          child: const Icon(
            Icons.arrow_back,
            color: Colors.black,
          ),
        ),
        title: const Text(
          "News & Updates",
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.w600,
          ),
        ),
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: ListView(
        padding: EdgeInsets.symmetric(
          horizontal: 40.sp,
          vertical: 20.sp,
        ),
        children: [
          Container(
            clipBehavior: Clip.antiAlias,
            decoration:
                BoxDecoration(borderRadius: BorderRadius.circular(30.sp)),
            margin: EdgeInsets.symmetric(vertical: 40.sp),
            child: Image.network(
              widget.image,
            ),
          ),
          HtmlWidget(widget.content),
        ],
      ),
    );
  }
}
