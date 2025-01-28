class University {
  final String name;
  final String city;
  final String phoneNumber;
  final String image;
  final String description;
  final String universityNumber;
  final List<String> professions;

  University({
    required this.name,
    required this.city,
    required this.phoneNumber,
    required this.image,
    required this.description,
    required this.universityNumber,
    required this.professions,
  });

  factory University.fromJson(Map<String, dynamic> json) {
    return University(
      name: json['name'],
      city: json['city'],
      phoneNumber: json['phone_number'],
      image: json['photo'],
      description: json['desc'],
      universityNumber: json['university_number'],
      professions: (json['list_of_professions'] as String).split(', '),
    );
  }
} 