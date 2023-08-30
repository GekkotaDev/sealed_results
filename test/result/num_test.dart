import "package:test/test.dart";
import "package:result_o3/result.dart";

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

// TODO: Write a better test.
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

  test("are equal", () {
    const x = Ok(42);
    const y = Ok(42);

    expect(x == y, true);
  });
}
