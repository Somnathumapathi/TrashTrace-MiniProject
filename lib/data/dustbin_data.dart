import 'models/dustbin.dart';

class DustbinData {
  static List<Dustbin> dustbins = [
    Dustbin(type: 'Biodegradable', latitude: 37.7749, longitude: -122.4194),
    Dustbin(type: 'Non Biodegradable', latitude: 37.7897, longitude: -122.4046),
    Dustbin(type: 'E-Waste', latitude: 12.9094857, longitude: 77.5648643),
    Dustbin(type: 'Hazardous', latitude: 12.9086014, longitude: 77.5649548),
    Dustbin(type: 'MAMT', latitude: 12.9107256, longitude: 77.5669876),
  ];
  static List<Dustbin> getDustbins() {
    return dustbins;
  }
}
