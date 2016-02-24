// Copyright (c) 2016, <your name>. All rights reserved. Use of this source code
// is governed by a BSD-style license that can be found in the LICENSE file.

import 'dart:html';
import 'SteamSaleServer.dart';

void main() {
  querySelector('#output').text = 'Your Dart app is running.';
  SteamSaleServer steamSaleServer = new SteamSaleServer();
  steamSaleServer.getSteamAppIDs();
}
