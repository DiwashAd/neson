import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:neson/membership/membership_logic.dart';
import 'package:oktoast/oktoast.dart';

class Membership extends ConsumerStatefulWidget {
  const Membership({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _MembershipState();
}

class _MembershipState extends ConsumerState<Membership> {
  @override
  void initState() {
    ref.read(membershipLogic).getMembership();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return OKToast(
      child: Scaffold(
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
            "Membership",
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
              "Details",
              style: TextStyle(
                  color: Colors.black,
                  fontSize: 50.sp,
                  fontWeight: FontWeight.w600),
            ),
            20.verticalSpace,
            ListView.builder(
              itemCount: 1,
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemBuilder: (context, index) {
                return Container(
                  margin:
                      EdgeInsets.symmetric(horizontal: 30.sp, vertical: 20.sp),
                  padding:
                      EdgeInsets.symmetric(horizontal: 50.sp, vertical: 50.sp),
                  decoration: BoxDecoration(
                    color: const Color(0xffEEEEEE),
                    borderRadius: BorderRadius.circular(30.sp),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Membership Type : ${ref.watch(membershipLogic).mem?.membershipType?.title ?? ""} -  ${ref.watch(membershipLogic).mem?.fiscalYear?.title ?? ""}",
                        style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.w600,
                            fontSize: 40.sp),
                      ),
                      20.verticalSpace,
                      Row(
                        children: [
                          Text(
                            "Expires On : ",
                            style: TextStyle(
                                color: const Color(0xffDA5B5B),
                                fontWeight: FontWeight.w500,
                                fontSize: 40.sp),
                          ),
                          Text(
                            ref
                                    .watch(membershipLogic)
                                    .mem
                                    ?.fiscalYear
                                    ?.endDate ??
                                "",
                            style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.w500,
                                fontSize: 40.sp),
                          ),
                        ],
                      ),
                    ],
                  ),
                );
              },
            ),
            40.verticalSpace,
            Container(
              margin: EdgeInsets.symmetric(horizontal: 30.sp, vertical: 20.sp),
              padding: EdgeInsets.symmetric(horizontal: 50.sp, vertical: 50.sp),
              decoration: BoxDecoration(
                color: const Color(0xffEEEEEE),
                borderRadius: BorderRadius.circular(30.sp),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Upload your payment voucher for renewal",
                    style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.w600,
                        fontSize: 40.sp),
                  ),
                  10.verticalSpace,
                  Divider(),
                  10.verticalSpace,
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      InkWell(
                        onTap: () async {
                          FilePickerResult? result =
                              await FilePicker.platform.pickFiles();

                          if (result != null) {
                            File file = File(result.files.single.path!);
                            bool success = await ref
                                .watch(membershipLogic)
                                .uploadImage(file);
                            if (success) {
                              print("Docs uploaded");
                              showToast("Document uploaded successfully",
                                  position: ToastPosition.bottom);
                            }
                          } else {}
                        },
                        child: Container(
                          padding: EdgeInsets.symmetric(
                              horizontal: 50.sp, vertical: 20.sp),
                          decoration: BoxDecoration(
                            color: const Color(0xff1A6BE5),
                            borderRadius: BorderRadius.circular(30.sp),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              30.horizontalSpace,
                              Image.asset("assets/upload.png"),
                              20.horizontalSpace,
                              Text(
                                "Upload a document",
                                style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.w500,
                                    fontSize: 40.sp),
                              ),
                              30.horizontalSpace,
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            40.verticalSpace,
          ],
        ),
      ),
    );
  }
}
