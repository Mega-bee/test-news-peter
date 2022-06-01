import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/helpers/colors.dart';
import 'package:news_app/hive/hive.dart';
import 'package:news_app/news_module/request/news_filter_request.dart';
import 'package:news_app/news_module/ui/widget/NewsCard.dart';
import 'package:news_app/service/localization_service/localization_serrvice.dart';

import '../../../Auth_Module/ui/screen/login.dart';
import '../../../generated/l10n.dart';
import '../../model/NewsOne.dart';
import '../../../Views/connactionError.dart';
import '../../../network/bloc_service/DataLoaderBloc.dart';
import '../../../network/WebUrl.dart';

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
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          shadowColor: textColor,
          elevation: 1,
          automaticallyImplyLeading: false,
          title: TextField(
            controller: _searchQuery,
            focusNode: queryFocusNode,
            cursorColor: Colors.white,
            style: TextStyle(color: Colors.white),
            decoration: InputDecoration(
//              border: InputBorder.none,
              hintText: S.of(context).SearchNews,
              hintStyle: TextStyle(color: Colors.white),
            ),
          ),
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
              color: ThemeHelper().getisDark() ? blackColor : customColor,
              icon: Icon(Icons.sort),
              itemBuilder: (context) {
                return [
                  PopupMenuItem(
                      height: 2,
                      textStyle: TextStyle(color: textColor),
                      value: 0,
                      child: Text(S.of(context).SortBy)),
                  PopupMenuItem(
                      value: 1,
                      child: Text(
                        S.of(context).Popularity,
                        style: TextStyle(
                          color: textColor,
                        ),
                      )),
                  PopupMenuItem(
                      value: 2,
                      child: Text(
                        S.of(context).PublishedAt,
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
            ),
          ],
        ),
        body: RefreshIndicator(
          onRefresh: () async {
            await newsListBloc
              ..add(FetchData(
                Urls.NEWS_ONE,
                requestType: RequestType.get,
                query: FilterNewsRequest(
                  searchText: _searchQuery.text,
                ).toJson(),
              ));
          },
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 18.0),
                child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Text(
                        S.of(context).filterByDate,
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                          color: textColor,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                          color: ThemeHelper().getisDark()
                              ? blackColor
                              : customColor,
                          height: MediaQuery.of(context).size.height * 0.080,
                          child: TextButton(
                            style: TextButton.styleFrom(
                              primary: Theme.of(context).primaryColor,
                            ),
                            child: Text(
                              '${S.of(context).from} ${_selectedDateFrom.year}/${_selectedDateFrom.month}/${_selectedDateFrom.day}',
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
                        color: ThemeHelper().getisDark()
                            ? blackColor
                            : customColor,
                        height: MediaQuery.of(context).size.height * 0.080,
                        child: TextButton(
                          style: TextButton.styleFrom(
                            primary: Theme.of(context).primaryColor,
                          ),
                          child: Text(
                            '${S.of(context).to} ${_selectedDateTo.year}/${_selectedDateTo.month}/${_selectedDateTo.day}',
                            style: TextStyle(
                              fontSize: 13,
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          onPressed: _presentDatePickerTo,
                        ),
                      ),
                    ]),
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
              BlocBuilder<DataLoaderBloc, GlobalState>(
                  bloc: newsListBloc,
                  builder: (context, state) {
                    if (state is Loading) {
                      print("Loading");
                      return Expanded(
                        child: Center(
                          child: CircularProgressIndicator(
                            color: textColor,
                          ),
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

                      return Expanded(
                        child: ListView.builder(
                            shrinkWrap: true,
                            itemCount: news.length,
                            itemBuilder: (context, index) {
                              return NewsCard(news[index]);
                            }),
                      );
                    }
                    return Container();
                  }),
            ],
          ),
        ));
  }
}
