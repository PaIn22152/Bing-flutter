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

class _HistoryRouteState extends BaseState<HistoryRoute> {
  final HistoryBloc _historyBloc = HistoryBloc();

  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    _scrollController.addListener(() {
      _lastOffset = _scrollController.offset;
      // logD('addListener  _lastOffset=$_lastOffset');
    });
    super.initState();
  }

  @override
  Widget bodyWidget() {
    return BlocProvider(
      create: (_) => _historyBloc..add(HistoryStarted()),
      child: BlocBuilder<HistoryBloc, HistoryState>(
        builder: (context, state) {
          if (state is HistoryInitial || state is HistoryGotFromDb) {
            if (state is HistoryGotFromDb) {
              // logD('jumpTo  _lastOffset=$_lastOffset');
              _scrollController.jumpTo(_lastOffset);
            }
            return Scaffold(
              appBar: AppBar(
                title: const Text(historyTitle),
              ),
              body: ListView.builder(
                  itemCount: state.imgs.length,
                  controller: _scrollController,
                  itemBuilder: (BuildContext context, int index) {
                    return ListTile(
                      title: Container(
                          width: 360.w,
                          height: 200.w,
                          margin: EdgeInsets.fromLTRB(0, 0, 0, 10.w),
                          child: Stack(
                            children: [
                              Align(
                                alignment: Alignment.topCenter,
                                child: CachedNetworkImage(
                                  imageUrl: state.imgs[index].url,
                                  placeholder: (context, url) =>
                                      const CupertinoActivityIndicator(),
                                  errorWidget: (context, url, dynamic error) =>
                                      const Icon(Icons.error),
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
                                        color: Colors.white, fontSize: 15.sp),
                                  ),
                                ),
                              )
                            ],
                          )),
                      onTap: () {
                        logD('onTap');
                        Navigator.pop(context, state.imgs[index]);
                      },
                    );
                  }),
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
