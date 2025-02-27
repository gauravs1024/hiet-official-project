import 'package:flutter/foundation.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class SessionManagement{
  final FlutterSecureStorage secureStorage=const FlutterSecureStorage();
  static const _nameKey = 'name';
  static const _userIdKey = 'userId';
  static const _userRoleKey = 'userRole';
  static const _isLoggedIn='isLoggedIn';

  Future<Map<String,String>>loadSessionData() async{
    try {
      String name=(await secureStorage.read(key:_nameKey ))!;
      String userId=(await secureStorage.read(key:_userIdKey ))!;
      String userRole=(await secureStorage.read(key:_userRoleKey ))!;
      String isLoggedIn=(await secureStorage.read(key:_isLoggedIn ))!;
    return {'userId': userId,
    'userRole': userRole,
    'isLoggedIn':isLoggedIn,
      'name':name
    } ;
    }

    catch(e){
      print("failed to load session $e");
    }

    return {'userId': 'NULL',
      'userRole': 'NULL',
      'isLoggedIn':'NULL',
      'name':'NULL'};
  }

  Future<String>loadSession() async{
    try {

      String isLoggedIn=(await secureStorage.read(key:_isLoggedIn ))!;
      return isLoggedIn;
    }

    catch(e){
      print("failed to load session $e");
    }

    return 'NULL';
  }


  Future<void> saveSession(String name,String userId,String userRole,String isLoggedIn)async {
  try {
    DateTime currentTimeDate = DateTime.now();
    await secureStorage.write(key: _nameKey, value: name);
    await secureStorage.write(key: _userIdKey, value: userId);
    await secureStorage.write(key: _userRoleKey, value: userRole);
    await secureStorage.write(key: _isLoggedIn, value: isLoggedIn);
  }
  catch (e) {
    if (kDebugMode) {
      print("Failed to save session");
    }
  }
}

  Future<void>clearSession()async{
    try{
      await secureStorage.delete(key: _nameKey,);
      await secureStorage.delete(key: _userIdKey);
      await secureStorage.delete(key:_userRoleKey );
      await secureStorage.delete(key:_isLoggedIn );

    }
    catch(e){
      if (kDebugMode) {
        print('failed to clear the session');
      }
    }


  }


}