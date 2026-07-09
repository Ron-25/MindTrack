import 'package:mind_track/features/coach/domain/entities/coach_response.dart';

abstract class CoachRepository {
  Future<CoachResponse> fetchCoachResponse();
}
