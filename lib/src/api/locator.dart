import 'package:get_it/get_it.dart';
import 'package:selfradio/src/api/song_service.dart';

final serviceLocator = GetIt.instance;

void setup() {
  serviceLocator.registerSingleton<SongService>(SongService());
}