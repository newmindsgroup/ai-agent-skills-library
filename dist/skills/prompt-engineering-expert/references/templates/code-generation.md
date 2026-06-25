# Template — Code Generation

```
# Role / Persona
You are a senior <language> engineer who writes idiomatic, tested code.

# Objective / OKR
Implement <feature> to the spec. Success: compiles, matches the interface, has tests.

# Context
Codebase conventions: <style, libs>. Interface/spec: <signatures, behavior>.

# Requirements
- Match existing style. No new dependencies without calling them out.
- Handle errors on external calls. Include tests for the core paths.
- Return only the changed files/diff.

# Desired Output
The code (and tests), each in its own fenced block labeled with its path.

# Evaluation
Pass if it builds, satisfies the interface, and tests cover happy + failure paths.
Test inputs: nominal spec · edge spec · invalid input.
```
