class PostItUser {
  final String id;
  final String name;
  final String email;

  const PostItUser({
    required this.id,
    required this.name,
    required this.email,
  });
  // Método fromJson para converter um mapa JSON em um objeto PostItUser
  factory PostItUser.fromJson(Map<String, dynamic> json) {
    return PostItUser(
      id: json['id'],
      name: json['name'],
      email: json['email'],
    );
  }

  // Método toJson se precisar converter o objeto de volta para JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'email': email,
    };
  }
}
