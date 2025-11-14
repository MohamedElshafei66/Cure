import '../../../../core/errors/exceptions.dart';
import '../../../../core/network/api_services.dart';
import '../models/booking_search_model.dart';
import 'package:dio/dio.dart';

abstract class BookingSearchRemoteDataSource {
  Future<List<BookingSearchModel>> searchBookings(String fromDate);
  Future<BookingSearchModel> cancelBooking(String bookingId);
  Future<BookingSearchModel> rescheduleBooking(String bookingId, String newDateTime);
}

class BookingSearchRemoteDataSourceImpl implements BookingSearchRemoteDataSource {
  final ApiServices apiServices;

  BookingSearchRemoteDataSourceImpl({required this.apiServices});

  @override
  Future<List<BookingSearchModel>> searchBookings(String fromDate) async {
    try {
      final endpoint = 'Customer/Booking/BookingSearch?FromDate=$fromDate';
      
      print('========================================');
      print('BOOKING SEARCH DATA SOURCE: GET REQUEST');
      print('========================================');
      print('Endpoint: $endpoint');
      print('FromDate: $fromDate');
      print('========================================');
      
      final response = await apiServices.get(endPoint: endpoint);

      print('========================================');
      print('BOOKING SEARCH DATA SOURCE: RESPONSE');
      print('========================================');
      print('Response: $response');
      print('========================================');

      if (response is Map<String, dynamic>) {
        final success = response['success'] ?? false;
        if (success) {
          final data = response['data'] as List<dynamic>?;
          if (data != null) {
            return data
                .map((json) => BookingSearchModel.fromJson(json as Map<String, dynamic>))
                .toList();
          } else {
            return [];
          }
        } else {
          final message = response['message'] ?? 'Failed to fetch bookings';
          throw ServerException(message);
        }
      }
      
      throw ServerException('Invalid response format');
    } on DioException catch (e) {
      print('========================================');
      print('BOOKING SEARCH DATA SOURCE: ERROR');
      print('========================================');
      print('Error: ${e.message}');
      print('Response: ${e.response?.data}');
      print('========================================');
      throw ServerException.fromDioError(e);
    } catch (e) {
      print('========================================');
      print('BOOKING SEARCH DATA SOURCE: UNEXPECTED ERROR');
      print('========================================');
      print('Error: $e');
      print('========================================');
      throw ServerException(e.toString());
    }
  }

  @override
  Future<BookingSearchModel> cancelBooking(String bookingId) async {
    try {
      final endpoint = 'Customer/Booking/CancelBooking/$bookingId';
      
      print('========================================');
      print('CANCEL BOOKING DATA SOURCE: PUT REQUEST');
      print('========================================');
      print('Endpoint: $endpoint');
      print('BookingId: $bookingId');
      print('========================================');
      
      final response = await apiServices.put(endPoint: endpoint);

      print('========================================');
      print('CANCEL BOOKING DATA SOURCE: RESPONSE');
      print('========================================');
      print('Response: $response');
      print('========================================');

      if (response is Map<String, dynamic>) {
        final success = response['success'] ?? false;
        if (success) {
          final data = response['data'] as Map<String, dynamic>?;
          if (data != null) {
            return BookingSearchModel.fromJson(data);
          } else {
            throw ServerException('No data in response');
          }
        } else {
          final message = response['message'] ?? 'Failed to cancel booking';
          throw ServerException(message);
        }
      }
      
      throw ServerException('Invalid response format');
    } on DioException catch (e) {
      print('========================================');
      print('CANCEL BOOKING DATA SOURCE: ERROR');
      print('========================================');
      print('Error: ${e.message}');
      print('Response: ${e.response?.data}');
      print('========================================');
      throw ServerException.fromDioError(e);
    } catch (e) {
      print('========================================');
      print('CANCEL BOOKING DATA SOURCE: UNEXPECTED ERROR');
      print('========================================');
      print('Error: $e');
      print('========================================');
      throw ServerException(e.toString());
    }
  }

  @override
  Future<BookingSearchModel> rescheduleBooking(String bookingId, String newDateTime) async {
    try {
      final endpoint = 'Customer/Booking/RescheduleBooking/$bookingId';
      
      print('========================================');
      print('RESCHEDULE BOOKING DATA SOURCE: PUT REQUEST');
      print('========================================');
      print('Endpoint: $endpoint');
      print('BookingId: $bookingId');
      print('NewDateTime: $newDateTime');
      print('========================================');
      
      // The API expects the body to be a JSON string with the date
      final response = await apiServices.put(
        endPoint: endpoint,
        body: newDateTime, // The API expects just the date string as body
      );

      print('========================================');
      print('RESCHEDULE BOOKING DATA SOURCE: RESPONSE');
      print('========================================');
      print('Response: $response');
      print('========================================');

      if (response is Map<String, dynamic>) {
        final success = response['success'] ?? false;
        if (success) {
          final data = response['data'] as Map<String, dynamic>?;
          if (data != null) {
            return BookingSearchModel.fromJson(data);
          } else {
            throw ServerException('No data in response');
          }
        } else {
          final message = response['message'] ?? 'Failed to reschedule booking';
          throw ServerException(message);
        }
      }
      
      throw ServerException('Invalid response format');
    } on DioException catch (e) {
      print('========================================');
      print('RESCHEDULE BOOKING DATA SOURCE: ERROR');
      print('========================================');
      print('Error: ${e.message}');
      print('Response: ${e.response?.data}');
      print('========================================');
      throw ServerException.fromDioError(e);
    } catch (e) {
      print('========================================');
      print('RESCHEDULE BOOKING DATA SOURCE: UNEXPECTED ERROR');
      print('========================================');
      print('Error: $e');
      print('========================================');
      throw ServerException(e.toString());
    }
  }
}

