part of 'database.dart';

@DriftAccessor(tables: [ApiCredentials])
class ApiCredentialsDao extends DatabaseAccessor<AppDataStore> with _$ApiCredentialsDaoMixin {
  ApiCredentialsDao(AppDataStore db) : super(db);

  Future<ApiCredential> getApiCredential() async {
    return select(apiCredentials).getSingle();
  }

  Future<int> updateApiCredential(ApiCredentialsCompanion apiCredential) {
    return update(apiCredentials).write(apiCredential);
  }
}
