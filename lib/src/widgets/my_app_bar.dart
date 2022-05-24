import 'package:flutter/material.dart';
import 'package:grid_test/src/helpers/helper.dart';
import 'package:global_configuration/global_configuration.dart';

class MyAppBar extends StatefulWidget implements PreferredSizeWidget {
  final double radius;
  const MyAppBar({Key? key, required this.radius}) : super(key: key);

  @override
  MyAppBarState createState() => MyAppBarState();

  @override
  // TODO: implement preferredSize
  Size get preferredSize => Size.fromRadius(radius);
}

class MyAppBarState extends State<MyAppBar> {
  Helper get hp => Helper.of(context);
  @override
  Widget build(BuildContext context) {
    return AppBar(
        title: Image.asset(
            GlobalConfiguration().getValue('asset_image_path') + 'logo.jpg',
            alignment: Alignment.centerLeft,
            width: hp.width / 6,
            height: hp.height / 20),
        actions: [
          SizedBox(width: hp.width / 20),
          SizedBox(width: hp.width / 20)
          // IconButton(onPressed: () {}, icon: Icon(Icons.notifications)),
          // IconButton(onPressed: () {}, icon: Icon(Icons.chat_outlined)),
          // IconButton(
          //     onPressed: () {}, icon: Icon(Icons.exit_to_app_outlined))
        ]);
  }
}
