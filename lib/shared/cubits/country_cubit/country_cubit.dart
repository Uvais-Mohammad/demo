// ignore_for_file: avoid_dynamic_calls

import 'dart:convert';

import 'package:equatable/equatable.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sf_chat_im/shared/enums/country_model.dart';

part 'country_state.dart';

class CountryCubit extends Cubit<List<CountryModel>> {
  CountryCubit() : super([]);

  Future<void> init() async {
    final jsonString = await rootBundle.loadString('assets/json/country.json');
    final jsonMap = json.decode(jsonString);
    final countryList = jsonMap['countries'] as List<dynamic>;
    final countryModelList = List<CountryModel>.from(
      countryList.map((e) => CountryModel.fromMap(e as Map<String, dynamic>)),
    )..sort((a, b) => a.enName.compareTo(b.enName));
    emit(countryModelList);
  }
}
