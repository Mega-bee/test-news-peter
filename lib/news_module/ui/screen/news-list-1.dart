import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/news_module/request/news_filter_request.dart';
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
  var _searchQuery = TextEditingController();
  final queryFocusNode = FocusNode();
  late DataLoaderBloc newsListBloc;

  @override
  void initState() {
    super.initState();
    _searchQuery.text = 'tesla';
    queryFocusNode.unfocus();
    newsListBloc = DataLoaderBloc(Default());
    newsListBloc.add(FetchData(Urls.NEWS_ONE,
        requestType: RequestType.get,
        query: FilterNewsRequest(searchText: _searchQuery.text).toJson()
    ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: TextField(
          controller: _searchQuery,
          focusNode: queryFocusNode,
          cursorColor: Colors.white,
          style: TextStyle(color: Colors.white),
          decoration: InputDecoration(
//              border: InputBorder.none,
              hintText: "Search news...",
              hintStyle: TextStyle(color: Colors.white)),
        ),
        actions: [
          IconButton(
            onPressed: () {
              if (_searchQuery.text.isNotEmpty) {
                queryFocusNode.unfocus();
                newsListBloc.add(FetchData(Urls.NEWS_ONE,
                    requestType: RequestType.get));
              }
//              showSearch(context: context, delegate: customSearchDelegate(),);
            },
            icon: Icon(Icons.search),
          ),
        ],
      ),
      body: BlocBuilder<DataLoaderBloc, GlobalState>(
          bloc: newsListBloc,
          builder: (context, state) {
        if (state is Loading) {
          print("Loading");
          return Center(
            child: CircularProgressIndicator(),
          );
        } else if (state is ConnectionError) {
          print("Connection error");
          return ConnectionErrorScreen(
              errorMessage: 'connectionError',
              retry: () {
                BlocProvider.of<DataLoaderBloc>(context)
                  ..add(FetchData(Urls.NEWS_ONE, requestType: RequestType.get));
              });
        } else if (state is Error) {
          print("Error try again please");
          return ConnectionErrorScreen(
              errorMessage: state.errorMessage,
              retry: () {
                BlocProvider.of<DataLoaderBloc>(context)
                  ..add(FetchData(Urls.NEWS_ONE, requestType: RequestType.get));
              });
        } else if (state is Successfully) {
          print("Successfully");
          for (var item in state.data) {
          news.clear();
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
    );
  }
}
