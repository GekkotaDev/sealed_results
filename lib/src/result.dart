/// A callback function to handle the result.
typedef ResultCallback<T> = void Function(T value);

/// A callback function to handle errors within the application.
typedef ErrorHandler<T, E extends Object> = T Function(E error);

/// A wrapper type that may either be an error or a value.
///
/// The [Result] type represents a value that is either [Ok] to use or is an
/// [Err] and should be handled. This should be preferred over try catch as it
/// forces developers handle all possible states of the result through pattern
/// matching.
sealed class Result<T, E extends Object> {
  /// Instantiate an [Ok] type.
  factory Result.ok(T value) => Ok(value);

  /// Instantiate an [Err]or type.
  factory Result.err(E error) => Err(error);

  /// True if the [Result] is [Ok]; false otherwise.
  static late bool isOk;

  /// True if the [Result] is [Err]; false otherwise.
  static late bool isErr;

  /// A direct handle to the value or error.
  ///
  /// It is not recommended that this shuold be used without pattern matching.
  call();

  /// Run the [callback] if the [Result] is [Ok].
  ///
  /// It is recommended to run this method with Dart's method cascading syntax.
  void ifOk(ResultCallback<T> callback);

  /// Run the [callback] if the [Result] is [Err].
  ///
  /// It is recommended to run this method with Dart's method cascading syntax.
  void ifErr(ResultCallback<E> callback);

  /// Unwrap the [Result] and either return the value if [Ok] or panic if it is
  /// [Err].
  ///
  /// It is recommended that this should be called within a pattern matching
  /// expression or statement to avoid implicit panics, and to handle all
  /// possible states of the result.
  T unwrap();

  /// Unwrap the [Result] and return the value if [Ok], otherwise [then] return
  /// a default value.
  T unwrapUnlessErr({required T then});

  /// Unwrap the [Result] and return the value if [Ok], otherwise let the [Err]
  /// be [handledBy] a callback function that computes the default value of the
  /// failed [Result].
  T unwrapWithErr({required ErrorHandler<T, E> handledBy});
}

/// Wrapper type indicating the value is [Ok].
final class Ok<T, E extends Object> implements Result<T, E> {
  /// Guaranteed to be true.
  static const isOk = true;

  /// Guaranteed to be false.
  static const isErr = false;

  /// A type safe handle to the value of the result.
  final T value;

  /// Provide the value.
  const Ok(this.value);

  @override
  T call() => value;

  @override
  ifOk(callback) => callback(value);

  @override
  ifErr(callback) {}

  @override
  unwrap() => value;

  @override
  unwrapUnlessErr({required then}) => value;

  @override
  unwrapWithErr({required handledBy}) => value;
}

/// Wrapper type indicating the value is an [Err]or or exception.
final class Err<T, E extends Object> implements Result<T, E> {
  /// Guaranteed to be false.
  static const isOk = false;

  /// Guaranteed to be true.
  static const isErr = true;

  /// A type safe handle to the error of the result.
  final E error;

  /// Provide an error.
  const Err(this.error);

  @override
  E call() => error;

  @override
  ifOk(callback) {}

  @override
  ifErr(callback) => callback(error);

  @override
  unwrap() => throw error;

  @override
  unwrapUnlessErr({required then}) => then;

  @override
  unwrapWithErr({required handledBy}) => handledBy(error);
}
