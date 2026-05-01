# Example Module Checklist

> Status: pre-implementation open example. All items start as `[ ]`. Never pre-check. Implementation and verification are separate steps. This module intentionally does not pass the final gate.

## REQ-001: [Requirement Name]

**Implementation**:
- [ ] [specific code artifact that must exist]

**Verification**:
- [ ] `[exact command to run]` returns expected result
- [ ] `[exact test command]` passes

**Verified on**: ___
**Verified by**: ___

## REQ-002: [Requirement Name]

**Implementation**:
- [ ] [specific code artifact that must exist]

**Verification**:
- [ ] `[exact command to run]` returns expected result
- [ ] `[exact test command]` passes

**Verified on**: ___
**Verified by**: ___

## Regression

- [ ] `[go build ./...]` passes
- [ ] `[go test ./internal/news/...]` passes
- [ ] No unrelated files changed

**Verified on**: ___
**Verified by**: ___

---

## Checklist Rules

1. Every item starts as `[ ]` — never pre-check
2. Every requirement section maps to a `REQ-XXX` ID from `spec.md`
3. **Implementation** items describe WHAT must exist
4. **Verification** items describe HOW to verify (exact commands)
5. **Regression** items verify nothing else broke
6. Check off items only during Reconcile phase
7. Record verification date and who verified
