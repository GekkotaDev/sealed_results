import "package:result_o3/result.dart";
import "package:test/test.dart";

void main() {
  group("Result may be Ok and", () {
    const Result<int, Error> result = Ok(42);

    test("is accessed", () => expect(result(), 42));

    test("is unwrapped", () => expect(result.unwrap(), 42));

    test("is unwrapped unless error then defaulted",
        () => expect(result.unwrapUnlessErr(then: 32), 42));

    test("is unwrapped with error handled",
        () => expect(result.unwrapWithErr(handledBy: (_) => 32), 42));

    test("if Ok, update local variable", () {
      bool output = true;

      result
        ..ifOk((_) => output = true)
        ..ifErr((_) => output = false);

      expect(output, true);
    });
  });

  group("Result may be Err and", () {
    final Result<int, Exception> result = Err(Exception());

    test("is accessed", () => expect(result() is Exception, true));

    test("is unwrapped", () {
      try {
        result.unwrap();
      } catch (e) {
        expect(e is Exception, true);
      }
    });

    test("is unwrapped unless error then defaulted",
        () => expect(result.unwrapUnlessErr(then: 32), 32));

    test("is unwrapped with error handled",
        () => expect(result.unwrapWithErr(handledBy: (_) => 32), 32));

    test("if Err, update local variable", () {
      bool output = true;

      result
        ..ifOk((_) => output = true)
        ..ifErr((_) => output = false);

      expect(output, false);
    });
  });
}
