import 'package:booking_app_cubit/config/networking/base_response.dart';

abstract class TripRepository {
  Future<BaseResponse> detailTrips(int id);

  Future<BaseResponse> getTrips();
}
