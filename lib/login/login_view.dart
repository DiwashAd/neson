import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:neson/login/login_logic.dart';
import 'package:neson/utils/themes.dart';
import 'package:neson/utils/widgets.dart';
import 'package:oktoast/oktoast.dart';

class LoginView extends ConsumerStatefulWidget {
  const LoginView({Key? key}) : super(key: key);

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _LoginScreenState();
}

class _LoginScreenState extends ConsumerState<LoginView> {
  @override
  void initState() {
    super.initState();
  }

  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return body(context);
  }

  body(BuildContext context) {
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
            "Log In",
            style: TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.w600,
            ),
          ),
          centerTitle: true,
          backgroundColor: Colors.white,
          elevation: 0,
        ),
        backgroundColor: Colors.white,
        body: Container(
          height: double.infinity,
          padding: EdgeInsets.symmetric(horizontal: 100.sp, vertical: 20.sp),
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Column(
                  children: [
                    200.verticalSpace,
                    Center(
                      child: Image.asset(
                        "assets/logo.png",
                        width: 500.h,
                      ),
                    ),
                  ],
                ),
                50.verticalSpace,
                Form(
                  key: formKey,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        "Please Log In",
                        style: Themes.heading1.copyWith(color: Colors.black),
                      ),
                      50.verticalSpace,
                      Widgets.textForm(
                          context,
                          "Username",
                          ref.watch(loginLogic.notifier).userName,
                          ref,
                          ref.watch(loginLogic.notifier).usernameFocus),
                      50.verticalSpace,
                      Widgets.textForm(
                          context,
                          "Password",
                          ref.watch(loginLogic.notifier).password,
                          ref,
                          ref.watch(loginLogic.notifier).passwordFocus),
                      25.verticalSpace,
                      // Align(
                      //   alignment: Alignment.bottomRight,
                      //   child: Text(
                      //     "Forgot Password!",
                      //     style: Themes.heading6
                      //         .copyWith(color: Colors.red.withOpacity(0.8)),
                      //   ),
                      // ),
                      70.verticalSpace,
                      Center(
                        child: InkWell(
                            onTap: () async {
                              print("asdadadasdadad");
                              bool success = await ref.read(loginLogic).login(
                                    ref.watch(loginLogic).userName.text,
                                    ref.watch(loginLogic).password.text,
                                  );
                              if (success) {
                                Navigator.pop(context, true);
                              }
                            },
                            child: AnimatedSwitcher(
                              transitionBuilder:
                                  (Widget child, Animation<double> animation) {
                                return ScaleTransition(
                                    scale: animation, child: child);
                              },
                              duration: const Duration(milliseconds: 500),
                              child: Container(
                                width: 700.w,
                                padding:
                                    const EdgeInsets.symmetric(vertical: 15),
                                decoration: BoxDecoration(
                                  color: Color(0xff1A6BE5),
                                  borderRadius: BorderRadius.circular(40.sp),
                                ),
                                child: Center(
                                    child: Text(
                                  "Log In",
                                  style: Themes.heading1
                                      .copyWith(color: Colors.white),
                                )),
                              ),
                            )),
                      ),
                      45.verticalSpace,
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
