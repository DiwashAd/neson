import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:neson/dashboard/bottom_bar.dart';
import 'package:permission_handler/permission_handler.dart';

class SplashView extends ConsumerStatefulWidget {
  const SplashView({Key? key}) : super(key: key);

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _SplashViewState();
}

class _SplashViewState extends ConsumerState<SplashView> {
  getPermission() async {
    if (!await Permission.storage.isGranted) {
      await Permission.storage.request();
    }
  }

  splashLogic() async {
    await Future.delayed(const Duration(seconds: 3)).then((value) {
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => const BottomBar()));
    });
  }

  @override
  void initState() {
    splashLogic();

    getPermission();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: double.infinity,
      width: double.infinity,
      color: Colors.white,
      padding: EdgeInsets.symmetric(horizontal: 50.sp, vertical: 20.sp),
      child: Image.asset(
        "assets/logo.png",
        width: 600,
      ),
    );
  }
}
