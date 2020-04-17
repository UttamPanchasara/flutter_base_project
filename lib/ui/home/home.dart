import 'package:flutter/material.dart';
import 'package:flutterbase/ui/base/base_stateful_widget.dart';
import 'package:flutterbase/ui/home/bloc/home_bloc.dart';
import 'package:flutterbase/widgets/my_place_holder.dart';
import 'package:flutterbase/widgets/state_handler.dart';

import 'entity/product_list.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends BaseStatefulWidgetState<HomePage> {
  final _homeBloc = HomeBloc();

  @override
  void initState() {
    super.initState();
    _homeBloc.getAllPost();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Home'),
      ),
      body: StreamBuilder(
        stream: _homeBloc.viewState,
        builder: (context, snapshot) {
          return StateHandler(
            body: _postList(snapshot?.data?.data ?? []),
            viewState: snapshot?.data,
          );
        },
      ),
    );
  }

  Widget _postList(List<Post> postList) {
    if (postList.isEmpty) {
      return MYPlaceHolder(
        message: 'There no any post at the moment!!',
      );
    }
    return ListView.separated(
      separatorBuilder: (_, position) {
        return SizedBox(height: 10.0);
      },
      shrinkWrap: true,
      itemBuilder: (context, position) {
        Post post = postList[position];
        return Card(
          margin: EdgeInsets.symmetric(horizontal: 10.0),
          child: Padding(
            padding: EdgeInsets.all(10.0),
            child: Text(
              post.body,
              maxLines: 4,
              overflow: TextOverflow.ellipsis,
            ),
          ),
        );
      },
      itemCount: postList.length,
    );
  }
}
