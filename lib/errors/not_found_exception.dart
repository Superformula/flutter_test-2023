import 'package:restaurantour/errors/general_exception.dart';

class NotFoundException extends GeneralException {
  NotFoundException({String? message}) : super(message: message);
}
