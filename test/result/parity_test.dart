import "package:test/test.dart";
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

// TODO: Write a better test using this.
void main() {
  group("Integer number:", () {
    test("3.14", () {
      final validity = switch (parityOf(3.14)) {
        Err() => false,
        Ok() => true,
      };

      expect(validity, false);
    });

    test("42", () {
      final validity = switch (parityOf(42)) {
        Err() => false,
        Ok() => true,
      };

      expect(validity, true);
    });

    test("0", () {
      final validity = switch (parityOf(0)) {
        Err() => false,
        Ok() => true,
      };

      expect(validity, true);
    });
  });
}
