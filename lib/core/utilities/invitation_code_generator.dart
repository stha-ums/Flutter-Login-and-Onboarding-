

import 'dart:math';

class InvitationCode {
  static int invitationCode;

  int generate(){
    int max = 999999;
    int min = 100000;
    Random rnd = new Random();
    int code = min + rnd.nextInt(max - min);
    print(code);
    return code;
  }
}