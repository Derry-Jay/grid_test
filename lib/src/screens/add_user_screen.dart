import '../backend/api.dart';
import '../helpers/helper.dart';
import 'package:flutter/material.dart';

import '../widgets/custom_button.dart';

class AddUserScreen extends StatefulWidget {
  const AddUserScreen({super.key});

  @override
  AddUserScreenState createState() => AddUserScreenState();
}

class AddUserScreenState extends State<AddUserScreen> {
  Map<String, dynamic> map = <String, dynamic>{};
  Helper get hp => Helper.of(context);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                          // final prefs = await sharedPrefs;
                          // fk.currentState?.save();
                          // log(map);
                          // final str = await sendData(map);
                          // final p = await revealToast(str);
                          // log(await prefs.setString('token', str) && p
                          //     ? str
                          //     : '');
                        },
                        child: Text(hp.loc.register),
                      )
                    ],
                  )))),
    );
  }
}
