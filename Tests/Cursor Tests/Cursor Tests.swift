import Checkpoint_Test_Support
import Cursor
import Testing

@Suite
struct `Cursor Tests` {

    @Test
    func `iterates its elements in order`() {
        var cursor = ArrayCursor([1, 2, 3])

        #expect(cursor.next() == 1)
        #expect(cursor.next() == 2)
        #expect(cursor.next() == 3)
        #expect(cursor.next() == nil)
    }

    @Test
    func `is multipass: a checkpoint replays the sequence`() {
        var cursor = ArrayCursor([1, 2, 3])
        _ = cursor.next()

        let mark = cursor.checkpoint
        #expect(cursor.next() == 2)
        #expect(cursor.next() == 3)

        cursor.seek(to: mark)
        #expect(cursor.next() == 2)
    }

    @Test
    func `satisfies the Restorable laws`() {
        var cursor = ArrayCursor([1, 2, 3])
        _ = cursor.next()

        #expect(
            RestorableLaws.seekToCurrentIsIdentity(&cursor) { $0.position }
        )
        #expect(
            RestorableLaws.checkpointRestoresAcrossMutation(
                &cursor,
                mutate: { _ = $0.next() },
                observe: { $0.position }
            )
        )
    }

    @Test
    func `positions validate against bounds`() {
        let cursor = ArrayCursor([1, 2, 3])

        #expect(cursor.isValid(0))
        #expect(cursor.isValid(3))
        #expect(!cursor.isValid(4))
    }
}

private struct ArrayCursor: Cursor.Positioned {

    let elements: [Int]

    private(set) var position: Int

    init(_ elements: [Int]) {
        self.elements = elements
        self.position = 0
    }

    typealias Element = Int
    typealias Failure = Never

    mutating func next() -> Int? {
        guard position < elements.count else { return nil }
        defer { position += 1 }
        return elements[position]
    }

    var checkpoint: Int {
        position
    }

    mutating func seek(to checkpoint: Int) {
        position = checkpoint
    }

    var bounds: ClosedRange<Int> {
        0...elements.count
    }
}
