
import 'package:firebase_auth/firebase_auth.dart';
import 'package:path_provider/path_provider.dart';

class Authentication {
  static Authentication _authentication;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  factory Authentication() {
    if (_authentication == null) {
      _authentication = Authentication._internal();
    }
    return _authentication;
  }

  Authentication._internal();

  Future<String> login(String email, String password) async {
    final UserCredential result = await _auth.signInWithEmailAndPassword(
      email: email,
      password: password,
    );
    return result.user.email;
  }

  Future<String> register(String email, String password) async {
    final UserCredential result = await _auth.createUserWithEmailAndPassword(
      email: email,
      password: password,
    );
    return result.user.email;
  }

  Future<void> _deleteCacheDir() async {
    final cacheDir = await getTemporaryDirectory();

    if (cacheDir.existsSync()) {
      cacheDir.deleteSync(recursive: true);
    }
  }

  Future<void> _deleteAppDir() async {
    final appDir = await getApplicationSupportDirectory();

    if (appDir.existsSync()) {
      appDir.deleteSync(recursive: true);
    }
  }

  Future<void> logout() async {
    await _deleteCacheDir();
    await _deleteAppDir();
    return _auth.signOut();
  }

  Future<User> getLoggedUser() async {
    final User user = _auth.currentUser;
    if (user == null) return null;
    return user;
  }

  Future<void> changePassword(String password) async {
    User user = _auth.currentUser;
    user.updatePassword(password).then((_) async {
      print("Successfully changed password");
      await logout();
    }).catchError((error) {
      print("Password can't be changed" + error.toString());
    });
  }
}
