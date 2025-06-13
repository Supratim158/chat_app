class ChatModel {
  String? name;
  String? icon;
  bool? isGroup;
  String? time;
  String? currentMessage;
  String? status;
  bool? select = false;
  int? id;

  ChatModel({
    this.name,
    this.icon,
    this.isGroup,
    this.currentMessage,
    this.time,
    this.status,
    this.select = false,
    this.id,
  });
}