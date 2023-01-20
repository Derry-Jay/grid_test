import 'package:grid_test/src/widgets/custom_button.dart';

import '../helpers/helper.dart';
import 'package:flutter/material.dart';

class IntroScreen extends StatefulWidget {
  const IntroScreen({Key? key}) : super(key: key);

  @override
  IntroScreenState createState() => IntroScreenState();
}

class IntroScreenState extends State<IntroScreen> {
  Helper get hp => Helper.of(context);

  Widget mapItem(int i) {
    return Container(
      width: hp.width / i,
      height: hp.height / (i * 2),
      color: hp.theme.dividerColor,
      // padding: const EdgeInsets.only(top: 20, bottom: 15, left: 25, right: 20),
      child: Center(
        child: Text(i.toString(),
            style:
                TextStyle(color: hp.theme.toggleableActiveColor, fontSize: 20)),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final children = <Widget>[
      const Expanded(
          child: Text('*Lead Form',
              style: TextStyle(fontWeight: FontWeight.w600, fontSize: 16))),
      const Expanded(
          flex: 3,
          child: TextField(
              decoration: InputDecoration(
                  border: OutlineInputBorder(), hintText: 'Lead ID'))),
      const Expanded(
          flex: 3,
          child: TextField(
              decoration: InputDecoration(
                  border: OutlineInputBorder(), hintText: 'Lead ID'))),
      const Expanded(
          flex: 3,
          child: TextField(
              decoration: InputDecoration(
                  border: OutlineInputBorder(), hintText: 'Lead ID'))),
      const Expanded(
          flex: 3,
          child: TextField(
              decoration: InputDecoration(
                  border: OutlineInputBorder(), hintText: 'Lead ID'))),
      const Expanded(
          flex: 3,
          child: TextField(
              decoration: InputDecoration(
                  border: OutlineInputBorder(), hintText: 'Lead ID'))),
      const Expanded(
          flex: 3,
          child: TextField(
              decoration: InputDecoration(
                  border: OutlineInputBorder(), hintText: 'Lead ID'))),
      const Expanded(
          flex: 3,
          child: TextField(
              decoration: InputDecoration(
                  border: OutlineInputBorder(), hintText: 'Lead ID'))),
      const Expanded(
          flex: 3,
          child: TextField(
              decoration: InputDecoration(
                  border: OutlineInputBorder(), hintText: 'Lead ID'))),
      const Expanded(
          flex: 3,
          child: TextField(
              decoration: InputDecoration(
                  border: OutlineInputBorder(), hintText: 'Lead ID'))),
      const Expanded(
          flex: 3,
          child: TextField(
              decoration: InputDecoration(
                  border: OutlineInputBorder(), hintText: 'Lead ID'))),
      const Expanded(
          child: Text('*Address',
              style: TextStyle(fontWeight: FontWeight.w600, fontSize: 16))),
      const Expanded(
          flex: 3,
          child: TextField(
              maxLines: 2,
              decoration: InputDecoration(
                  border: OutlineInputBorder(), hintText: 'Lead ID'))),
      const Expanded(
          flex: 3,
          child: TextField(
              decoration: InputDecoration(
                  suffixIcon: Icon(Icons.keyboard_arrow_down),
                  border: OutlineInputBorder(),
                  hintText: 'Lead ID'))),
      Expanded(
          flex: 2,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: const [
              Flexible(
                  flex: 3,
                  child: TextField(
                      decoration: InputDecoration(
                          border: OutlineInputBorder(), hintText: 'Lead ID'))),
              Flexible(
                  flex: 2,
                  child: TextField(
                      decoration: InputDecoration(
                          border: OutlineInputBorder(), hintText: 'Lead ID')))
            ],
          )),
      Expanded(
          child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          const Flexible(
              child: Text('*Contact',
                  style: TextStyle(fontWeight: FontWeight.w600, fontSize: 16))),
          Flexible(
              flex: 4,
              child: Container(
                  margin: EdgeInsets.only(left: hp.width / 40),
                  child: Icon(
                    Icons.save_alt_outlined,
                    color: hp.theme.primaryColor,
                  )))
        ],
      )),
      const Expanded(
          flex: 3,
          child: TextField(
              decoration: InputDecoration(
                  border: OutlineInputBorder(), hintText: 'Lead ID'))),
      const Expanded(
          flex: 3,
          child: TextField(
              decoration: InputDecoration(
                  border: OutlineInputBorder(), hintText: 'Lead ID'))),
      const Expanded(
          flex: 3,
          child: TextField(
              decoration: InputDecoration(
                  border: OutlineInputBorder(), hintText: 'Lead ID'))),
      const Expanded(
          flex: 3,
          child: TextField(
              decoration: InputDecoration(
                  border: OutlineInputBorder(), hintText: 'Lead ID'))),
      Expanded(
          child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Flexible(
              child: CustomButton(
                  onPressed: () {},
                  type: ButtonType.border,
                  labelColor: Colors.black,
                  shape: RoundedRectangleBorder(
                      borderRadius:
                          BorderRadius.all(Radius.circular(hp.radius / 160)),
                      side: BorderSide(color: hp.theme.primaryColor)),
                  child: const Text('Cancel'))),
          Flexible(
              child: CustomButton(
            onPressed: () {},
            type: ButtonType.raised,
            child: const Text('Next'),
          ))
        ],
      ))
    ];
    return SafeArea(
        child: Scaffold(
      appBar: AppBar(
        title: const Text('Lead'),
        centerTitle: true,
        leading: IconButton(
            onPressed: () {
              hp.goBack();
            },
            icon: const Icon(Icons.arrow_back_ios)),
        actions: [
          IconButton(
              onPressed: () {
                hp.goTo('/home');
              },
              icon: const Icon(Icons.more_vert))
        ],
      ),
      body: SingleChildScrollView(
          padding: EdgeInsets.symmetric(
              horizontal: hp.width / 32, vertical: hp.height / 64),
          child: SizedBox(
              height: (hp.height * children.length) / 8,
              width: hp.width,
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: children))),
    ));
  }
}
