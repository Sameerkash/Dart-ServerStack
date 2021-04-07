
/// extension method to check for bool
extension BoolParsing on String {
  bool parseBool() {
    return toLowerCase() == 'true';
  }
}
