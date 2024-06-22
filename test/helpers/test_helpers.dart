import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:bhc_mobile/app/app.locator.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:bhc_mobile/services/local_database_service.dart';
import 'package:bhc_mobile/services/http_service.dart';

import 'package:bhc_mobile/services/http_service.dart';

import 'test_helpers.mocks.dart';
import 'package:bhc_mobile/services/feedback_service.dart';
import 'package:bhc_mobile/services/environment_service.dart';
import 'package:bhc_mobile/services/auth_service.dart';
import 'package:bhc_mobile/services/appwrite_service.dart';
// @stacked-import

@GenerateMocks([], customMocks: [
  MockSpec<NavigationService>(onMissingStub: OnMissingStub.returnDefault),
  MockSpec<BottomSheetService>(onMissingStub: OnMissingStub.returnDefault),
  MockSpec<DialogService>(onMissingStub: OnMissingStub.returnDefault),
  MockSpec<LocalDatabaseService>(onMissingStub: OnMissingStub.returnDefault),
  MockSpec<HttpService>(onMissingStub: OnMissingStub.returnDefault),
  MockSpec<FeedbackService>(onMissingStub: OnMissingStub.returnDefault),
  MockSpec<EnvironmentService>(onMissingStub: OnMissingStub.returnDefault),
  MockSpec<AuthService>(onMissingStub: OnMissingStub.returnDefault),
  MockSpec<AppwriteService>(onMissingStub: OnMissingStub.returnDefault),
// @stacked-mock-spec
])
void registerServices() {
  getAndRegisterNavigationService();
  getAndRegisterBottomSheetService();
  getAndRegisterDialogService();
  getAndRegisterLocalDatabaseService();
  getAndRegisterHttpService();
  getAndRegisterHttpService();
  getAndRegisterFeedbackService();
  getAndRegisterEnvironmentService();
  getAndRegisterAuthService();
  getAndRegisterAppwriteService();
// @stacked-mock-register
}

MockNavigationService getAndRegisterNavigationService() {
  _removeRegistrationIfExists<NavigationService>();
  final service = MockNavigationService();
  locator.registerSingleton<NavigationService>(service);
  return service;
}

MockBottomSheetService getAndRegisterBottomSheetService<T>({
  SheetResponse<T>? showCustomSheetResponse,
}) {
  _removeRegistrationIfExists<BottomSheetService>();
  final service = MockBottomSheetService();

  when(service.showCustomSheet<T, T>(
    enableDrag: anyNamed('enableDrag'),
    enterBottomSheetDuration: anyNamed('enterBottomSheetDuration'),
    exitBottomSheetDuration: anyNamed('exitBottomSheetDuration'),
    ignoreSafeArea: anyNamed('ignoreSafeArea'),
    isScrollControlled: anyNamed('isScrollControlled'),
    barrierDismissible: anyNamed('barrierDismissible'),
    additionalButtonTitle: anyNamed('additionalButtonTitle'),
    variant: anyNamed('variant'),
    title: anyNamed('title'),
    hasImage: anyNamed('hasImage'),
    imageUrl: anyNamed('imageUrl'),
    showIconInMainButton: anyNamed('showIconInMainButton'),
    mainButtonTitle: anyNamed('mainButtonTitle'),
    showIconInSecondaryButton: anyNamed('showIconInSecondaryButton'),
    secondaryButtonTitle: anyNamed('secondaryButtonTitle'),
    showIconInAdditionalButton: anyNamed('showIconInAdditionalButton'),
    takesInput: anyNamed('takesInput'),
    barrierColor: anyNamed('barrierColor'),
    barrierLabel: anyNamed('barrierLabel'),
    customData: anyNamed('customData'),
    data: anyNamed('data'),
    description: anyNamed('description'),
  )).thenAnswer((realInvocation) =>
      Future.value(showCustomSheetResponse ?? SheetResponse<T>()));

  locator.registerSingleton<BottomSheetService>(service);
  return service;
}

MockDialogService getAndRegisterDialogService() {
  _removeRegistrationIfExists<DialogService>();
  final service = MockDialogService();
  locator.registerSingleton<DialogService>(service);
  return service;
}

MockLocalDatabaseService getAndRegisterLocalDatabaseService() {
  _removeRegistrationIfExists<LocalDatabaseService>();
  final service = MockLocalDatabaseService();
  locator.registerSingleton<LocalDatabaseService>(service);
  return service;
}

MockHttpService getAndRegisterHttpService() {
  _removeRegistrationIfExists<HttpService>();
  final service = MockHttpService();
  locator.registerSingleton<HttpService>(service);
  return service;
}

MockFeedbackService getAndRegisterFeedbackService() {
  _removeRegistrationIfExists<FeedbackService>();
  final service = MockFeedbackService();
  locator.registerSingleton<FeedbackService>(service);
  return service;
}

MockEnvironmentService getAndRegisterEnvironmentService() {
  _removeRegistrationIfExists<EnvironmentService>();
  final service = MockEnvironmentService();
  locator.registerSingleton<EnvironmentService>(service);
  return service;
}

MockAuthService getAndRegisterAuthService() {
  _removeRegistrationIfExists<AuthService>();
  final service = MockAuthService();
  locator.registerSingleton<AuthService>(service);
  return service;
}

MockAppwriteService getAndRegisterAppwriteService() {
  _removeRegistrationIfExists<AppwriteService>();
  final service = MockAppwriteService();
  locator.registerSingleton<AppwriteService>(service);
  return service;
}
// @stacked-mock-create

void _removeRegistrationIfExists<T extends Object>() {
  if (locator.isRegistered<T>()) {
    locator.unregister<T>();
  }
}
