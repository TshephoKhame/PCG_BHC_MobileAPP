enum Environment { development, production }

class EnvironmentService {
  static const String kEnvDevelopment = 'Development';
  static const String kEnvProduction = 'Production';

  static const String awProjId = String.fromEnvironment('APPWRITE_PROJ_ID');
  static const String awEndpoint = String.fromEnvironment('APPWRITE_ENDPOINT');
  static const String awApiKey = String.fromEnvironment('APPWRITE_API_KEY');
  static const String baseUrl = String.fromEnvironment('BASE_URL');

  static const String environment = String.fromEnvironment(
    'ENVIRONMENT',
    defaultValue: kEnvDevelopment,
  );

  static Environment get currentEnvironment {
    switch (environment) {
      case kEnvDevelopment:
        return Environment.development;
      case kEnvProduction:
        return Environment.production;
      default:
        return Environment.development;
    }
  }
}
