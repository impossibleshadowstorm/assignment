// class CategoriesModel {
//   bool? status;
//   Message? message;
//   Null? errorCode;
//   Null? errorMsg;
//   List<Data>? data;
//   Null? metaParams;
//   CategoriesModel(
//       {this.status,
//       this.message,
//       this.errorCode,
//       this.errorMsg,
//       this.data,
//       this.metaParams});
//   CategoriesModel.fromJson(Map<String, dynamic> json) {
//     status = json['status'];
//     message =
//         json['message'] != null ? Message.fromJson(json['message']) : null;
//     errorCode = json['error_code'];
//     errorMsg = json['error_msg'];
//     if (json['data'] != null) {
//       data = <Data>[];
//       json['data'].forEach((v) {
//         data!.add(Data.fromJson(v));
//       });
//     }
//     metaParams = json['meta_params'];
//   }
//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = Map<String, dynamic>();
//     data['status'] = status;
//     if (message != null) {
//       data['message'] = message!.toJson();
//     }
//     data['error_code'] = errorCode;
//     data['error_msg'] = errorMsg;
//     if (this.data != null) {
//       data['data'] = this.data!.map((v) => v.toJson()).toList();
//     }
//     data['meta_params'] = metaParams;
//     return data;
//   }
// }

// // class Message {
// //   String? eN;
// //   String? hI;

// //   Message({this.eN, this.hI});

// //   Message.fromJson(Map<String, dynamic> json) {
// //     eN = json['EN'];
// //     hI = json['HI'];
// //   }

// //   Map<String, dynamic> toJson() {
// //     final Map<String, dynamic> data = Map<String, dynamic>();
// //     data['EN'] = eN;
// //     data['HI'] = hI;
// //     return data;
// //   }
// // }

// class Data {
//   int? id;
//   Message? name;
//   String? icon;
//   Null? banner;
//   String? bgcolor;

//   Data({this.id, this.name, this.icon, this.banner, this.bgcolor});

//   Data.fromJson(Map<String, dynamic> json) {
//     id = json['id'];
//     name = json['name'] != null ? Message.fromJson(json['name']) : null;
//     icon = json['icon'];
//     banner = json['banner'];
//     bgcolor = json['bgcolor'];
//   }

//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = Map<String, dynamic>();
//     data['id'] = id;
//     if (name != null) {
//       data['name'] = name!.toJson();
//     }
//     data['icon'] = icon;
//     data['banner'] = banner;
//     data['bgcolor'] = bgcolor;
//     return data;
//   }
// }

class CategoriesModel {
  bool status;
  String errorCode;
  String errorMsg;
  String? meta_params;
  Message? message;
  List<Data>? data;

  CategoriesModel(this.status, this.errorCode, this.errorMsg, this.message,
      this.meta_params,
      [this.data]);

  factory CategoriesModel.fromJson(dynamic json) {
    if (json['data'] != null) {
      var dataObjsJson = json['data'] as List;
      List<Data> _datas =
          dataObjsJson.map((dataJson) => Data.fromJson(dataJson)).toList();
      return CategoriesModel(
        json['status'] as bool,
        json['error_code'] as String,
        json['error_msg'] as String,
        Message.fromJson(json['message']),
        json['meta_params'] as String,
        _datas,
      );
    } else {
      return CategoriesModel(
        json['status'] as bool,
        json['error_code'] as String,
        json['error_msg'] as String,
        Message.fromJson(json['message']),
        json['meta_params'],
      );
    }
  }
  @override
  String toString() {
    return '{ $status, $errorCode, $errorMsg, $message, $data }';
  }
}

class Name {
  String en;
  String hi;
  Name({required this.en, required this.hi});
  factory Name.fromJson(Map<String, dynamic> json) {
    return Name(
      en: json['EN'] as String,
      hi: json['HI'] as String,
    );
  }
  @override
  String toString() {
    return '{ $en, $hi }';
  }
}

class Data {
  String icon;
  String? banner;
  String bgcolor;
  int id;
  Name name;

  Data(
      {required this.icon,
      this.banner,
      required this.bgcolor,
      required this.id,
      required this.name});

  factory Data.fromJson(Map<String, dynamic> json) {
    return Data(
      icon: json['icon'] as String,
      banner: json['banner'] as String?,
      bgcolor: json['bgcolor'] as String,
      id: json['id'] as int,
      name: Name.fromJson(json["name"]),
    );
  }
  @override
  String toString() {
    return '{ $id, $name, $bgcolor }';
  }
}

class Message {
  String en;
  int hi;
  Message(this.en, this.hi);
  factory Message.fromJson(dynamic json) {
    return Message(json['name'] as String, json['age'] as int);
  }
  @override
  String toString() {
    return '{ $en, $hi }';
  }
}
