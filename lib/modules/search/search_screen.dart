import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/shared/components/components.dart';
import 'package:news_app/shared/cubit/cubit.dart';
import 'package:news_app/shared/cubit/states.dart';

class SearchScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    bool isEmpty = true;
    return BlocConsumer<NewsCubit, NewsStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var cubit = NewsCubit.get(context);
        var list = cubit.search;
        print("buid empty: $isEmpty");
        return Scaffold(
          appBar: AppBar(
            title: Text("News Search"),
          ),
          body: Padding(
            padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 4),
            child: Column(
              children: [
                defaultTextField(
                    prefix: Icons.search,
                    radius: 10,
                    lable: "Search",
                    onChanged: (String val) {
                      if (val.isEmpty || val == "")
                        isEmpty = true;
                      else {
                        isEmpty = false;
                        cubit.getSearch(val);
                      }
                      print("is empty:$isEmpty");
                    }),
                !isEmpty
                    ? Expanded(child: ArticleBuilder(list, context))
                    : Container(),
              ],
            ),
          ),
        );
      },
    );
  }
}
