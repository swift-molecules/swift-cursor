# swift-cursor

The algebraic cursor: a positioned, multipass read head over a sequence.

`Cursor.Protocol` composes two independent capabilities — iteration
(`Iterator.Protocol`, the single-pass stream coalgebra) and checkpointing
(`Restorable`, a lawful checkpoint/seek lens on state) — into the multipass
guarantee: what was read once can be read again from a saved position.
`Cursor.Positioned` refines it with comparable, bounded checkpoints, making
the cursor a genuine position within its sequence.

Concrete cursors are domain molecules conforming to these tiers
(`Memory.Cursor`, `Binary.Cursor`, collection-slice cursors), never
inhabitants of this atom. Copyable value-semantic state satisfies
`Restorable` for free (`Checkpoint == Self`), so the tiers cost nothing
where backtracking is plain reassignment — their payoff is inputs that
cannot be copied.
