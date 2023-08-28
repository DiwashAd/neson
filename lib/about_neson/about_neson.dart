import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
import 'package:neson/about_neson/about_neson_logic.dart';

class AboutNeson extends ConsumerStatefulWidget {
  const AboutNeson({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _AboutNesonState();
}

class _AboutNesonState extends ConsumerState<AboutNeson> {
  @override
  void initState() {
    ref.read(aboutLogic).fetchAboutNeson();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // leading: InkWell(
        //   onTap: () {
        //     Navigator.pop(context);
        //   },
        //   child: const Icon(
        //     Icons.arrow_back,
        //     color: Colors.black,
        //   ),
        // ),
        title: Image.asset("assets/logo.png"),
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
            height: 450.h,
            clipBehavior: Clip.antiAlias,
            decoration:
                BoxDecoration(borderRadius: BorderRadius.circular(30.sp)),
            margin: EdgeInsets.symmetric(vertical: 40.sp),
            child: CachedNetworkImage(
              fit: BoxFit.fill,
              placeholder: (context, url) => Image.asset(
                "assets/image.png",
                color: Colors.black,
              ),
              errorWidget: (context, url, error) => Image.asset(
                "assets/image.png",
                color: Colors.black,
              ),
              imageUrl: ref.watch(aboutLogic).aboutNeson?.featuredImage ?? "",
            ),
          ),
          HtmlWidget(
            ref.watch(aboutLogic).aboutNeson?.content ?? "",
          ),
        ],
      ),
    );
  }
}
