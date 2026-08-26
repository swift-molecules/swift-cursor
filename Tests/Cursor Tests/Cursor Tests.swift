import Testing

@testable import Cursor

@Suite
struct `Cursor Tests` {
    @Suite struct Unit {
        @Test
        func `namespace is available`() {

            #expect(Bool(true))
        }
    }

    @Suite struct `Edge Case` {}

    @Suite struct Integration {}
}
