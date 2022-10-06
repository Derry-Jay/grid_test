import 'package:flutter/material.dart';
import 'package:grid_test/src/backend/api.dart';
import 'package:grid_test/src/helpers/helper.dart';
import 'package:grid_test/src/widgets/custom_button.dart';

class ItemListPage extends StatefulWidget {
  const ItemListPage({Key? key}) : super(key: key);

  @override
  ItemListPageState createState() => ItemListPageState();
}

class ItemListPageState extends State<ItemListPage> {
  Map<String, dynamic> map = <String, dynamic>{};
  Helper get hp => Helper.of(context);
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
        // backgroundColor: Colors.grey.shade300,
        body: Form(
            key: fk,
            child: SingleChildScrollView(
                child: SizedBox(
                    height: hp.height,
                    width: hp.width,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        TextFormField(
                            controller: nc,
                            onSaved: (String? name) {
                              map['Name'] = name;
                            },
                            decoration: InputDecoration(
                                contentPadding: EdgeInsets.symmetric(
                                    vertical: hp.height / 100,
                                    horizontal: hp.width / 40),
                                border: const OutlineInputBorder(),
                                hintText: hp.loc.full_name)),
                        TextFormField(
                            controller: mc,
                            onSaved: (String? mail) {
                              map['Email'] = mail;
                            },
                            decoration: InputDecoration(
                                contentPadding: EdgeInsets.symmetric(
                                    vertical: hp.height / 100,
                                    horizontal: hp.width / 40),
                                border: const OutlineInputBorder(),
                                hintText: hp.loc.email_address)),
                        TextFormField(
                            controller: pc,
                            onSaved: (String? phone) {
                              map['Mobile'] = phone;
                            },
                            keyboardType: TextInputType.phone,
                            decoration: InputDecoration(
                                contentPadding: EdgeInsets.symmetric(
                                    vertical: hp.height / 100,
                                    horizontal: hp.width / 40),
                                border: const OutlineInputBorder(),
                                hintText: hp.loc.phone)),
                        TextFormField(
                            controller: sc,
                            onSaved: (String? gender) {
                              map['Gender'] = gender;
                            },
                            decoration: InputDecoration(
                                contentPadding: EdgeInsets.symmetric(
                                    vertical: hp.height / 100,
                                    horizontal: hp.width / 40),
                                border: const OutlineInputBorder(),
                                hintText: hp.loc.description)),
                        CustomButton(
                          type: ButtonType.text,
                          onPressed: () async {
                            final prefs = await sharedPrefs;
                            fk.currentState?.save();
                            log(map);
                            final str = await sendData(map);
                            final p = await revealToast(str);
                            log(await prefs.setString('token', str) && p ? str : '');
                          },
                          child: Text(hp.loc.register),
                        )
                      ],
                    )))),
        appBar: AppBar(
            // backgroundColor: Colors.white,
            // foregroundColor: Colors.blue,
            // title: Row(
            //   children: const [
            //     Expanded(child: Text('Trxn Date')),
            //     Expanded(child: Text('Amt'))
            //   ],
            // ),
            // actions: [
            //   Padding(
            //       padding: EdgeInsets.only(top: hp.height / 25.6),
            //       child: const Text('Type/Mode',
            //           style:
            //               TextStyle(fontSize: 18, fontWeight: FontWeight.bold)))
            // ],
            ));
  }
}
