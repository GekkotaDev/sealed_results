// TODO: Write better example.
import "package:sealed_result/result.dart";

enum Parity {
  even,
  odd,
}

Result<Parity, Error> parityOf(num number) => switch (number) {
      double() => Err(Error()),
      int() => switch (number % 2 == 0) {
          true => Ok(Parity.even),
          false => Ok(Parity.odd),
        }
    };

final isInt = switch (parityOf(3.14)) {
  Err() => false,
  Ok() => true,
};
