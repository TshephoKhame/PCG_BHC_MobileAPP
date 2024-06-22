import 'package:appwrite/models.dart';
import 'package:bhc_mobile/app/app.locator.dart';
import 'package:bhc_mobile/app/app.logger.dart';
import 'package:bhc_mobile/services/appwrite_service.dart';
import 'package:bhc_mobile/services/environment_service.dart';
import 'package:bhc_mobile/services/http_service.dart';
import 'package:bhc_mobile/ui/common/ui_helpers.dart';
import 'package:stacked/stacked.dart';

class AuthService with ListenableServiceMixin {
  final _logger = getLogger('AuthService');
  final _httpSvc = locator<HttpService>();
  final _appwriteSvc = locator<AppwriteService>();

  bool _authenticated = false;
  bool get authenticated => _authenticated;

  login({required String e, required String p}) async {
    await _httpSvc.login(email: e, password: p).then((res) {
      _logger.d(prettyJSON(res));
      _authenticated = res['success'];
      notifyListeners();
    });
  }

  logout() async =>
      await _appwriteSvc.account.deleteSession(sessionId: 'current');
}
