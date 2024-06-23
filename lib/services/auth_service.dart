import 'package:appwrite/models.dart';
import 'package:bhc_mobile/app/app.locator.dart';
import 'package:bhc_mobile/app/app.logger.dart';
import 'package:bhc_mobile/services/appwrite_service.dart';
import 'package:bhc_mobile/services/http_service.dart';
import 'package:bhc_mobile/services/local_database_service.dart';
import 'package:bhc_mobile/ui/common/ui_helpers.dart';
import 'package:stacked/stacked.dart';

class AuthService with ListenableServiceMixin {
  final _logger = getLogger('AuthService');
  final _httpSvc = locator<HttpService>();
  final _appwriteSvc = locator<AppwriteService>();
  final _dbService = locator<LocalDatabaseService>();

  bool _authenticated = false;
  bool get authenticated => _authenticated;

  String? _userId;
  String get userId => _userId ?? "";

  Future<Map<String, dynamic>> login(
      {required String e, required String p}) async {
    String message = "";
    await _httpSvc.login(email: e, password: p).then((res) async {
      _logger.d(prettyJSON(res));
      _authenticated = res['success'];
      message = res['message'];
      if (_authenticated) {
        _userId = res['userId'];
        Preferences prefs = await _appwriteSvc.account.getPrefs();
        _logger.d('User flags: ${prettyJSON(prefs.data)}');

        bool profileCreated = prefs.data['profileCreated'] ?? false;
        bool isTenant = prefs.data['isTenant'] ?? false;

        //save flags in local DB for access in other app areas
        await _dbService.save(key: 'userId', value: _userId, log: true);
        await _dbService.save(
            key: 'profileCreated', value: profileCreated, log: true);
        await _dbService.save(key: 'isTenant', value: isTenant, log: true);

        _logger.d('Logged in $_userId');
      }
      notifyListeners();
    });
    return {'success': _authenticated, 'message': message};
  }

  logout() async => await _appwriteSvc.account
          .deleteSession(sessionId: 'current')
          .then((_) async {
        await _dbService.cleanDb();
        _logger.d('Logged out $_userId');
        _userId = null;
      });
}
