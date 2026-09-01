public import Checkpoint
public import Iterator
public import Iterator_Protocol

extension Cursor {

    public protocol Positioned: Cursor.`Protocol`, ~Copyable, ~Escapable
    where Checkpoint: Comparable {

        var bounds: ClosedRange<Checkpoint> { get }
    }
}

extension Cursor.Positioned where Self: ~Copyable {

    @inlinable
    public func isValid(_ checkpoint: Checkpoint) -> Bool {
        bounds.contains(checkpoint)
    }
}
