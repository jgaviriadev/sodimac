String oneDecimal(String? s) {
  if (s == null) return '';
  final d = double.tryParse(s.replaceAll(',', '.'));
  if (d == null) return '';
  return d.toStringAsFixed(1);
}