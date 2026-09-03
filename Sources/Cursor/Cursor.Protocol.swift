public import Checkpoint
public import Iterator
public import Iterator_Protocol

extension Cursor {

    public protocol `Protocol`<Element, Failure>: Iterator.`Protocol`, Restorable, ~Copyable, ~Escapable
    where Checkpoint: Equatable {}
}
