import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:neson/login/login_logic.dart';
import 'package:neson/utils/themes.dart';

class Widgets {
  static Widget iconDataHolder(icon, data) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5.0),
      child: Row(
        children: [
          iconDesign(icon),
          const SizedBox(
            width: 15,
          ),
          Expanded(child: Text(data))
        ],
      ),
    );
  }

  static customAppbar(String title, BuildContext context,
      {List<Widget> actions = const []}) {
    return AppBar(
      title: Text(
        title ?? "",
        style: TextStyle(color: Themes.primaryColor, fontSize: 55.sp),
      ),
      centerTitle: true,
      backgroundColor: Colors.transparent,
      elevation: 0,
      leading: InkWell(
          splashColor: Colors.transparent,
          highlightColor: Colors.transparent,
          hoverColor: Colors.transparent,
          onTap: () {
            AutoRouter.of(context).pop();
          },
          child: Icon(
            Icons.keyboard_arrow_left,
            size: 85.sp,
            color: Themes.primaryColor,
          )),
      actions: actions,
    );
  }

  static iconDesign(icon) {
    return Container(
        height: 45.h,
        width: 45.h,
        decoration: Themes.iconHolderDecoration(),
        child: Image.asset(
          icon,
          color: Themes.iconColor,
        ));
  }

  static tabBar(List<Tab> tabs) {
    return TabBar(
        indicatorColor: Colors.transparent,
        unselectedLabelColor: Colors.black,
        labelStyle: Themes.heading2.apply(),
        tabs: tabs);
  }

  static textForm(BuildContext context, String label,
      TextEditingController controller, WidgetRef ref, FocusNode node) {
    return Container(
      height: 90.h,
      padding: EdgeInsets.symmetric(horizontal: 20.sp),
      decoration: BoxDecoration(
          color: Colors.grey.withOpacity(0.2),
          borderRadius: BorderRadius.circular(20.sp)),
      child: Center(
        child: TextFormField(
          controller: controller,
          cursorColor: Colors.black,
          focusNode: node,
          style: Themes.heading2.copyWith(color: Colors.black),
          obscureText: label.toUpperCase().contains('PASSWORD')
              ? ref.watch(loginLogic).obscure
              : false,
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Please enter a valid $label';
            }
            return null;
          },
          decoration: InputDecoration(
              focusedErrorBorder: InputBorder.none,
              suffixIcon: label == 'Password'
                  ? InkWell(
                      onTap: () {
                        ref.watch(loginLogic.notifier).togglePW();
                      },
                      child: Icon(
                        Icons.remove_red_eye,
                        color: ref.watch(loginLogic).obscure
                            ? Themes.iconColor
                            : Colors.green,
                      ))
                  : null,
              enabledBorder: InputBorder.none,
              hintText: label,
              focusedBorder: InputBorder.none),
        ),
      ),
    );
  }

  static imageProvider(String image) {
    return FadeInImage.assetNetwork(
      placeholder: "assets/image.png",
      image: image,
    );
  }
}
