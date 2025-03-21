// import 'package:dio/dio.dart';
// import 'package:flutter_commons/flutter_commons.dart';
// import 'package:mk/helpers/country_code.dart';
// import 'package:mk/models/countries_model.dart';
// import 'package:mk/repositories/base_api_mixin.dart';
//
// class IpRepository with BaseApi, Logging {
//   Future checkIp() async {
//     String resultingNk = appStorage.workCountry.cachedValue;
//     if (resultingNk.isEmpty) {
//       try {
//         var result = await executor.get('http://ip-api.com/json', options: Options(receiveTimeout: 3.seconds));
//         var userCountry = (result.data['countryCode']?.toString() ?? '').toLowerCase();
//         warn('User country = $userCountry');
//
//         resultingNk = allowedCountriesForNk.contains(userCountry) ? userCountry : oksmRuCode;
//         warn('Resulting NK = $resultingNk');
//       } catch (ex) {
//         warn(ex);
//         resultingNk = 'ru';
//         warn('Error getting user country > defaulting nk to "RU"');
//       }
//
//       await appStorage.workCountry.setValue(resultingNk);
//     }
//
//     return resultingNk;
//   }
// }
