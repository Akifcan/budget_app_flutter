import 'package:budget/core/navigator_service.dart';
import 'package:budget/db/provider/header_provider.dart';
// ignore: implementation_imports
import 'package:provider/src/provider.dart';

amountValidation(String val) {
  if (val.isEmpty) {
    return 'Lütfen bu alanı boş bırakmayın';
  }
  if (double.parse(val) <= 0) {
    return "Lütfen 0'ın üstünde bir değer girin";
  }
  if (double.parse(val) >
      NavigationService.navigatorKey.currentContext!
          .read<HeaderProvider>()
          .headerInformations
          .current) {
    return "Bu miktar belirlediğiniz limitten fazla";
  }
  return null;
}
