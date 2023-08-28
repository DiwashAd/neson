import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:neson/members/members_logic.dart';

class Members extends ConsumerStatefulWidget {
  const Members({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _MembersState();
}

class _MembersState extends ConsumerState<Members> {
  @override
  void initState() {
    ref.read(membersLogic).fetchMembers();
    super.initState();
  }

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
          "Members",
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
        padding: EdgeInsets.symmetric(horizontal: 40.sp, vertical: 10.sp),
        children: [
          Text(
            "Executive Members (${ref.watch(membersLogic).executiveDate})",
            style: TextStyle(
                color: Colors.black,
                fontSize: 50.sp,
                fontWeight: FontWeight.w600),
          ),
          20.verticalSpace,
          ListView.builder(
            itemCount: ref.watch(membersLogic).executiveMembers.length,
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemBuilder: (context, index) {
              return Container(
                margin:
                    EdgeInsets.symmetric(horizontal: 30.sp, vertical: 20.sp),
                height: 180.sp,
                child: Row(
                  children: [
                    Expanded(
                      flex: 1,
                      child: Container(
                        clipBehavior: Clip.antiAlias,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(30.sp)),
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
                          imageUrl: ref
                                  .watch(membersLogic)
                                  .executiveMembers[index]
                                  .image ??
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
                            ref
                                    .watch(membersLogic)
                                    .executiveMembers[index]
                                    .name ??
                                "",
                            style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.w600,
                                fontSize: 40.sp),
                          ),
                          Text(
                            ref
                                    .watch(membersLogic)
                                    .executiveMembers[index]
                                    .position ??
                                "",
                            style: TextStyle(
                                color: const Color(0xff817D7D),
                                fontWeight: FontWeight.w500,
                                fontSize: 35.sp),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
          40.verticalSpace,
          if (ref.watch(membersLogic).normalMembers.isNotEmpty)
            Text(
              "Normal Members (${ref.watch(membersLogic).normalDate})",
              style: TextStyle(
                  color: Colors.black,
                  fontSize: 50.sp,
                  fontWeight: FontWeight.w600),
            ),
          20.verticalSpace,
          if (ref.watch(membersLogic).normalMembers.isNotEmpty)
            ListView.builder(
              shrinkWrap: true,
              itemCount: ref.watch(membersLogic).normalMembers.length,
              physics: const NeverScrollableScrollPhysics(),
              itemBuilder: (context, index) {
                return Container(
                  margin:
                      EdgeInsets.symmetric(horizontal: 30.sp, vertical: 10.sp),
                  height: 180.sp,
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
                                    .watch(membersLogic)
                                    .executiveMembers[index]
                                    .image ??
                                "",
                            fit: BoxFit.cover,
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
                              ref
                                      .watch(membersLogic)
                                      .normalMembers[index]
                                      .name ??
                                  "",
                              style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.w600,
                                  fontSize: 40.sp),
                            ),
                            Text(
                              ref
                                      .watch(membersLogic)
                                      .executiveMembers[index]
                                      .position ??
                                  "",
                              style: TextStyle(
                                  color: const Color(0xff817D7D),
                                  fontWeight: FontWeight.w500,
                                  fontSize: 35.sp),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
        ],
      ),
    );
  }
}
