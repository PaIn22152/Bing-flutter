import 'package:bing_flutter/my_all_imports.dart';
import 'package:bing_flutter/routes/history/bloc/history_bloc.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HistoryRoute extends StatefulWidget {
  @override
  _HistoryRouteState createState() => _HistoryRouteState();
}

double _lastOffset = 0.0;

class _HistoryRouteState extends BaseState<HistoryRoute>
    with SingleTickerProviderStateMixin {
  final HistoryBloc _historyBloc = HistoryBloc();

  final ScrollController _scrollController = ScrollController();

  AnimationController _controller;
  CurvedAnimation _anim;

  @override
  void initState() {
    _scrollController.addListener(() {
      _lastOffset = _scrollController.offset;
      // logD('addListener  _lastOffset=$_lastOffset');
    });
    _controller = AnimationController(
        lowerBound: 0.8,
        upperBound: 1.0,
        duration: const Duration(milliseconds: 1200),
        vsync: this);
    _anim = CurvedAnimation(parent: _controller, curve: Curves.easeInOutBack);
    _controller.repeat(reverse: true);

    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget bodyWidget() {
    return BlocProvider(
      create: (_) => _historyBloc..add(HistoryStartedEvent()),
      child: BlocBuilder<HistoryBloc, HistoryState>(
        builder: (context, state) {
          if (state is HistoryInitialState || state is HistoryGotFromDbState) {
            if (state is HistoryGotFromDbState) {
              // logD('jumpTo  _lastOffset=$_lastOffset');
              _scrollController.jumpTo(_lastOffset);
            }
            return Scaffold(
              appBar: AppBar(
                title: const Text(historyTitle),
              ),
              body: Stack(
                children: [
                  ListView.builder(
                      itemCount: state.imgs.length,
                      controller: _scrollController,
                      itemBuilder: (BuildContext context, int index) {
                        return ListTile(
                          title: ClipRRect(
                            borderRadius: BorderRadius.circular(6.w),
                            child: Container(
                                width: 360.w,
                                height: 180.w,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(6.w),
                                  border: Border.all(
                                      color: Colors.grey, width: 2.w),
                                ),
                                child: ClipRRect(
                                    borderRadius: BorderRadius.circular(3.w),
                                    child: Stack(
                                      children: [
                                        Align(
                                          alignment: Alignment.topCenter,
                                          child: Hero(
                                            tag: state.imgs[index].enddate,
                                            child: CachedNetworkImage(
                                              width: 360.w,
                                              height: 180.w,
                                              fit: BoxFit.cover,
                                              imageUrl: state.imgs[index].url,
                                              placeholder: (context, url) =>
                                                  const CupertinoActivityIndicator(),
                                              errorWidget: (context, url,
                                                      dynamic error) =>
                                                  const Icon(Icons.error),
                                            ),
                                          ),
                                        ),
                                        Container(
                                          width: 360.w,
                                          height: 40.w,
                                          color: historyDateBg,
                                          child: Center(
                                            child: Text(
                                              state.imgs[index].enddate,
                                              style: TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 15.sp),
                                            ),
                                          ),
                                        )
                                      ],
                                    ))),
                          ),
                          onTap: () {
                            logD('onTap');
                            Navigator.pop(context, state.imgs[index]);
                          },
                        );
                      }),
                  Container(
                      margin: EdgeInsets.all(10.w),
                      child: Align(
                        alignment: Alignment.bottomCenter,
                        child: ScaleTransition(
                            scale: _anim,
                            child: Container(
                              width: 60.w,
                              height: 50.w,
                              decoration: BoxDecoration(
                                color: const Color(0x88000000),
                                borderRadius: BorderRadius.circular(7.w),
                              ),
                              child: Container(
                                margin: EdgeInsets.all(10.w),
                                child: GestureDetector(
                                  onTap: () {
                                    _scrollController.animateTo(0.0,
                                        duration: const Duration(seconds: 1),
                                        curve: Curves.fastLinearToSlowEaseIn);
                                  },
                                  child: Center(
                                    child: Image.asset(
                                      '${png_header}back-up.png',
                                      color: color_theme,
                                    ),
                                  ),
                                ),
                              ),
                            )),
                      )),
                ],
              ),
            );
          }
          return Center(
            child: Text('error state=$state'),
          );
        },
      ),
    );
  }
}
