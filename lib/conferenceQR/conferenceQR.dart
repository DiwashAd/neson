import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:neson/conferenceQR/conference_qr_logic.dart';
import 'package:qr_flutter/qr_flutter.dart';

class ConferenceQRView extends ConsumerStatefulWidget {
  const ConferenceQRView({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _ConferenceViewState();
}

class _ConferenceViewState extends ConsumerState<ConferenceQRView> {
  @override
  void initState() {
    ref.read(conferenceQRLogic).getConferenceQR();
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
          "Conference QR Code",
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.w600,
          ),
        ),
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: ref.watch(conferenceQRLogic).isRegistered
          ? ListView(
              padding: EdgeInsets.symmetric(
                horizontal: 40.sp,
                vertical: 20.sp,
              ),
              children: [
                Text(
                  "Please show this QR Code for verification purposes during the conference",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 40.sp,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                40.verticalSpace,
                Center(
                  child: Container(
                    height: 500.h,
                    width: 500.h,
                    padding: EdgeInsets.symmetric(
                        horizontal: 20.sp, vertical: 20.sp),
                    color: Colors.grey.withOpacity(0.2),
                    child: Center(
                      child: Container(
                        color: Colors.white,
                        child: QrImageView(
                            data:
                                jsonEncode(ref.watch(conferenceQRLogic).data)),
                      ),
                    ),
                  ),
                ),
                40.verticalSpace,
                Text(
                  "This is an unique QR Code generated for conference for",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 40.sp,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                30.verticalSpace,
                Text(
                  ref.watch(conferenceQRLogic).data['full_name'],
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 60.sp,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                80.verticalSpace,
                // Row(
                //   mainAxisAlignment: MainAxisAlignment.spaceAround,
                //   children: [
                //     InkWell(
                //       onTap: () {},
                //       child: Container(
                //           height: 100.h,
                //           width: 250.h,
                //           padding: EdgeInsets.symmetric(
                //             horizontal: 30.sp,
                //             vertical: 10.sp,
                //           ),
                //           decoration: BoxDecoration(
                //             color: Color(0xffD9D9D9),
                //             borderRadius: BorderRadius.circular(40.sp),
                //           ),
                //           child: Center(
                //               child: Text(
                //             "Food",
                //             style: TextStyle(
                //               color: Colors.black,
                //               fontWeight: FontWeight.w500,
                //               fontSize: 50.sp,
                //             ),
                //           ))),
                //     ),
                //     InkWell(
                //       onTap: () {},
                //       child: Container(
                //           height: 100.h,
                //           width: 250.h,
                //           padding: EdgeInsets.symmetric(
                //             horizontal: 30.sp,
                //             vertical: 10.sp,
                //           ),
                //           decoration: BoxDecoration(
                //             color: Color(0xffD9D9D9),
                //             borderRadius: BorderRadius.circular(40.sp),
                //           ),
                //           child: Center(
                //               child: Text(
                //             "Entry",
                //             style: TextStyle(
                //               color: Colors.black,
                //               fontWeight: FontWeight.w500,
                //               fontSize: 50.sp,
                //             ),
                //           ))),
                //     ),
                //   ],
                // )
              ],
            )
          : Center(
              child: Text(
              "Member not registered in recent conference.",
              style: TextStyle(
                fontWeight: FontWeight.w700,
                fontSize: 40.sp,
              ),
              textAlign: TextAlign.center,
            )),
    );
  }
}
