import 'package:retrofit/error_logger.dart';
import 'package:retrofit/http.dart';
import 'package:test_for_max/network/anilibria/models/AnilibriaSchedule.dart';
import 'package:dio/dio.dart';

part 'AnilibriaService.g.dart';

@RestApi(baseUrl: "https://api.anilibria.tv/v3/")
abstract class AnilibriaService{
  factory AnilibriaService(Dio dio, {String baseUrl}) = _AnilibriaService;

  @GET('title/schedule')
  Future<List<AnilibriaSchedule>> getSchedule();
}