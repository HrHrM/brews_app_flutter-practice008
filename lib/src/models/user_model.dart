class UserObject {
  final String? uid;

  UserObject({
    this.uid,
  });
}

class UserData {
  final String? uid;
  final String? name;
  final String? sugars;
  final int strength;

  UserData({
    this.uid,
    this.name,
    this.sugars,
    required this.strength,
  });
}
