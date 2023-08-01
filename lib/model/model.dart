
class Model {
     String? name;
    String? address;
    int? id;

    Model({
        this.id,
        this.name,
         this.address,
    });

    factory Model.fromJson(Map<String, dynamic> json) => Model(
        id: json["id"],
        name: json["name"],
        address: json["address"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "address": address,
    };
}
