import '../helpers/helper.dart';

void pt() async{
  final prefs = await sharedPrefs;
  // log(prefs.containsKey('rememberme'));
  // log(prefs.containsKey('ruem'));
  // log(prefs.containsKey('rup'));
  log(prefs.containsKey('rememberme'));
  log(prefs.getBool('rememberme'));
  log(prefs.getKeys());
  log('anfdkjsnfsndf');
  log(prefs.containsKey('rememberme'));
  log(prefs.getBool('rememberme'));
  log('came here1');
  log(prefs.getString('ruem'));
  log(prefs.getString('rup'));
  log('came here2');
  log('anfdkjsnfsndf');
  log('afdsd2');
  //  else {
  //   // log(emailFlag);
  //   log('afdsd1');
  // }
  //  else {
  //   log(emc.text);
  //   log(pwc.text);
  //   log('fkjehdjd');
  // }
  // await prefs.setString('User', value.user.toString())
  //     ? hp.gotoForever('/mobile_home')
  //     : log('hi');
}


// void logout2() async {
//   final p = await revealDialogBox([
//     'No',
//     'Yes'
//   ], [
//     () {
//       goBack(result: false);
//       log('Error');
//     },
//     () async {
//       bool val = true;
//       final prefs = await sharedPrefs;
//       for (String key in prefs.getKeys()) {
//         val = val && (key == 'spDeviceToken' ? true : await prefs.remove(key));
//       }
//       currentUser.value = User.emptyUser;
//       location.value = PinCodeResult.emptyResult;
//       props.value = Property.emptyProperty;
//       docs.value = Document.emptyDocument;
//       notifyAll();
//       goBack(result: val);
//     }
//   ],
//       action: 'Are you sure to Logout?',
//       type: AlertType.cupertino,
//       dismissive: true);
//   log(p);
//   p ? gotoForever('/mobile_login') : goBack();
// }
