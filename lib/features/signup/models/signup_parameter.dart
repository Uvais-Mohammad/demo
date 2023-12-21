class SignupParameter {
  SignupParameter({
    required this.password,
    required this.areaCode,
    required this.machineCode,
    required this.model,
    required this.osVersion,
    required this.serial,
    required this.messageCode,
    required this.imgCode,
    required this.telephone,
    required this.birthday,
    this.registerType = '1',
    this.isSmsRegister = '1',
    this.apiVersion = '1.0.0',
    this.countryId = '0',
    this.provinceId = '0',
    this.cityId = '0',
    this.areaId = '0',
    this.userType = '1',
  });
  final String userType;
  final String password;
  final int areaCode;
  final String birthday;
  final String countryId;
  final String provinceId;
  final String cityId;
  final String areaId;
  final String machineCode;
  final String isSmsRegister;
  final String apiVersion;
  final String model;
  final String osVersion;
  final String serial;
  final String messageCode;
  final String imgCode;
  final String registerType;
  final String telephone;
}
