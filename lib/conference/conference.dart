import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:neson/conference/conference_logic.dart';
import 'package:neson/dashboard/dashboard_logic.dart';
import 'package:oktoast/oktoast.dart';
import 'package:url_launcher/url_launcher.dart';

class ConferenceView extends ConsumerStatefulWidget {
  const ConferenceView({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _ConferenceViewState();
}

class _ConferenceViewState extends ConsumerState<ConferenceView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          ref.watch(dashboardLogic).conference?.title ?? "Conference",
          style: const TextStyle(
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
              imageUrl: ref.watch(dashboardLogic).conference?.image ?? "",
            ),
          ),
          40.verticalSpace,
          Row(
            children: [
              Text(
                "Event ",
                style: TextStyle(
                  fontWeight: FontWeight.w700,
                  fontSize: 50.sp,
                ),
              ),
              Text(
                "Details",
                style: TextStyle(
                    fontWeight: FontWeight.w700,
                    fontSize: 50.sp,
                    color: const Color(0xff1A6BE5)),
              ),
            ],
          ),
          10.verticalSpace,
          Text(
            "Time : ${ref.watch(dashboardLogic).conference?.time}",
            style: TextStyle(
              fontWeight: FontWeight.w500,
              fontSize: 45.sp,
            ),
          ),
          Text(
            "Venue : ${ref.watch(dashboardLogic).conference?.venue}",
            style: TextStyle(
              fontWeight: FontWeight.w500,
              fontSize: 45.sp,
            ),
          ),
          Text(
            "Date : ${ref.watch(dashboardLogic).conference?.date}",
            style: TextStyle(
              fontWeight: FontWeight.w500,
              fontSize: 45.sp,
            ),
          ),
          30.verticalSpace,
          InkWell(
            onTap: () async {
              if (!await launchUrl(
                  Uri.parse("https://neson.org/registration-form/"),
                  mode: LaunchMode.platformDefault)) {
                showToast("Error launching url",
                    position: ToastPosition.bottom);
              }
            },
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 60.sp, vertical: 30.sp),
              decoration: BoxDecoration(
                color: const Color(0xff1A6BE5),
                borderRadius: BorderRadius.circular(30.sp),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Icon(
                      Icons.text_snippet_outlined,
                      color: Colors.white.withOpacity(0.5),
                      size: 200.sp,
                    ),
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text(
                        "Havent Registered Yet ??",
                        style: TextStyle(
                          fontWeight: FontWeight.w700,
                          fontSize: 55.sp,
                          color: Colors.white,
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Text(
                            "Register Here",
                            style: TextStyle(
                              fontWeight: FontWeight.w700,
                              fontSize: 45.sp,
                              color: Colors.white,
                            ),
                          ),
                          Icon(
                            Icons.keyboard_arrow_right,
                            color: Colors.white,
                          ),
                        ],
                      ),
                    ],
                  )
                ],
              ),
            ),
          ),
          40.verticalSpace,
          Row(
            children: [
              Text(
                "Program ",
                style: TextStyle(
                  fontWeight: FontWeight.w700,
                  fontSize: 50.sp,
                ),
              ),
              Text(
                "Schedule",
                style: TextStyle(
                    fontWeight: FontWeight.w700,
                    fontSize: 50.sp,
                    color: const Color(0xff1A6BE5)),
              ),
            ],
          ),
          10.verticalSpace,
          ListView.builder(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              itemCount:
                  ref.watch(dashboardLogic).conference?.schedules?.length,
              itemBuilder: (context, index) {
                return Container(
                  margin: EdgeInsets.symmetric(vertical: 15.sp),
                  padding: EdgeInsets.symmetric(
                    horizontal: 40.sp,
                    vertical: 20.sp,
                  ),
                  decoration: BoxDecoration(
                      color: Color(0xffeeeeee),
                      borderRadius: BorderRadius.circular(30.sp)),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        flex: 6,
                        child: Text(
                          ref
                                  .watch(dashboardLogic)
                                  .conference
                                  ?.schedules?[index]
                                  .title ??
                              "",
                          maxLines: 1,
                          overflow: TextOverflow.clip,
                          style: TextStyle(
                            fontSize: 45.sp,
                          ),
                        ),
                      ),
                      Expanded(
                        flex: 4,
                        child: Row(
                          children: [
                            const Icon(
                              Icons.access_time,
                              color: Color(0xff1A6BE5),
                            ),
                            5.horizontalSpace,
                            Text(
                              ref
                                      .watch(dashboardLogic)
                                      .conference
                                      ?.schedules?[index]
                                      .time ??
                                  "",
                              style: TextStyle(
                                fontSize: 45.sp,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                );
              }),
          40.verticalSpace,
          Text(
            "Organizing Committee",
            style: TextStyle(
              fontWeight: FontWeight.w700,
              fontSize: 50.sp,
            ),
          ),
          20.verticalSpace,
          ListView.builder(
            itemCount: ref.watch(dashboardLogic).conference?.members?.length,
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
                                  .watch(dashboardLogic)
                                  .conference
                                  ?.members?[index]
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
                                    .watch(dashboardLogic)
                                    .conference
                                    ?.members?[index]
                                    .name ??
                                "",
                            style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.w600,
                                fontSize: 40.sp),
                          ),
                          Text(
                            ref
                                    .watch(dashboardLogic)
                                    .conference
                                    ?.members?[index]
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
          Text(
            "Abstract",
            style: TextStyle(
              fontWeight: FontWeight.w700,
              fontSize: 50.sp,
            ),
          ),
          20.verticalSpace,
          ListView.builder(
            itemCount: ref.watch(dashboardLogic).conference?.abstracts?.length,
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemBuilder: (context, index) {
              return Container(
                margin: EdgeInsets.symmetric(vertical: 15.sp),
                padding: EdgeInsets.symmetric(
                  horizontal: 40.sp,
                  vertical: 20.sp,
                ),
                decoration: BoxDecoration(
                    color: Color(0xffeeeeee),
                    borderRadius: BorderRadius.circular(30.sp)),
                height: 180.sp,
                child: Row(
                  children: [
                    Expanded(
                      flex: 3,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            ref
                                    .watch(dashboardLogic)
                                    .conference
                                    ?.abstracts?[index]
                                    .title ??
                                "",
                            style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.w600,
                                fontSize: 40.sp),
                          ),
                          Text(
                            ref
                                    .watch(dashboardLogic)
                                    .conference
                                    ?.abstracts?[index]
                                    .user
                                    ?.fullName ??
                                "",
                            style: TextStyle(
                                color: const Color(0xff817D7D),
                                fontWeight: FontWeight.w500,
                                fontSize: 35.sp),
                          ),
                        ],
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        print("downloading");
                        if (ref
                                .watch(dashboardLogic)
                                .conference
                                ?.abstracts?[index]
                                .fileUrl !=
                            null) {
                          ref.watch(conferenceLogic).downloadDocument(
                              ref
                                  .watch(dashboardLogic)
                                  .conference!
                                  .abstracts![index]
                                  .fileUrl!,
                              ref
                                  .watch(dashboardLogic)
                                  .conference!
                                  .abstracts![index]
                                  .fileUrl
                                  .toString()
                                  .split("/")
                                  .last);
                        }
                      },
                      child: Icon(
                        Icons.file_download_outlined,
                        color: Color(0xff1A6BE5),
                      ),
                    )
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
