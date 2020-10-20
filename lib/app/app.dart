import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_demo/app/my_router.dart';
import 'package:flutter_demo/app/routes/home_route.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    return MaterialApp(
      debugShowCheckedModeBanner: true,
      onGenerateRoute: MyRouter.generateRoute,
      home: HomeRoute(),
    );
  }
}
