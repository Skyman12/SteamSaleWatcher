import 'dart:async';
import 'dart:html';
import 'dart:convert';

String path = "users.json";
bool loginStatus = false;

Future makeRequest(String name, String password) async {
  try {
    processString(await HttpRequest.getString(path), name, password);
  } catch (e) {
    print('Couldn\'t open $path');
  }
}

bool processString(String jsonString, String user, String pass) {
   Map jsondata = JSON.decode(jsonString);

  //Uhhhh
  for(int i = 0; i < jsondata.values.length; i++) {
    if (jsondata['username'] == user && jsondata['password'] == pass) {
      loginStatus = true;
    }
  }

  return loginStatus;



}
