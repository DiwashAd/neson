import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:neson/certificates/certificates_logic.dart';
import 'package:oktoast/oktoast.dart';
import 'package:permission_handler/permission_handler.dart';

class Certificates extends ConsumerStatefulWidget {
  const Certificates({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _MembershipState();
}

class _MembershipState extends ConsumerState<Certificates> {
  @override
  void initState() {
    ref.read(certificates).getCertificates();
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
            "Certificates",
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
              "Personal Documents",
              style: TextStyle(
                  color: Colors.black,
                  fontSize: 50.sp,
                  fontWeight: FontWeight.w600),
            ),
            20.verticalSpace,
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
                    "Citizenship",
                    style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.w600,
                        fontSize: 40.sp),
                  ),
                  10.verticalSpace,
                  const Divider(),
                  10.verticalSpace,
                  ref.watch(certificates).hasCitizenship
                      ? IntrinsicHeight(
                          child: Row(
                            children: [
                              // Flexible(
                              //   child: Text(
                              //     "View Certificate",
                              //     style: TextStyle(
                              //         color: Color(0xff1A6BE5),
                              //         fontWeight: FontWeight.w500,
                              //         fontSize: 35.sp),
                              //   ),
                              // ),
                              // 20.horizontalSpace,
                              // VerticalDivider(),
                              // 20.horizontalSpace,
                              Expanded(
                                child: InkWell(
                                  onTap: () async {
                                    print(!await Permission.storage.isGranted);
                                    if (!await Permission.storage.isGranted) {
                                      Permission.storage.request();
                                    }
                                    if (ref
                                        .watch(certificates)
                                        .drivingLicense
                                        ?.document !=
                                        null) {
                                      bool success = await ref
                                          .watch(certificates)
                                          .downloadDocument(
                                          ref
                                              .watch(certificates)
                                              .drivingLicense
                                              ?.document ??
                                              "",
                                          ref
                                              .watch(certificates)
                                              .drivingLicense
                                              ?.document!
                                              .split("/")
                                              .last ??
                                              "");
                                      if (success) {
                                        showToast(
                                            "Document has been downloaded",
                                            position: ToastPosition.bottom);
                                      } else {
                                        showToast("Download failed",
                                            position: ToastPosition.bottom);
                                      }
                                    }
                                  },
                                  child: Row(
                                    children: [
                                      Icon(
                                        Icons.file_download_outlined,
                                        color: Color(0xff1A6BE5),
                                      ),
                                      20.horizontalSpace,
                                      Text(
                                        "Download Certificate",
                                        style: TextStyle(
                                            color: Color(0xff1A6BE5),
                                            fontWeight: FontWeight.w500,
                                            fontSize: 35.sp),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        )
                      : Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            InkWell(
                              onTap: () async {
                                FilePickerResult? result =
                                    await FilePicker.platform.pickFiles();

                                if (result != null) {
                                  File file = File(result.files.single.path!);
                                  bool success = await ref
                                      .watch(certificates)
                                      .uploadCitizenship(file);
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
                    "Passport",
                    style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.w600,
                        fontSize: 40.sp),
                  ),
                  10.verticalSpace,
                  Divider(),
                  10.verticalSpace,
                  ref.watch(certificates).hasPassport
                      ? IntrinsicHeight(
                          child: Row(
                            children: [
                              // Flexible(
                              //   child: Text(
                              //     "View Certificate",
                              //     style: TextStyle(
                              //         color: Color(0xff1A6BE5),
                              //         fontWeight: FontWeight.w500,
                              //         fontSize: 35.sp),
                              //   ),
                              // ),
                              // 20.horizontalSpace,
                              // VerticalDivider(),
                              // 20.horizontalSpace,
                              Expanded(
                                child: InkWell(
                                  onTap: () async {
                                    print(!await Permission.storage.isGranted);
                                    if (!await Permission.storage.isGranted) {
                                      Permission.storage.request();
                                    }
                                    if (ref
                                            .watch(certificates)
                                            .drivingLicense
                                            ?.document !=
                                        null) {
                                      bool success = await ref
                                          .watch(certificates)
                                          .downloadDocument(
                                              ref
                                                      .watch(certificates)
                                                      .drivingLicense
                                                      ?.document ??
                                                  "",
                                              ref
                                                      .watch(certificates)
                                                      .drivingLicense
                                                      ?.document!
                                                      .split("/")
                                                      .last ??
                                                  "");
                                      if (success) {
                                        showToast(
                                            "Document has been downloaded",
                                            position: ToastPosition.bottom);
                                      } else {
                                        showToast("Download failed",
                                            position: ToastPosition.bottom);
                                      }
                                    }
                                  },
                                  child: Row(
                                    children: [
                                      Icon(
                                        Icons.file_download_outlined,
                                        color: Color(0xff1A6BE5),
                                      ),
                                      20.horizontalSpace,
                                      Text(
                                        "Download Certificate",
                                        style: TextStyle(
                                            color: Color(0xff1A6BE5),
                                            fontWeight: FontWeight.w500,
                                            fontSize: 35.sp),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        )
                      : Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            InkWell(
                              onTap: () async {
                                FilePickerResult? result =
                                    await FilePicker.platform.pickFiles();

                                if (result != null) {
                                  File file = File(result.files.single.path!);
                                  bool success = await ref
                                      .watch(certificates)
                                      .uploadPassport(file);
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
                    "Driving License",
                    style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.w600,
                        fontSize: 40.sp),
                  ),
                  10.verticalSpace,
                  Divider(),
                  10.verticalSpace,
                  ref.watch(certificates).hasDrivingLicense
                      ? IntrinsicHeight(
                          child: Row(
                            children: [
                              // Flexible(
                              //   child: Text(
                              //     "View Certificate",
                              //     style: TextStyle(
                              //         color: Color(0xff1A6BE5),
                              //         fontWeight: FontWeight.w500,
                              //         fontSize: 35.sp),
                              //   ),
                              // ),
                              // 20.horizontalSpace,
                              // VerticalDivider(),
                              // 20.horizontalSpace,
                              Expanded(
                                child: InkWell(
                                  onTap: () async {
                                    print(!await Permission.storage.isGranted);
                                    if (!await Permission.storage.isGranted) {
                                      Permission.storage.request();
                                    }
                                    if (ref
                                            .watch(certificates)
                                            .drivingLicense
                                            ?.document !=
                                        null) {
                                      bool success = await ref
                                          .watch(certificates)
                                          .downloadDocument(
                                              ref
                                                      .watch(certificates)
                                                      .drivingLicense
                                                      ?.document ??
                                                  "",
                                              ref
                                                      .watch(certificates)
                                                      .drivingLicense
                                                      ?.document!
                                                      .split("/")
                                                      .last ??
                                                  "");
                                      if (success) {
                                        showToast(
                                            "Document has been downloaded",
                                            position: ToastPosition.bottom);
                                      } else {
                                        showToast("Download failed",
                                            position: ToastPosition.bottom);
                                      }
                                    }
                                  },
                                  child: Row(
                                    children: [
                                      Icon(
                                        Icons.file_download_outlined,
                                        color: Color(0xff1A6BE5),
                                      ),
                                      20.horizontalSpace,
                                      Text(
                                        "Download Certificate",
                                        style: TextStyle(
                                            color: Color(0xff1A6BE5),
                                            fontWeight: FontWeight.w500,
                                            fontSize: 35.sp),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        )
                      : Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            InkWell(
                              onTap: () async {
                                FilePickerResult? result =
                                    await FilePicker.platform.pickFiles();

                                if (result != null) {
                                  File file = File(result.files.single.path!);
                                  bool success = await ref
                                      .watch(certificates)
                                      .uploadLicense(file);
                                  if (success) {
                                    print("Docs uploaded");
                                    showToast("Document uploaded successfully",
                                        backgroundColor: Colors.grey,
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
