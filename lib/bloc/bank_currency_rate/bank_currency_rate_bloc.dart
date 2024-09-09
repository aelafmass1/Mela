import 'dart:developer';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:transaction_mobile_app/data/models/bank_rate.dart';
import 'package:transaction_mobile_app/data/repository/currency_rate_repository.dart';

import '../../core/utils/settings.dart';

part 'bank_currency_rate_event.dart';
part 'bank_currency_rate_state.dart';

class BankCurrencyRateBloc
    extends Bloc<BankCurrencyRateEvent, BankCurrencyRateState> {
  BankCurrencyRateBloc() : super(BankCurrencyRateInitial()) {
    on<FetchCurrencyRate>(_onFetchCurrencyRate);
  }
  _onFetchCurrencyRate(
      FetchCurrencyRate event, Emitter<BankCurrencyRateState> emit) async {
    try {
      final token = await getToken();

      if (token != null) {
        emit(BankCurrencyRateLoading());
        final res = await CurrencyRateRepository.fetchCurrencyRate(token);
        final rates = res.map((rate) => BankRate.fromMap(rate)).toList();
        emit(BankCurrencyRateSuccess(rates: rates));
      }
    } catch (error) {
      log(error.toString());
      emit(BankCurrencyRateFail(reason: error.toString()));
    }
  }
}
