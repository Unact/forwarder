import 'dart:async';

import 'package:shared_preferences/shared_preferences.dart';

import 'package:forwarder/app/app.dart';
import 'package:forwarder/app/modules/api.dart';

class User {
  int id = kGuestId;
  String username = kGuestUsername;
  String password;
  String email = '';
  String salesmanName = '';
  String token;
  bool closed = false;

  static const int kGuestId = 1;
  static const String kGuestUsername = 'guest';

  User.init() {
    _currentUser = this;
    id = App.application.data.prefs.getInt('id');
    username = App.application.data.prefs.getString('username');
    password = App.application.data.prefs.getString('password');
    salesmanName = App.application.data.prefs.getString('salesmanName');
    email = App.application.data.prefs.getString('email');
    token = App.application.data.prefs.getString('token');
    closed = App.application.data.prefs.getBool('closed') ?? false;
  }

  static User _currentUser;
  static User get currentUser => _currentUser;

  Map<String, dynamic> toMap() {
    Map<String, dynamic> map = Map<String, dynamic>();
    map['id'] = id;
    map['username'] = username;
    map['password'] = password;
    map['salesman_name'] = salesmanName;
    map['email'] = email;
    map['token'] = token;
    map['closed'] = closed;

    return map;
  }

  bool isLogged() {
    return password != null;
  }

  Future<void> loadDataFromRemote() async {
    Map<String, dynamic> userData = await Api.get('v1/forwarder/user_info');

    id = userData['id'];
    email = userData['email'];
    salesmanName = userData['salesman_name'];
    closed = userData['closed'];
    await save();
  }

  Future<void> reset() async {
    id = kGuestId;
    username = kGuestUsername;
    password = null;
    email = '';
    salesmanName = null;
    token = null;
    closed = false;

    await save();
  }

  Future<void> reverseDay() async {
    await Api.post('v1/forwarder/close_day', body: {'closed': !closed});
    closed = !closed;

    await save();
  }

  Future<void> save() async {
    SharedPreferences prefs = App.application.data.prefs;

    await (id != null ? prefs.setInt('id', id) : prefs.remove('id'));
    await (username != null ? prefs.setString('username', username) : prefs.remove('username'));
    await (password != null ? prefs.setString('password', password) : prefs.remove('password'));
    await (email != null ? prefs.setString('email', email) : prefs.remove('email'));
    await (salesmanName != null ? prefs.setString('salesmanName', salesmanName) : prefs.remove('salesmanName'));
    await (token != null ? prefs.setString('token', token) : prefs.remove('token'));
    await (closed != null ? prefs.setBool('closed', closed) : prefs.remove('closed'));
  }
}
