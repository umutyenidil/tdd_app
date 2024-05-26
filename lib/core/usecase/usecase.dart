import 'package:tdd_app/core/utils/typedefs.dart';

abstract interface class Usecase<Type, Params>{
  ResultFuture<Type> call(Params params);
}