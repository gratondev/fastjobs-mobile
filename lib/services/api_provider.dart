import 'package:dio/dio.dart';
import 'package:fast_jobs/models/joke.dart';

class JokeServiceException implements Exception {}

class JokeService {
  JokeService({this.apiRoot = 'https://64e34aacbac46e480e788a2e.mockapi.io/'})
      : client = Dio(BaseOptions(baseUrl: apiRoot));

  final String apiRoot;
  final Dio client;
  int countInd = 1;

  Future<Joke> getRandomJoke() async {
    try {
      var response = await client.get('/api/jobs/$countInd');
      countInd = countInd + 1;
      return Joke.fromJson(response.data);
    } on DioError {
      countInd = 1;
      throw JokeServiceException();
    }
  }
}
