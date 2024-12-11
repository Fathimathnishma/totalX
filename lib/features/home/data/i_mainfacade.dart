import 'package:dartz/dartz.dart';
import 'package:totalxtestapp/features/home/data/model/user_model.dart';
import 'package:totalxtestapp/general/failures/failures.dart';

abstract class  IMainfacade{
  Future<Either<MainFailures,String>> addUsers({required Usermodel usermodel}){
    throw UnimplementedError("no implementation");
  }
  Future<Either<MainFailures,List<Usermodel>>> fetchData({int? selectAge, String? search}){
    throw UnimplementedError("no implementation");
  }
void clearData();

 }