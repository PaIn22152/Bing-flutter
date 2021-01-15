import 'package:bing_flutter/my_all_imports.dart';
import 'package:flutter/material.dart';

//路由状态观察者
final RouteObserver<Route<dynamic>> routeObserver = RouteObserver();

abstract class BaseState<T extends StatefulWidget> extends State
    with RouteAware, AutomaticKeepAliveClientMixin {
  ///使用[mounted]
  // bool isAlive = false; //state是否被销毁

  ///StatefulWidge 渲染结束的回调，并只会回调一次
  void afterFrame(Duration timeStamp) {}

  ///当前页面发生切换后，是否保持状态，返回true，保持状态，不会重绘
  bool keepAlive() {
    return false;
  }

  Widget bodyWidget();

  Color bgColor() {
    return Colors.white;
  }

  @override
  bool get wantKeepAlive => keepAlive();

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback(afterFrame);
    super.initState();
  }

  @override
  void didChangeDependencies() {
    routeObserver.subscribe(this, ModalRoute.of(context)); //订阅
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
      backgroundColor: bgColor(),
      body: bodyWidget(),
    );
  }
}
