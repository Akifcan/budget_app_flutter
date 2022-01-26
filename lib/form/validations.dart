amountValidation(String val) {
  if (val.isEmpty) {
    return 'Lütfen bu alanı boş bırakmayın';
  }
  if (double.parse(val) < 0) {
    return "Lütfen 0'ın üstünde bir değer girin";
  }
  return null;
}
