
class Model {
    String name;
    String address;
    int? id;

    Model({
        required this.name,
        required this.address,
       this.id,
    });

    factory Model.fromJson(Map<String, dynamic> json) => Model(
        name: json["name"],
        address: json["address"],
        id: json["id"],
    );

    Map<String, dynamic> toJson() => {
        "name": name,
        "address": address,
        "id": id,
    };
}