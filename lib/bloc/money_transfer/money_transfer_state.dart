part of 'money_transfer_bloc.dart';

sealed class MoneyTransferState {}

final class MoneyTransferInitial extends MoneyTransferState {}

final class MoneyTransferLoading extends MoneyTransferState {}

final class MoneyTransferFail extends MoneyTransferState {
  final String reason;

  MoneyTransferFail({required this.reason});
}

final class MoneyTransferSuccess extends MoneyTransferState {}
