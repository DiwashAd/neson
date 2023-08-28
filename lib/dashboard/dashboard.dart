import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:neson/about_neson/about_neson.dart';
import 'package:neson/dashboard/components/post_detail.dart';
import 'package:neson/dashboard/dashboard_logic.dart';
import 'package:neson/members/members.dart';

class Dashboard extends ConsumerStatefulWidget {
  const Dashboard({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _DashboardState();
}

class _DashboardState extends ConsumerState<Dashboard> {
  @override
  void initState() {
    Future.delayed(Duration(seconds: 0)).then((value) {
      ref.read(dashboardLogic).fetchDashboardImage();
      ref.read(dashboardLogic).fetchPosts();
      ref.read(dashboardLogic).fetchAboutNeson();
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Image.asset("assets/left alignment.png"),
        title: Image.asset("assets/logo.png"),
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: ListView(
        padding: EdgeInsets.symmetric(horizontal: 40.sp),
        children: [
          Container(
            clipBehavior: Clip.antiAlias,
            decoration:
                BoxDecoration(borderRadius: BorderRadius.circular(30.sp)),
            margin: EdgeInsets.symmetric(vertical: 40.sp),
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(30.sp),
              ),
              padding: const EdgeInsets.all(8.0),
              child: CarouselSlider(
                  items: ref
                      .read(dashboardLogic)
                      .sliders
                      .map((e) => InkWell(
                          onTap: () {},
                          child: CachedNetworkImage(
                              height: 450.h,
                              fit: BoxFit.fill,
                              placeholder: (context, url) => Image.asset(
                                    "assets/image.png",
                                    color: Colors.black,
                                  ),
                              errorWidget: (context, url, error) => Image.asset(
                                    "assets/image.png",
                                    color: Colors.black,
                                  ),
                              imageUrl: e.image ?? "")))
                      .toList(),
                  options: CarouselOptions(
                    height: 400.h,
                    viewportFraction: 0.8,
                    initialPage: 0,
                    enableInfiniteScroll: true,
                    reverse: false,
                    autoPlay: false,
                    autoPlayInterval: const Duration(seconds: 3),
                    autoPlayAnimationDuration:
                        const Duration(milliseconds: 800),
                    autoPlayCurve: Curves.fastOutSlowIn,
                    enlargeCenterPage: true,
                    enlargeFactor: 0.3,
                    scrollDirection: Axis.horizontal,
                  )),
            ),
          ),
          20.verticalSpace,
          SizedBox(
            height: 225.h,
            child: Row(
              children: [
                Expanded(
                  child: InkWell(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const AboutNeson()));
                    },
                    child:
                        dashboardGrid("About Neson", "assets/heart beat.png"),
                  ),
                ),
                50.horizontalSpace,
                Expanded(
                  child: InkWell(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const Members()));
                    },
                    child: dashboardGrid("Members", "assets/users.png"),
                  ),
                ),
              ],
            ),
          ),
          40.verticalSpace,
          SizedBox(
            height: 225.h,
            child: Row(
              children: [
                Expanded(
                  child: InkWell(
                    onTap: () {
                      ref.watch(dashboardLogic).changeBody(1);
                    },
                    child: dashboardGrid("Conference", "assets/con.png"),
                  ),
                ),
                50.horizontalSpace,
                Expanded(
                  child: InkWell(
                    onTap: () {
                      ref.watch(dashboardLogic).changeBody(2);
                    },
                    child: dashboardGrid("Gallery", "assets/image.png"),
                  ),
                ),
              ],
            ),
          ),
          40.verticalSpace,
          Row(
            children: [
              Text(
                "News & ",
                style: TextStyle(
                  fontWeight: FontWeight.w700,
                  fontSize: 50.sp,
                ),
              ),
              Text(
                "Updates",
                style: TextStyle(
                    fontWeight: FontWeight.w700,
                    fontSize: 50.sp,
                    color: const Color(0xff1A6BE5)),
              ),
            ],
          ),
          20.verticalSpace,
          ListView.builder(
              physics: const NeverScrollableScrollPhysics(),
              itemCount: ref.watch(dashboardLogic).posts.length,
              shrinkWrap: true,
              itemBuilder: (context, index) {
                return InkWell(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => PostsDetails(
                                image: ref
                                        .watch(dashboardLogic)
                                        .posts[index]
                                        .featuredImage ??
                                    "",
                                content: ref
                                        .watch(dashboardLogic)
                                        .posts[index]
                                        .content ??
                                    "")));
                  },
                  child: Container(
                    margin: EdgeInsets.symmetric(
                        horizontal: 30.sp, vertical: 10.sp),
                    height: 200.sp,
                    child: Row(
                      children: [
                        Expanded(
                          flex: 1,
                          child: Container(
                            clipBehavior: Clip.antiAlias,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(30.sp)),
                            child: Image.network(
                              ref
                                      .watch(dashboardLogic)
                                      .posts[index]
                                      .featuredImage ??
                                  "",
                            ),
                          ),
                        ),
                        50.horizontalSpace,
                        Expanded(
                          flex: 3,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                ref.watch(dashboardLogic).posts[index].title ??
                                    "",
                                style: TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.w600,
                                    fontSize: 40.sp),
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  const Icon(
                                    Icons.access_time,
                                    color: Color(0xff817D7D),
                                  ),
                                  10.verticalSpace,
                                  Text(
                                    ref
                                            .watch(dashboardLogic)
                                            .posts[index]
                                            .createdAt ??
                                        "",
                                    style: TextStyle(
                                        color: const Color(0xff817D7D),
                                        fontWeight: FontWeight.w500,
                                        fontSize: 35.sp),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              })
        ],
      ),
    );
  }
}

dashboardGrid(String label, String icon) {
  return Container(
    padding: EdgeInsets.symmetric(
      horizontal: 50.sp,
      vertical: 20.sp,
    ),
    decoration: BoxDecoration(
      color: const Color(0xffEEEEEE),
      borderRadius: BorderRadius.circular(
        30.sp,
      ),
    ),
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        20.verticalSpace,
        Expanded(
          child: Container(
            height: 50.h,
            decoration: const BoxDecoration(
              color: Color(0xff1A6BE5),
              shape: BoxShape.circle,
            ),
            child: Image.asset(
              icon,
              scale: 0.7,
            ),
          ),
        ),
        20.verticalSpace,
        Text(
          label,
          style: TextStyle(
            color: Colors.black,
            fontSize: 45.sp,
            fontWeight: FontWeight.w600,
          ),
        ),
        5.verticalSpace,
      ],
    ),
  );
}
