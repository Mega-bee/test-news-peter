import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:news_app/helpers/colors.dart';

import '../../../Views/connactionError.dart';
import '../../../network/WebUrl.dart';
import '../../../network/bloc_service/DataLoaderBlocInstagram.dart';
import '../../model/insta_model.dart';
import '../../request/instagram_request.dart';

class Instagram extends StatefulWidget {
  const Instagram({Key? key}) : super(key: key);

  @override
  State<Instagram> createState() => _InstagramState();
}

class _InstagramState extends State<Instagram> {
  final userName = TextEditingController();
  late InstagramBloc instagramBloc;

  @override
  void initState() {
    instagramBloc = InstagramBloc(Default());
    instagramBloc.add(FetchData(
        Urls.INSTAGRAM_DOMAIN,
        requestType: RequestType.get,
        query: InstagramRequest(username: userName.text).toJson()));
  }

  @override
  Widget build(BuildContext context) {
    var mediaQueryWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        title: Text("Instagram User Id"),
        centerTitle: true,
        automaticallyImplyLeading: false,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: mediaQueryWidth * 0.05),
            child: TextFormField(
              style: const TextStyle(fontSize: 20),
              controller: userName,
              decoration: InputDecoration(
                prefixIcon: Icon(FontAwesomeIcons.userNinja),
                suffixIcon: IconButton(
                  onPressed: () {
                    if (userName.text.isNotEmpty) {
                      instagramBloc.add(FetchData(Urls.INSTAGRAM_DOMAIN,
                          requestType: RequestType.get,
                          query: InstagramRequest(username: userName.text)
                              .toJson()));
                    }
                  },
                  icon: Icon(Icons.search),
                ),
                filled: true,
                fillColor: Colors.white,
                hintText: "Username",
                enabledBorder: const OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                    borderSide: BorderSide(width: 2, color: Colors.black12)),
                border: OutlineInputBorder(
                  borderSide: const BorderSide(color: Colors.grey),
                  borderRadius: BorderRadius.circular(10.0),
                ),
              ),
              autovalidateMode: AutovalidateMode.onUserInteraction,
              // keyboardType: TextInputType.
            ),
          ),
          BlocBuilder<InstagramBloc, GlobalState>(
              bloc: instagramBloc,
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
                        instagramBloc
                          ..add(FetchData(Urls.INSTAGRAM_DOMAIN,
                              requestType: RequestType.get));
                      });
                } else if (state is Error) {
                  print("Error try again please");
                  return ConnectionErrorScreen(
                      errorMessage: state.errorMessage,
                      retry: () {
                        BlocProvider.of<InstagramBloc>(context)
                          ..add(FetchData(Urls.INSTAGRAM_DOMAIN,
                              requestType: RequestType.get));
                      });
                } else if (state is Successfully) {
                  InstaModel instaModel = state.data as InstaModel;
                  return Text('UserId: ${instaModel.userId}',style: TextStyle(color: textColor,fontSize: 20),);
                }
                return Container();
              })
        ],
      ),
    );
  }
}
