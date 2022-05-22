import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/news_module/ui/widget/NewsCard.dart';

import '../../model/NewsOne.dart';
import '../../../Views/connactionError.dart';
import '../../../network/DataLoaderBloc.dart';
import '../../../network/WebUrl.dart';
import '../widget/searchBar.dart';

class NewsListOne extends StatefulWidget {
  const NewsListOne({Key? key}) : super(key: key);

  @override
  State<NewsListOne> createState() => _NewsListOneState();
}

class _NewsListOneState extends State<NewsListOne> {
  List<NewsOne> news = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text("Popular News"),
        actions: [
          IconButton(
            onPressed: () {
              showSearch(context: context, delegate: customSearchDelegate(),);

            },
            icon: Icon(Icons.search),
          ),
        ],
      ),
      body: BlocProvider(
        create: (BuildContext context) =>
        DataLoaderBloc(Default())
          ..add(FetchData(
            Urls.NEWS_ONE,
            requestType: RequestType.get,
          )),
        child:
        BlocBuilder<DataLoaderBloc, GlobalState>(builder: (context, state) {
          if (state is Loading) {
            print("Loading");
            return Center(
              child: CircularProgressIndicator(),
            );
          } else if (state is ConnectionError) {
            print("Connection error");
            return Expanded(
              child: ConnectionErrorScreen(
                  errorMessage: 'connectionError',
                  retry: () {
                    BlocProvider.of<DataLoaderBloc>(context)
                      ..add(FetchData(Urls.NEWS_ONE,
                          requestType: RequestType.get));
                  }),
            );
          } else if (state is Error) {
            print("Error try again please");
            return Expanded(
              child: ConnectionErrorScreen(
                  errorMessage: state.errorMessage,
                  retry: () {
                    BlocProvider.of<DataLoaderBloc>(context)
                      ..add(FetchData(Urls.NEWS_ONE,
                          requestType: RequestType.get));
                  }),
            );
          } else if (state is Successfully) {
            print("Successfully");
            for (var item in state.data) {
              news.add(item);
            }
            return ListView.builder(
                shrinkWrap: true,
                itemCount: news.length,
                itemBuilder: (context, index) {
                  return NewsCard(news[index]);
                });
          }
          return Container();
        }),
      ),
    );
  }
}
