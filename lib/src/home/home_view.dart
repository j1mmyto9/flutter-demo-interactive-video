import 'package:demovideo/src/routing/routing.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  @override
  void initState() {
    super.initState();
    SystemChrome.setPreferredOrientations([DeviceOrientation.landscapeLeft]);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
          child: InkWell(
        borderRadius: BorderRadius.circular(100),
        child: Container(
          width: 100,
          height: 100,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: Border.all(
              width: 3,
              color: Colors.black,
            ),
          ),
          child: const Center(
            child: Icon(
              Icons.play_arrow,
              size: 64,
            ),
          ),
        ),
        onTap: () {
          Navigator.of(context).pushNamed(RouteNames.video);
        },
      )),
    );
  }
}
