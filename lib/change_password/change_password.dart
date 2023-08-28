import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:neson/change_password/change_pw_logic.dart';
import 'package:neson/utils/themes.dart';
import 'package:oktoast/oktoast.dart';

class ChangePasswordView extends ConsumerStatefulWidget {
  const ChangePasswordView({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _ChangePasswordViewState();
}

class _ChangePasswordViewState extends ConsumerState<ChangePasswordView> {
  final GlobalKey formKey = GlobalKey<FormState>();
  TextEditingController oldPw = TextEditingController();
  TextEditingController newPw = TextEditingController();
  TextEditingController confirmPw = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Change Password",
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
      body: SizedBox(
        height: double.infinity,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 100.sp, vertical: 20.sp),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Center(
                child: Form(
                  key: formKey,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Container(
                        height: 90.h,
                        padding: EdgeInsets.symmetric(horizontal: 20.sp),
                        decoration: BoxDecoration(
                            color: Colors.grey.withOpacity(0.2),
                            borderRadius: BorderRadius.circular(20.sp)),
                        child: Center(
                          child: TextFormField(
                            controller: oldPw,
                            cursorColor: Colors.black,
                            // focusNode: node,
                            style:
                                Themes.heading2.copyWith(color: Colors.black),
                            obscureText:
                                ref.watch(changePasswordLogic).obscure1,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter a valid ';
                              }
                              return null;
                            },
                            decoration: InputDecoration(
                                focusedErrorBorder: InputBorder.none,
                                suffixIcon: InkWell(
                                    onTap: () {
                                      ref
                                          .watch(changePasswordLogic.notifier)
                                          .toggleObscure(
                                              obs1: !ref
                                                  .watch(changePasswordLogic)
                                                  .obscure1);
                                    },
                                    child: Icon(
                                      Icons.remove_red_eye,
                                      color: ref
                                              .watch(changePasswordLogic)
                                              .obscure1
                                          ? Colors.grey
                                          : Colors.green,
                                    )),
                                enabledBorder: InputBorder.none,
                                hintText: "Enter current password",
                                focusedBorder: InputBorder.none),
                          ),
                        ),
                      ),
                      20.verticalSpace,
                      Container(
                        height: 90.h,
                        padding: EdgeInsets.symmetric(horizontal: 20.sp),
                        decoration: BoxDecoration(
                            color: Colors.grey.withOpacity(0.2),
                            borderRadius: BorderRadius.circular(20.sp)),
                        child: Center(
                          child: TextFormField(
                            controller: newPw,
                            cursorColor: Colors.black,
                            // focusNode: node,
                            style:
                                Themes.heading2.copyWith(color: Colors.black),
                            obscureText:
                                ref.watch(changePasswordLogic).obscure2,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter a valid ';
                              }
                              return null;
                            },
                            decoration: InputDecoration(
                                focusedErrorBorder: InputBorder.none,
                                suffixIcon: InkWell(
                                    onTap: () {
                                      ref
                                          .watch(changePasswordLogic.notifier)
                                          .toggleObscure(
                                              obs2: !ref
                                                  .watch(changePasswordLogic)
                                                  .obscure2);
                                    },
                                    child: Icon(
                                      Icons.remove_red_eye,
                                      color: ref
                                              .watch(changePasswordLogic)
                                              .obscure2
                                          ? Colors.grey
                                          : Colors.green,
                                    )),
                                enabledBorder: InputBorder.none,
                                hintText: "Enter new password",
                                focusedBorder: InputBorder.none),
                          ),
                        ),
                      ),
                      20.verticalSpace,
                      Container(
                        height: 90.h,
                        padding: EdgeInsets.symmetric(horizontal: 20.sp),
                        decoration: BoxDecoration(
                            color: Colors.grey.withOpacity(0.2),
                            borderRadius: BorderRadius.circular(20.sp)),
                        child: Center(
                          child: TextFormField(
                            controller: confirmPw,
                            cursorColor: Colors.black,
                            // focusNode: node,
                            style:
                                Themes.heading2.copyWith(color: Colors.black),
                            obscureText:
                                ref.watch(changePasswordLogic).obscure3,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter a valid ';
                              }
                              return null;
                            },
                            decoration: InputDecoration(
                                focusedErrorBorder: InputBorder.none,
                                suffixIcon: InkWell(
                                    onTap: () {
                                      ref
                                          .watch(changePasswordLogic.notifier)
                                          .toggleObscure(
                                              obs3: !ref
                                                  .watch(changePasswordLogic)
                                                  .obscure3);
                                    },
                                    child: Icon(
                                      Icons.remove_red_eye,
                                      color: ref
                                              .watch(changePasswordLogic)
                                              .obscure3
                                          ? Colors.grey
                                          : Colors.green,
                                    )),
                                enabledBorder: InputBorder.none,
                                hintText: "Confirm new password",
                                focusedBorder: InputBorder.none),
                          ),
                        ),
                      ),
                      70.verticalSpace,
                      Center(
                        child: InkWell(
                            onTap: () async {
                              var data = await ref
                                  .watch(changePasswordLogic)
                                  .changePassword(
                                      oldPw.text, newPw.text, confirmPw.text);
                              print(data);
                              if (data != {} && data['status']) {
                                showToast("Password updated successfully",
                                    position: ToastPosition.bottom);
                                Navigator.pop(context);
                              } else {
                                if (data == {}) {
                                  print("here");
                                  showToast(
                                      "Something went wrong please try again",
                                      position: ToastPosition.bottom);
                                } else {
                                  print("here else");
                                  print(data['message']);

                                  showToast(data['message'] ?? "",
                                      position: ToastPosition.bottom);
                                }
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
                                width: 500.w,
                                padding:
                                    const EdgeInsets.symmetric(vertical: 15),
                                decoration: BoxDecoration(
                                  color: Color(0xff1A6BE5),
                                  borderRadius: BorderRadius.circular(40.sp),
                                ),
                                child: Center(
                                    child: Text(
                                  "Change Password",
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
              ),
            ],
          ),
        ),
      ),
    );
  }
}
