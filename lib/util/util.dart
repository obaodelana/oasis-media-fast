import 'package:parse_server_sdk_flutter/parse_server_sdk.dart';

class Util
{
  static String streakBox = "streak-box";
  static String streakCountField = "streaks";
  static String lastStreakField = "streak-date";

  static DateTime startDate = DateTime(2021, DateTime.december, 8);

  static Future<List<ParseObject>> getOnlineDB(String className) async
  {
    final ParseResponse apiResponse =
      await QueryBuilder<ParseObject>(ParseObject(className)).query();

    if (apiResponse.success && apiResponse.results != null)
      return apiResponse.results as List<ParseObject>;
    return [];
  }
}