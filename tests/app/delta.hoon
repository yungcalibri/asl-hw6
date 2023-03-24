/-  delta
/+  *test
/=  agent  /app/delta
|%
+$  versioned-state
  $%  state-0
  ==
+$  state-0
  $:  [%0 values=(list @)]
  ==
::  The agent should reject any action that targets a ship other than
::  this one.
::
++  test-target-validation
  =|  run=@ud
  %-  expect-fail
    |.  (~(on-poke agent (bowl run)) %delta-action !>([%push ~bud 10]))
::
::  %push should add the provided value to the top of the stack.
::
++  test-push-ordering
  =|  run=@ud
  =^  mov1  agent
    (~(on-poke agent (bowl run)) %delta-action !>([%push ~zod 6]))
  =^  mov2  agent
    (~(on-poke agent (bowl run)) %delta-action !>([%push ~zod 8]))
  =+  !<(actual-state=versioned-state on-save:agent)
  =+  !<(expected-state=versioned-state !>([%0 values=~[8 6]]))
  (expect-eq !>(expected-state) !>(actual-state))
::  When the stack is populated, %pop should strip off its top value.
::
++  test-populated-pop
  =|  run=@ud
  =^  mov1  agent
    (~(on-poke agent (bowl run)) %delta-action !>([%push ~zod 6]))
  =^  mov2  agent
    (~(on-poke agent (bowl run)) %delta-action !>([%push ~zod 8]))
  =^  mov3  agent
    (~(on-poke agent (bowl run)) %delta-action !>([%pop ~zod]))
  =+  !<(actual-state=versioned-state on-save:agent)
  =+  !<(expected-state=versioned-state !>([%0 values=~[6]]))
  (expect-eq !>(expected-state) !>(actual-state))
::  When the stack is empty, %pop should produce a new state identical
::  to the previous state.
++  test-empty-pop
  =|  run=@ud
  =+  !<(first-empty=versioned-state on-save:agent)
  =^  mov1  agent
    (~(on-poke agent (bowl run)) %delta-action !>([%pop ~zod]))
  =+  !<(second-empty=versioned-state on-save:agent)
  (expect-eq !>(first-empty) !>(second-empty))
::
++  bowl
  |=  run=@ud
  ^-  bowl:gall
  :*  [~zod ~zod %delta]
    [~ ~]
    [run `@uvJ`(shax run) (add (mul run ~s1) *time) [~zod %delta ud+run]]
  ==
--
