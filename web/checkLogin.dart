import 'dart:async';
import 'dart:html';
import 'dart:convert';

String path = "users.json";
bool loginStatus = false;

//String user = $_POST['username']; //I HATE YOU
//String pass = $_POST['password']; //YOU TOO

Future makeRequest() async {
  print("HELP");
  try {
    processString(await HttpRequest.getString(path), user, pass);
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

   print(loginStatus);
  return loginStatus;



}
