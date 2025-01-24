class Images {
  final List<String> source;

  const Images({this.source = const []});

  factory Images.fromMap(Map<String, dynamic> data) {
    return Images(
      source: List<String>.from(data['source'] ?? []),
    );
  }
}