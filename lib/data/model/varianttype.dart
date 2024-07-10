class VariantType {
  String? id;
  String? title;
  String? name;
  VariantTypeEnum? type;
  VariantType(this.id,this.title,this.name,this.type);
   factory VariantType.fromJson(Map<String, dynamic> jsonObject) {
    return VariantType(
        jsonObject['id'],
        jsonObject['title'],
        jsonObject['name'],
        _getTypeEnum(jsonObject['type']),
       );
  }
}
VariantTypeEnum _getTypeEnum(String type) {
  switch (type) {
    case 'Color':
      return VariantTypeEnum.COLOR;
    case 'Storage':
      return VariantTypeEnum.STORAGE;
    case 'Voltage':
      return VariantTypeEnum.VOLTAGE;
    default:
      return VariantTypeEnum.COLOR;
  }
}

// ignore: constant_identifier_names
enum VariantTypeEnum { COLOR, STORAGE, VOLTAGE }
