import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:neson/change_password/change_password.dart';
import 'package:neson/conferenceQR/conferenceQR.dart';
import 'package:neson/login/login_view.dart';
import 'package:neson/membership/membership.dart';
import 'package:neson/profile/component/confirmation_dialog.dart';
import 'package:neson/profile/profile_logic.dart';
import 'package:oktoast/oktoast.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Profile extends ConsumerStatefulWidget {
  const Profile({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _ProfileState();
}

class _ProfileState extends ConsumerState<Profile> {
  @override
  void initState() {
    ref.read(profileLogic).setUser();
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: false,
      appBar: AppBar(
        title: const Text(
          "Profile",
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
        children: [
          Center(
            child: Container(
              height: 510.sp,
              decoration: const BoxDecoration(
                color: Color(0xff1A6BE5),
                shape: BoxShape.circle,
              ),
              child: Container(
                margin: EdgeInsets.all(10.sp),
                height: 500.sp,
                clipBehavior: Clip.antiAlias,
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.grey,
                ),
                child: (ref.watch(profileLogic).isLoggedIn)
                    ? Image.network(ref.watch(profileLogic).user?.avatar ?? "")
                    : Container(),
              ),
            ),
          ),
          30.verticalSpace,
          if ((ref.watch(profileLogic).isLoggedIn) &&
              ref.watch(profileLogic).user?.nmcNo != null)
            Center(
              child: Text(
                "NMC number: ${ref.watch(profileLogic).user?.nmcNo ?? ""}",
                style:
                    TextStyle(color: const Color(0xff6B6969), fontSize: 35.sp),
              ),
            ),
          Center(
            child: Text(
              (ref.watch(profileLogic).isLoggedIn)
                  ? ref.watch(profileLogic).user?.titleName ?? ""
                  : "Guest",
              style: TextStyle(
                  color: Colors.black,
                  fontSize: 55.sp,
                  fontWeight: FontWeight.w600),
            ),
          ),
          // if ((ref.watch(profileLogic).isLoggedIn))
          //    Center(child: Text(ref.watch(profileLogic).user?. ?? "")),
          50.verticalSpace,
          InkWell(
            onTap: () async {
              if ((ref.watch(profileLogic).isLoggedIn)) {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const ConferenceQRView()));
              } else {
                bool? success = await Navigator.push(context,
                    MaterialPageRoute(builder: (context) => const LoginView()));
                print(success ?? false);
                if (success != null && success) {
                  ref.watch(profileLogic).setUser();
                }
              }
            },
            child: ListTile(
              leading: Image.asset(
                "assets/qr.png",
                color: Color(0xff1A6BE5),
              ),
              title: Text(
                "Conference Qr Code",
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 40.sp,
                    fontWeight: FontWeight.w600),
              ),
              trailing: Icon(Icons.keyboard_arrow_right),
            ),
          ),
          const Divider(),
          InkWell(
            onTap: () async {
              if ((ref.watch(profileLogic).isLoggedIn)) {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const Membership()));
              } else {
                bool? success = await Navigator.push(context,
                    MaterialPageRoute(builder: (context) => const LoginView()));
                print(success ?? false);
                if (success != null && success) {
                  ref.watch(profileLogic).setUser();
                }
              }
            },
            child: ListTile(
              leading: Image.asset(
                "assets/Setting.png",
                color: Color(0xff1A6BE5),
              ),
              title: Text(
                "Memberships",
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 40.sp,
                    fontWeight: FontWeight.w600),
              ),
              trailing: const Icon(Icons.keyboard_arrow_right),
            ),
          ),
          // const Divider(),
          // InkWell(
          //   onTap: () async {
          //     if ((ref.watch(profileLogic).isLoggedIn)) {
          //       Navigator.push(
          //           context,
          //           MaterialPageRoute(
          //               builder: (context) => const Certificates()));
          //     } else {
          //       bool? success = await Navigator.push(context,
          //           MaterialPageRoute(builder: (context) => const LoginView()));
          //       print(success ?? false);
          //       if (success != null && success) {
          //         ref.watch(profileLogic).setUser();
          //       }
          //     }
          //   },
          //   child: ListTile(
          //     leading: Image.asset(
          //       "assets/bill.png",
          //       color: Color(0xff1A6BE5),
          //     ),
          //     title: Text(
          //       "My Certificates",
          //       style: TextStyle(
          //           color: Colors.black,
          //           fontSize: 40.sp,
          //           fontWeight: FontWeight.w600),
          //     ),
          //     trailing: const Icon(Icons.keyboard_arrow_right),
          //   ),
          // ),
          const Divider(),
          InkWell(
            onTap: () async {
              if ((ref.watch(profileLogic).isLoggedIn)) {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const ChangePasswordView()));
              } else {
                bool? success = await Navigator.push(context,
                    MaterialPageRoute(builder: (context) => const LoginView()));
                print(success ?? false);
                if (success != null && success) {
                  ref.watch(profileLogic).setUser();
                }
              }
            },
            child: ListTile(
              leading: Image.asset(
                "assets/lock.png",
                color: Color(0xff1A6BE5),
              ),
              title: Text(
                "Change Password",
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 40.sp,
                    fontWeight: FontWeight.w600),
              ),
              trailing: Icon(Icons.keyboard_arrow_right),
            ),
          ),
          const Divider(),
          InkWell(
            onTap: () async {
              if ((ref.watch(profileLogic).isLoggedIn)) {
                bool? value = await showDialog(
                    context: context,
                    builder: (context) {
                      return AlertDialog(
                        backgroundColor: Colors.transparent,
                        actionsPadding: EdgeInsets.zero,
                        contentPadding: EdgeInsets.all(50.h),
                        titlePadding: EdgeInsets.zero,
                        insetPadding: EdgeInsets.zero,
                        buttonPadding: EdgeInsets.zero,
                        iconPadding: EdgeInsets.zero,
                        content: const ConfirmationDialog(
                          title: "Logout Confirmation",
                          description: "Are you sure you want to log out?",
                        ),
                      );
                    });
                if (value != null && value) {
                  SharedPreferences pref =
                      await SharedPreferences.getInstance();
                  pref.clear();
                  ref.watch(profileLogic).setLoggedInFalse();
                  showToast("Logged out successfully",
                      position: ToastPosition.bottom);
                }
              }
            },
            child: ListTile(
              leading: Image.asset(
                "assets/out.png",
                color: Color(0xff1A6BE5),
              ),
              title: Text(
                "Log Out",
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 40.sp,
                    fontWeight: FontWeight.w600),
              ),
              trailing: Icon(Icons.keyboard_arrow_right),
            ),
          ),
          const Divider(),
        ],
      ),
    );
  }
}
