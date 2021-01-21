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

class _HistoryRouteState extends BaseState<HistoryRoute> {
  final HistoryBloc _historyBloc = HistoryBloc();

  @override
  Widget bodyWidget() {
    return BlocProvider(
      create: (_) => _historyBloc..add(HistoryStarted()),
      child: BlocBuilder<HistoryBloc, HistoryState>(
        builder: (context, state) {
          if (state is HistoryInitial || state is HistoryGotFromDb) {
            return Scaffold(
              appBar: AppBar(
                title: const Text(historyTitle),
              ),
              body: ListView.builder(
                  itemCount: state.imgs.length,
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
