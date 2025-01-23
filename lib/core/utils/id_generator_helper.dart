class IdGeneratorHelper {
  static String generateAUniqID() {
    final now = DateTime.now();
    return now.microsecondsSinceEpoch.toString() + now.hashCode.toString();
  }
}
