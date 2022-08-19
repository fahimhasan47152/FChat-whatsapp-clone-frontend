class ChatModel {
  int? id;
  String? name;
  String? icon;
  bool? isGroup;
  String? time;
  String? currentMessage;
  String? status;
  bool select = false;
  ChatModel(
      {this.id,
      this.currentMessage,
      this.icon,
      this.isGroup,
      this.name,
      this.time,
      this.status,
      this.select = false});
}
