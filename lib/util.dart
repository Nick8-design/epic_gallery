import 'dart:math';
import 'dart:io';

import 'package:flutter/foundation.dart';

int getRandomValue(int maxValue) {
  // if(maxValue<=8){
  //   return maxValue;
  // }
  // final random = Random();
  // return random.nextInt(maxValue );


  return maxValue;
}

bool isMobile() {
  if (kIsWeb) {
    return false;
  }
  return Platform.isAndroid || Platform.isIOS;
}


bool isDesktop() {
  if (kIsWeb) {
    return false;
  }
  return Platform.isWindows || Platform.isLinux || Platform.isMacOS;
}

bool isWeb() {
  return kIsWeb;
}