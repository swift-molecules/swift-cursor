public import Ordinal
public import Ownership
public import Tagged

@frozen

@safe
public struct Cursor<
    DomainTag: Ownership.Borrow.`Protocol` & ~Copyable
>: ~Copyable, ~Escapable {

    public let storage: DomainTag.Borrowed

    public var _position: Tagged<DomainTag, Ordinal>

    @inlinable
    @_lifetime(copy storage)
    public init(_ storage: consuming DomainTag.Borrowed) {
        self.storage = storage
        self._position = Tagged<DomainTag, Ordinal>(_unchecked: Ordinal(0))
    }

}
