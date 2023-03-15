class Scholarships {
  final String id;
  final String title;
  final String description;
  final String image;
  final String link;

  Scholarships(
      {required this.id,
      required this.title,
      required this.description,
      required this.image,
      required this.link});

  factory Scholarships.fromJson(Map<String, dynamic> json) {
    return Scholarships(
      id: json['id'] ?? json.hashCode.toString(),
      title: json['title'],
      description: json['description'],
      image: json['imageUrl'],
      link: json['link'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'imageUrl': image,
      'link': link,
    };
  }

  Scholarships copyWith({
    String? id,
    String? title,
    String? description,
    String? image,
    String? link,
  }) {
    return Scholarships(
      id: id ?? this.id,
      title: title ?? this.title,
      description: description ?? this.description,
      image: image ?? this.image,
      link: link ?? this.link,
    );
  }

  @override
  String toString() {
    return title;
  }
}
