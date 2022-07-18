part of "crypto_bloc.dart";

enum Status { initial, loading, loaded, error }

class CryptoState extends Equatable {
  final List<CryptoCurrency> coins;
  final Status status;
  final DataError onError;

  const CryptoState({
    required this.coins,
    required this.status,
    required this.onError,
  });

  @override
  List<Object?> get props => [coins, status, onError];

  factory CryptoState.start() => const CryptoState(
      coins: [], status: Status.initial, onError: DataError());

  CryptoState copyWith({
    List<CryptoCurrency>? coins,
    Status? status,
    DataError? onError,
  }) {
    return CryptoState(
      coins: coins ?? this.coins,
      status: status ?? this.status,
      onError: onError ?? this.onError,
    );
  }
}
