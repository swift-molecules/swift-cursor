public import Checkpoint
public import Cursor
public import Index
public import Iterator
public import Iterator_Protocol
public import Ordinal_Protocol

extension Cursor {

    public protocol Counted: Cursor.Positioned, ~Copyable, ~Escapable {

        var count: Index::Index<Element>.Count { get }

        mutating func advance(by count: Index::Index<Element>.Count)
    }
}
