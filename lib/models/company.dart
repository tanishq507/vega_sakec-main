class Company {
  String title;
  String tags;
  String description;
  String websiteName;

  Company({
    required this.title,
    required this.tags,
    required this.description,
    required this.websiteName,
  });

  Company.fromJson(Map<String, dynamic> json)
      : title = json['title'] as String,
        tags = json['tags'] as String,
        description = json['description'] as String,
        websiteName = json['websiteName'] as String;

  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'tags': tags,
      'description': description,
      'websiteName': websiteName,
    };
  }

  Company copyWith({
    String? title,
    String? tags,
    String? description,
    String? websiteName,
  }) {
    return Company(
      title: title ?? this.title,
      tags: tags ?? this.tags,
      description: description ?? this.description,
      websiteName: websiteName ?? this.websiteName,
    );
  }
}
