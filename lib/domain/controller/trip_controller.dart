import 'dart:convert';

import 'package:booking_app_cubit/config/constants/strings.dart';
import 'package:booking_app_cubit/config/networking/api_client.dart';
import 'package:booking_app_cubit/config/networking/base_response.dart';
import 'package:booking_app_cubit/config/networking/http_state.dart';
import 'package:booking_app_cubit/domain/repository/trip_repository.dart';

class TripController implements TripRepository {
  final ApiClient _client = ApiClient();
  final HttpState httpState;

  TripController(this.httpState);

  @override
  Future<BaseResponse> detailTrips(int id) async {
    String url = "${AppStrings.trip}/$id";
    String method = "GET";
    httpState.onStartRequest(url, method);

    late final BaseResponse baseResponse;
    final response = await _client.get(
      Uri.parse(url),
    );

    httpState.onEndRequest(url, method);
    if (response.statusCode < 500) {
      if (response.statusCode > 199 && response.statusCode < 300) {
        httpState.onSuccessRequest(url, method);
      } else {
        httpState.onErrorRequest(url, method);
      }
      baseResponse = BaseResponse.fromJson(jsonDecode(response.body));
    } else {
      baseResponse = BaseResponse(message: response.body);
    }
    return baseResponse;
  }

  @override
  Future<BaseResponse> getTrips() async {
    String url = AppStrings.trip;
    String method = "GET";
    httpState.onStartRequest(url, method);

    late final BaseResponse baseResponse;
    final response = await _client.get(
      Uri.parse(AppStrings.trip),
    );
    httpState.onEndRequest(url, method);
    if (response.statusCode < 500) {
      if (response.statusCode > 199 && response.statusCode < 300) {
        httpState.onSuccessRequest(url, method);
      } else {
        httpState.onErrorRequest(url, method);
      }
      baseResponse = BaseResponse.fromJson(jsonDecode(response.body));
    } else {
      baseResponse = BaseResponse(message: response.body);
    }
    return baseResponse;
  }
}
