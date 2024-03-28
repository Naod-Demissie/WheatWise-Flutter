class ImageNotLeaf implements Exception {
  final String message;

  ImageNotLeaf(this.message);

  @override
  String toString() {
    return 'image provided is not leaf: $message';
  }
}

class NoInternet implements Exception {
  final String message;

  NoInternet({required this.message});

  @override
  String toString() {
    return 'no internet: $message';
  }
}
