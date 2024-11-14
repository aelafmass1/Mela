import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../core/utils/settings.dart';
import '../../data/models/transfer_fees_model.dart';
import '../../data/repository/wallet_repository.dart';

part 'check_details_event.dart';
part 'check_details_state.dart';

class CheckDetailsBloc extends Bloc<CheckDetailsEvent, CheckDetailsState> {
  final WalletRepository walletRepository;
  CheckDetailsBloc({required this.walletRepository})
      : super(CheckDetailsInitial()) {
    on<FetchTransferFeesEvent>(_onFetchTransferFees);
    on<CheckDetailsEvent>((event, emit) {});
  }

  Future<void> _onFetchTransferFees(
      FetchTransferFeesEvent event, Emitter<CheckDetailsState> emit) async {
    emit(CheckDetailsLoading());
    try {
      final accessToken = await getToken();
      final fees = await walletRepository.fetchTransferFees(
        accessToken: accessToken ?? '',
        fromWalletId: event.fromWalletId,
        toWalletId: event.toWalletId,
      );
      emit(CheckDetailsLoaded(fees: fees));
    } catch (e) {
      emit(CheckDetailsError(message: e.toString()));
    }
  }
}