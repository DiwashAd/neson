import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:neson/dashboard/bottom_bar.dart';
import 'package:oktoast/oktoast.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return OKToast(
      child: ProviderScope(
        child: MaterialApp(
          title: 'NESON',
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
            fontFamily: "Poppins",
            useMaterial3: true,
          ),
          home: ScreenUtilInit(
            designSize: const Size(1080, 1366),
            builder: (context, child) {
              return const BottomBar();
            },
          ),
        ),
      ),
    );
  }
}
