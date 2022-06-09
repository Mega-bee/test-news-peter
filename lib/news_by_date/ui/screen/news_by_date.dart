import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/helpers/colors.dart';

import '../../../Views/connactionError.dart';
import '../../../generated/l10n.dart';
import '../../../hive/hive.dart';
import '../../../network/WebUrl.dart';
import '../../../network/bloc_service/DataLoaderBlocNewsByDate.dart';
import '../../model/newsByDate.dart';
import '../../request/news_by_date.dart';

class NewsByDate extends StatefulWidget {
  const NewsByDate({Key? key}) : super(key: key);

  @override
  State<NewsByDate> createState() => _NewsByDate();
}

class _NewsByDate extends State<NewsByDate> {
  late NewsByDateBloc newsByDate;

  @override
  void initState() {
    newsByDate = NewsByDateBloc(Default());
    newsByDate.add(FetchData(
        Urls.NEWS_DATE +
            _selectedDate.month.toString() +
            '/' +
            _selectedDate.day.toString() +
            '/date',
        requestType: RequestType.get,
        query: NewsByDateFilterRequest().toJson()));
  }

  var _selectedDate = DateTime.now();

  void _presentDatePicker() {
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
        _selectedDate = pickedDate;
      });
      newsByDate.add(FetchData(
          Urls.NEWS_DATE +
              _selectedDate.month.toString() +
              '/' +
              _selectedDate.day.toString() +
              '/date',
          requestType: RequestType.get,
          query: NewsByDateFilterRequest().toJson()));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text("News By Date"),
        centerTitle: true,
      ),
      body: BlocBuilder<NewsByDateBloc, GlobalState>(
          bloc: newsByDate,
          builder: (context, state) {
            if (state is Loading) {
              print("Loading");
              return Center(
                child: CircularProgressIndicator(color: Colors.white),
              );
            } else if (state is ConnectionError) {
              print("Connection error");
              return ConnectionErrorScreen(
                  errorMessage: 'connectionError',
                  retry: () {
                    newsByDate
                      ..add(FetchData(Urls.NEWS_DATE,
                          requestType: RequestType.get));
                  });
            } else if (state is Error) {
              print("Error try again please");
              return ConnectionErrorScreen(
                  errorMessage: state.errorMessage,
                  retry: () {
                    BlocProvider.of<NewsByDateBloc>(context)
                      ..add(FetchData(Urls.NEWS_DATE,
                          requestType: RequestType.get));
                  });
            } else if (state is Successfully) {
              NewsByDateModel newsByDateModel = state.data as NewsByDateModel;

              return Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  children: [
                    Row(
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
                              height:
                                  MediaQuery.of(context).size.height * 0.080,
                              child: TextButton(
                                style: TextButton.styleFrom(
                                  primary: Theme.of(context).primaryColor,
                                ),
                                child: Text(
                                  '${S.of(context).from} ${_selectedDate.year}/${_selectedDate.month}/${_selectedDate.day}',
                                  style: TextStyle(
                                    fontSize: 13,
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                onPressed: _presentDatePicker,
                              ),
                            ),
                          ),
                        ]),
                    SizedBox(
                      height: 25,
                    ),
                    Text(
                      "Text: ${newsByDateModel.text}",
                      style: TextStyle(color: textColor, fontSize: 15),
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    Text(
                      "Found: ${newsByDateModel.found}",
                      style: TextStyle(color: textColor, fontSize: 20),
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    Text(
                      "Number: ${newsByDateModel.number}",
                      style: TextStyle(color: textColor, fontSize: 20),
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    Text(
                      "Type: ${newsByDateModel.type}",
                      style: TextStyle(color: textColor, fontSize: 20),
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    Text(
                      "Year: ${newsByDateModel.year}",
                      style: TextStyle(color: textColor, fontSize: 20),
                    ),
                  ],
                ),
              );
            }
            return Container();
          }),
    );
  }
}
