import 'package:mind_track/features/coach/data/datasources/coach_remote_datasource.dart';
import 'package:mind_track/features/coach/domain/entities/coach_response.dart';
import 'package:mind_track/features/coach/domain/repositories/coach_repository.dart';

class CoachRepositoryImpl implements CoachRepository {
  const CoachRepositoryImpl(this._remoteDataSource);

  final CoachRemoteDataSource _remoteDataSource;

  @override
  Future<CoachResponse> fetchCoachResponse() {
    return _remoteDataSource.fetchCoachResponse();
  }

  @override
  Future<String> sendChatMessage({
    required String message,
    required List<CoachChatMessage> history,
  }) {
    return _remoteDataSource.sendChatMessage(
      message: message,
      history: history,
    );
  }
}
