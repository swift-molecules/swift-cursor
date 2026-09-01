public import Checkpoint
public import Iterator
public import Iterator_Protocol

extension Cursor {

    public protocol `Protocol`: Iterator.`Protocol`, Restorable, ~Copyable, ~Escapable {}
}
