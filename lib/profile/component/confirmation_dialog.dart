import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ConfirmationDialog extends StatelessWidget {
  final String title;
  final String description;
  const ConfirmationDialog({
    super.key,
    required this.title,
    required this.description,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 300.h,
      width: 800.h,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20.sp),
        border: Border.all(
          color: const Color(0xff6b1d1d),
        ),
      ),
      child: Column(
        children: [
          20.verticalSpace,
          Text(
            title,
            style: TextStyle(
                color: const Color(0xff6b1d1d),
                fontSize: 50.sp,
                fontWeight: FontWeight.w600),
          ),
          const Divider(
            endIndent: 10,
            indent: 10,
            color: Color(0xff6b1d1d),
          ),
          Text(
            description,
            style: TextStyle(fontSize: 40.sp),
          ),
          Spacer(),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              InkWell(
                onTap: () {
                  Navigator.pop(context, true);
                },
                child: Container(
                  height: 80.h,
                  width: 300.w,
                  decoration: BoxDecoration(
                    color: const Color(0xff6b1d1d),
                    borderRadius: BorderRadius.circular(20.sp),
                  ),
                  child: Center(
                    child: Text(
                      "Log Out",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 40.sp,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ),
              ),
              InkWell(
                onTap: () {
                  Navigator.pop(context, false);
                },
                child: Container(
                  height: 80.h,
                  width: 300.w,
                  decoration: BoxDecoration(
                    color: Colors.grey,
                    borderRadius: BorderRadius.circular(20.sp),
                  ),
                  child: Center(
                      child: Text(
                    "Cancel",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 40.sp,
                      fontWeight: FontWeight.w500,
                    ),
                  )),
                ),
              ),
            ],
          ),
          20.verticalSpace,
        ],
      ),
    );
  }
}
