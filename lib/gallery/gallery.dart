import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:neson/gallery/gallery_logic.dart';

class Gallery extends ConsumerStatefulWidget {
  const Gallery({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _GalleryState();
}

class _GalleryState extends ConsumerState<Gallery> {
  @override
  void initState() {
    ref.read(galleryLogic).fetchGallery();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Gallery",
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.w600,
          ),
        ),
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: ListView.builder(
        padding: EdgeInsets.symmetric(horizontal: 40.sp, vertical: 40.sp),
        itemCount: ref.watch(galleryLogic).galleryList.length,
        itemBuilder: (context, index) {
          return Container(
            height: 470.h,
            margin: EdgeInsets.symmetric(vertical: 15.sp),
            padding: EdgeInsets.symmetric(vertical: 20.sp),
            decoration: BoxDecoration(
              color: Color(0xffeeeeee),
              borderRadius: BorderRadius.circular(30.sp),
            ),
            child: Column(
              children: [
                Expanded(
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(30.sp),
                    ),
                    padding: const EdgeInsets.all(8.0),
                    child: CarouselSlider(
                        items: ref
                                .watch(galleryLogic)
                                .galleryList[index]
                                .items
                                ?.map(
                                  (e) => CachedNetworkImage(
                                      fit: BoxFit.fill,
                                      placeholder: (context, url) =>
                                          Image.asset(
                                            "assets/image.png",
                                            color: Colors.black,
                                          ),
                                      errorWidget: (context, url, error) =>
                                          Image.asset(
                                            "assets/image.png",
                                            color: Colors.black,
                                          ),
                                      imageUrl: e.image ?? ""),
                                )
                                .toList() ??
                            [],
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
                10.verticalSpace,
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 30.sp),
                  child: Text(
                    ref.watch(galleryLogic).galleryList[index].title ?? "",
                    style:
                        TextStyle(fontSize: 45.sp, fontWeight: FontWeight.w600),
                    maxLines: 2,
                  ),
                ),
                20.verticalSpace,
              ],
            ),
          );
        },
      ),
    );
  }
}
