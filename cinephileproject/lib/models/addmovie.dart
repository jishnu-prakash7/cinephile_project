import 'package:hive/hive.dart';

part 'addmovie.g.dart';

@HiveType(typeId: 0)
class Addmovie extends HiveObject{

  @HiveField(0)
  final String movieTitle;

  @HiveField(1)
  final int year;

  @HiveField(2)
  final String language;

  @HiveField(3)
  final int runtime;

  @HiveField(4)
  final String director;

  @HiveField(5)
  final String rating;

  @HiveField(6)
  final String genre;

  @HiveField(7)
  final String review;

  Addmovie(
      {required this.movieTitle,
      required this.year,
      required this.language,
      required this.runtime,
      required this.director,
      required this.rating,
      required this.genre,
      required this.review});
}
