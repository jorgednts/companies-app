extension StringExtensions on String? {
  bool isBlank() {
    if(this == null) {
      return true;
    } else {
     return this!.trim().isEmpty;
    }
  }
}
