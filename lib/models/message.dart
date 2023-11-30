// To parse this JSON data, do
//
//     final message = messageFromJson(jsonString);

import 'dart:convert';

Message messageFromJson(String str) => Message.fromJson(json.decode(str));

String messageToJson(Message data) => json.encode(data.toJson());

class Message {
    String msg;
    String formd;
    String read;
    String told;
    Type type;
    String sent;

    Message({
        required this.msg,
        required this.formd,
        required this.read,
        required this.told,
        required this.type,
        required this.sent,
    });

    factory Message.fromJson(Map<String, dynamic> json) => Message(
        msg: json["msg"],
        formd: json["formd"],
        read: json["read"],
        told: json["told"],
        type: json["type"].toString() == Type.image.name? Type.image : Type.text,
        sent: json["sent"],
    );

    Map<String, dynamic> toJson() => {
        "msg": msg,
        "formd": formd,
        "read": read,
        "told": told,
        "type": type.name,
        "sent": sent,
    };
}


enum Type{text,image}