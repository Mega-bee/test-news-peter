import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/Helpers/colors.dart';
import 'package:news_app/hive/hive.dart';
import 'package:news_app/news_module/request/news_filter_request.dart';
import 'package:news_app/news_module/ui/widget/NewsCard.dart';

import '../../../Auth_Module/ui/screen/login.dart';
import '../../model/NewsOne.dart';
import '../../../Views/connactionError.dart';
import '../../../network/DataLoaderBloc.dart';
import '../../../network/WebUrl.dart';

class NewsListOne extends StatefulWidget {
  const NewsListOne({Key? key}) : super(key: key);

  @override
  State<NewsListOne> createState() => _NewsListOneState();
}

class _NewsListOneState extends State<NewsListOne> {
  List<NewsOne> news = [];
  var _searchQuery = TextEditingController();
  String? _fromDate;
  String? _toDate;
  final queryFocusNode = FocusNode();
  late DataLoaderBloc newsListBloc;

  @override
  void initState() {
    super.initState();
    _searchQuery.text = 'tesla';
    queryFocusNode.unfocus();
    newsListBloc = DataLoaderBloc(Default());
    newsListBloc.add(
      FetchData(
        Urls.NEWS_ONE,
        requestType: RequestType.get,
        query: FilterNewsRequest(
          searchText: _searchQuery.text,
        ).toJson(),
      ),
    );
  }

  var _selectedDateFrom = DateTime.now();
  var _selectedDateTo = DateTime.now();

  void _presentDatePickerFrom() {
    showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2022),
      lastDate: DateTime.now(),
    ).then((pickedDate) {
      if (pickedDate == null) {
        return;
      }
      setState(() {
        _selectedDateFrom = pickedDate;
      });
    });
    print('...');
  }

  void _presentDatePickerTo() {
    showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1995),
      lastDate: DateTime.now(),
    ).then((pickedDate) {
      if (pickedDate == null) {
        return;
      }
      setState(() {
        _selectedDateTo = pickedDate;
      });
    });
    print('...');
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
              hintStyle: TextStyle(color: Colors.white),
            ),
          ),
          leading: IconButton(
              onPressed: () {
                AuthPrefsHelper().clearToken().then((value) =>
                    Navigator.of(context).pushAndRemoveUntil(
                        MaterialPageRoute(builder: (context) => LoginScreen()),
                        (route) => false));
              },
              icon: Icon(Icons.logout)),
          actions: [
            IconButton(
              onPressed: () {
                if (_searchQuery.text.isNotEmpty) {
                  queryFocusNode.unfocus();
                  newsListBloc.add(
                    FetchData(
                      Urls.NEWS_ONE,
                      requestType: RequestType.get,
                      query: FilterNewsRequest(searchText: _searchQuery.text)
                          .toJson(),
                    ),
                  );
                }
//              showSearch(context: context, delegate: customSearchDelegate(),);
              },
              icon: Icon(Icons.search),
            ),
            PopupMenuButton(
              color: customColor,
              icon: Icon(Icons.sort),
              itemBuilder: (context) {
                return [
                  PopupMenuItem(
                      height: 2,
                      textStyle: TextStyle(color: textColor),
                      value: 0,
                      child: Text("Sort By")),
                  PopupMenuItem(
                      value: 1,
                      child: Text(
                        "Popularity",
                        style: TextStyle(
                          color: textColor,
                        ),
                      )),
                  PopupMenuItem(
                      value: 2,
                      child: Text(
                        "PublishedAt",
                        style: TextStyle(
                          color: textColor,
                        ),
                      )),
                ];
              },
              onSelected: (value) {
                if (value == 1) {
                  newsListBloc.add(
                    FetchData(
                      Urls.NEWS_ONE,
                      requestType: RequestType.get,
                      query: FilterNewsRequest(
                        sortBy: "PublishedAt",
                        fromDate: _selectedDateFrom.toString(),
                        toDate: _selectedDateTo.toString(),
                        searchText: _searchQuery.text,
                      ).toJson(),
                    ),
                  );
                }
                if (value == 2) {
                  newsListBloc.add(
                    FetchData(
                      Urls.NEWS_ONE,
                      requestType: RequestType.get,
                      query: FilterNewsRequest(
                              sortBy: "Popularity",
                              fromDate: _selectedDateFrom.toString(),
                              toDate: _selectedDateTo.toString(),
                              searchText: _searchQuery.text)
                          .toJson(),
                    ),
                  );
                }
              },
            )
          ],
        ),
        body: Container(
          color: customColor,
          child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
            Row(mainAxisAlignment: MainAxisAlignment.spaceAround, children: [
              Text(
                "Filter by date:",
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                  color: textColor,
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  color: customColor,
                  height: MediaQuery.of(context).size.height * 0.038,
                  child: TextButton(
                    style: TextButton.styleFrom(
                      primary: Theme.of(context).primaryColor,
                    ),
                    child: Text(
                      'From: ${_selectedDateFrom.year}/${_selectedDateFrom.month}/${_selectedDateFrom.day}',
                      style: TextStyle(
                        fontSize: 13,
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    onPressed: _presentDatePickerFrom,
                  ),
                ),
              ),
              Container(
                color: customColor,
                height: MediaQuery.of(context).size.height * 0.038,
                child: TextButton(
                  style: TextButton.styleFrom(
                    primary: Theme.of(context).primaryColor,
                  ),
                  child: Text(
                    'To: ${_selectedDateTo.year}/${_selectedDateTo.month}/${_selectedDateTo.day}',
                    style: TextStyle(
                      fontSize: 13,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  onPressed: _presentDatePickerTo,
                ),
              ),
              TextButton(
                style: TextButton.styleFrom(
                  primary: Theme.of(context).primaryColor,
                ),
                child: Text(
                  'Search',
                  style: TextStyle(
                    fontSize: 13,
                    color: textColor,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                onPressed: () {
                  print("Date format:");
                  newsListBloc.add(
                    FetchData(
                      Urls.NEWS_ONE,
                      requestType: RequestType.get,
                      query: FilterNewsRequest(
                              fromDate: _selectedDateFrom.toString(),
                              toDate: _selectedDateTo.toString(),
                              searchText: _searchQuery.text)
                          .toJson(),
                    ),
                  );
                },
              ),
            ]),
            Container(
              height: MediaQuery.of(context).size.height * 0.8,
              child: BlocBuilder<DataLoaderBloc, GlobalState>(
                  bloc: newsListBloc,
                  builder: (context, state) {
                    if (state is Loading) {
                      print("Loading");
                      return Center(
                        child: CircularProgressIndicator(
                          color: textColor,
                        ),
                      );
                    } else if (state is ConnectionError) {
                      print("Connection error");
                      return ConnectionErrorScreen(
                          errorMessage: 'connectionError',
                          retry: () {
                            BlocProvider.of<DataLoaderBloc>(context)
                              ..add(FetchData(Urls.NEWS_ONE,
                                  requestType: RequestType.get));
                          });
                    } else if (state is Error) {
                      print("Error try again please");
                      return ConnectionErrorScreen(
                          errorMessage: state.errorMessage,
                          retry: () {
                            BlocProvider.of<DataLoaderBloc>(context)
                              ..add(FetchData(Urls.NEWS_ONE,
                                  requestType: RequestType.get));
                          });
                    } else if (state is Successfully) {
                      print("Successfully");
                      news.clear();
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
          ]),
        ));
  }
}
