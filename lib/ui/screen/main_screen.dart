import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sotaynamduoc/blocs/base_bloc/base_state.dart';
import 'package:sotaynamduoc/blocs/cubit.dart';
import 'package:sotaynamduoc/ui/widget/base_screen.dart';
import 'package:sotaynamduoc/injection_container.dart';

class MainScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(child: MainBody());
  }
}

class MainBody extends StatelessWidget {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return BaseScreen(
      body: Column(
        children: [
          BlocBuilder<UserInfoCubit, BaseState>(
            bloc: getIt.get<UserInfoCubit>(),
            builder: (_, state) {
              // TODO handle user info here
              return Container();
            },
          )
        ],
      ),
    );
  }
}
