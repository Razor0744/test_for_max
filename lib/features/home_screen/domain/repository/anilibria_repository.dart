import 'package:test_for_max/features/home_screen/domain/models/anime_series.dart';

abstract class AnilibriaRepository {

  Future<List<AnimeSeries>> getAnimeSeriesList();
}