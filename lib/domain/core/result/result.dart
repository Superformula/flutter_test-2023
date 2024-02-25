import 'package:fpdart/fpdart.dart';

typedef Result<L, S> = Either<L, S>;

extension ResultExtension<L, R> on Either<L, R> {
  bool get isSuccess => isRight();

  bool get isError => isLeft();

  R? get success => getRight().fold(() => null, (t) => t);

  L? get error => getLeft().fold(() => null, (t) => t);

  C when<C>({
    required C Function(L l) error,
    required C Function(R r) success,
  }) =>
      fold<C>(error, success);
}

/// Base class for representing success actions.
/// It's just a wrapper for [Right] class from `fpDart` library
///
/// Use the [success] method instead if you don't feel sure about how to use it.
class Success<L, R> extends Right<L, R> {
  const Success(super.value);
}

/// Base class for representing error actions.
/// It's just a wrapper for [Left] class from `fpDart` library
///
/// Use the [error] method instead if you don't feel sure about how to use it.
class Error<L, R> extends Left<L, R> {
  const Error(super.value);
}

/// Creates a [Success] instance easily with [value] of type [R]
Result<L, R> success<L, R>(R value) => Success(value);

/// Creates an [Error] instance easily with [value] being [L] subtype.
Result<L, R> error<L, R>(L value) => Error(value);
