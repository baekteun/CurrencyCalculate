import XCTest
import Then

struct TestStruct {
    var name: String = ""
    var email: String = ""
}
extension TestStruct: Then {}

class TestObject {
    var property1: Int = 0
    var property2: String = ""
}
extension TestObject: Then {}

final class ThenTests: XCTestCase {
    func test_Configurable_Set_With_Class() {
        let testObject1 = TestObject()
            .set(\.property1, 42)
        XCTAssertEqual(testObject1.property1, 42)
        XCTAssertEqual(testObject1.property2, "")

        let testObject2 = TestObject()
            .set(\.property1, 12)
            .set(\.property2, "Hello")
        XCTAssertEqual(testObject2.property1, 12)
        XCTAssertEqual(testObject2.property2, "Hello")
    }

    func test_Configurable_Then_With_Class() {
        let testObject1 = TestObject().then {
            $0.property1 = 42
        }
        XCTAssertEqual(testObject1.property1, 42)
        XCTAssertEqual(testObject1.property2, "")

        let testObject2 = TestObject().then {
            $0.property1 = 12
            $0.property2 = "Hello"
        }
        XCTAssertEqual(testObject2.property1, 12)
        XCTAssertEqual(testObject2.property2, "Hello")
    }

    func test_Configurable_Then_With_Struct() {
        let testStruct1 = TestStruct().then {
            $0.name = "John"
        }
        XCTAssertEqual(testStruct1.name, "John")
        XCTAssertEqual(testStruct1.email, "")

        let testStruct2 = TestStruct().then {
            $0.name = "John"
            $0.email = "asdf"
        }
        XCTAssertEqual(testStruct2.name, "John")
        XCTAssertEqual(testStruct2.email, "asdf")
    }
}
