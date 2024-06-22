import 'package:appwrite/appwrite.dart';
import 'package:bhc_mobile/services/environment_service.dart';

import '../app/app.logger.dart';

class AppwriteService {
  final _projectId = EnvironmentService.awProjId;
  final _endpoint = EnvironmentService.awEndpoint;
  late Client _client;
  late Account account;
  late Realtime realtime;

  AppwriteService(){
    _client = Client()
      ..setProject(_projectId)
      ..setEndpoint(_endpoint)
      ..setSelfSigned();

    account = Account(_client);
    realtime = Realtime(_client);
  }

}
