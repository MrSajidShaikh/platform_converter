
class UserModal {
  late String name, phone, chatConversation, profile, date, time;
  int? id;

  UserModal({
    this.id,
    required this.name,
    required this.phone,
    required this.chatConversation,
    required this.profile,
    required this.date,
    required this.time,
  });

  factory UserModal.fromMap(Map m1) {
    return UserModal(
      id: m1['id'],
      name: m1['name'],
      phone: m1['phone'],
      chatConversation: m1['chatConversation'],
      profile: m1['profile'],
      date: m1['date'],
      time: m1['time'],
    );
  }
}

Map<String, dynamic> toMap(UserModal user) {
  return {
    'name': user.name,
    'phone': user.phone,
    'chatConversation': user.chatConversation,
    'profile': user.profile,
    'date': user.date,
    'time': user.time,
  };
}
