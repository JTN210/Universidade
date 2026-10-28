# Concrete instance examples

These examples adapt `prompt_few.txt`. Each section is a separate model; copy its run commands into that model only. The requirements are stated in natural language, not formalized. Against declarations alone, all scenarios below are satisfiable, including those labeled `expect 0`. The expectation labels apply once the target requirement is enforced as a fact.

## Binary relation, distinct positives, and empty populations

Requirement: **Every person owns a car.** Requested counts: three positive and two negative scenarios.

```alloy
sig Person { owns: set Car }
sig Car {}

// Expectations apply once the requirement is enforced as a fact.

// Positive: the sole person owns the sole car.
run PositiveScenario1 {
    some disj p1: Person | some disj c1: Car {
        Person = p1
        Car = c1
        owns = p1->c1
    }
} for exactly 1 Person, exactly 1 Car expect 1

// Positive: two people both own the same car; each owns at least one.
run PositiveScenario2 {
    some disj p1, p2: Person | some disj c1: Car {
        Person = p1 + p2
        Car = c1
        owns = p1->c1 + p2->c1
    }
} for exactly 2 Person, exactly 1 Car expect 1

// Positive: there are no people, so the requirement holds vacuously.
run PositiveScenario3 {
    Person = none
    Car = none
    owns = none->none
} for exactly 0 Person, exactly 0 Car expect 1

// Negative: p1 owns no car, and no cars exist.
run NegativeScenario1 {
    some disj p1: Person {
        Person = p1
        Car = none
        owns = none->none
    }
} for exactly 1 Person, exactly 0 Car expect 0

// Negative: p1 owns c1, but p2 owns no car.
run NegativeScenario2 {
    some disj p1, p2: Person | some disj c1: Car {
        Person = p1 + p2
        Car = c1
        owns = p1->c1
    }
} for exactly 2 Person, exactly 1 Car expect 0
```

## Subsets and an abstract parent

Requirement: **Every person owns a car.** Requested counts: one positive and one negative scenario.

```alloy
sig Person { owns: set Car }
sig Adult in Person {}
abstract sig Car {}
sig Sedan, SUV extends Car {}

// Positive: p1 owns the sedan and p2 owns the SUV.
run PositiveScenario1 {
    some disj p1, p2: Person | some disj c1, c2: Car {
        Person = p1 + p2
        Adult = p1
        Car = c1 + c2
        Sedan = c1
        SUV = c2
        owns = p1->c1 + p2->c2
    }
} for exactly 2 Person, exactly 2 Car expect 1

// Negative: p1 owns no car, even though a sedan exists.
run NegativeScenario1 {
    some disj p1: Person | some disj c1: Car {
        Person = p1
        Adult = none
        Car = c1
        Sedan = c1
        SUV = none
        owns = none->none
    }
} for exactly 1 Person, exactly 1 Car expect 0
```

## Ternary relation and an aliased order

Requirement: **Every person owns a car at some value.** Requested counts: one positive and one negative scenario.

```alloy
open util/ordering[Value] as valueOrder
sig Person { owns: Car -> lone Value }
sig Car {}
sig Value {}

// Positive: p1 owns c1 at v1 and p2 owns c2 at v2.
run PositiveScenario1 {
    some disj p1, p2: Person | some disj c1, c2: Car |
    some disj v1, v2: Value {
        Person = p1 + p2
        Car = c1 + c2
        Value = v1 + v2
        owns = p1->c1->v1 + p2->c2->v2
        Value <: valueOrder/next = v1->v2
    }
} for exactly 2 Person, exactly 2 Car, exactly 2 Value expect 1

// Negative: p1 owns no car. A singleton order has an empty successor relation.
run NegativeScenario1 {
    some disj p1: Person | some disj c1: Car | some disj v1: Value {
        Person = p1
        Car = c1
        Value = v1
        owns = none->none->none
        Value <: valueOrder/next = none->none
    }
} for exactly 1 Person, exactly 1 Car, exactly 1 Value expect 0
```

## Two orderings and an overloaded field

Requirement: **Every person has a link to a car.** Requested counts: one positive and one negative scenario.

```alloy
open util/ordering[Person] as personOrder
open util/ordering[Car] as carOrder
sig Person { link: set Car }
sig Car { link: set Person }

// Positive: p1 links to c1; both orderings contain just one atom.
run PositiveScenario1 {
    some disj p1: Person | some disj c1: Car {
        Person = p1
        Car = c1
        Person <: link = p1->c1
        Car <: link = none->none
        Person <: personOrder/next = none->none
        Car <: carOrder/next = none->none
    }
} for exactly 1 Person, exactly 1 Car expect 1

// Negative: p2 has no link to a car; p1 does. Car links are independent.
run NegativeScenario1 {
    some disj p1, p2: Person | some disj c1: Car {
        Person = p1 + p2
        Car = c1
        Person <: link = p1->c1
        Car <: link = c1->p2
        Person <: personOrder/next = p1->p2
        Car <: carOrder/next = none->none
    }
} for exactly 2 Person, exactly 1 Car expect 0
```

## Recognizing an impossible negative class

For `sig Person { owns: one Car }` and `sig Car {}`, the declarations already require every person to own exactly one car. A request for negative instances of **Every person owns a car** cannot be met. Assigning no ownership to an existing person would violate the declarations, so it would not be a valid negative scenario for this requirement. Report the obstacle in an Alloy comment instead of generating such a scenario.

## Technical sources

- [Alloy language reference](https://alloytools.org/spec.html): declaration constraints, facts, commands, and scopes.
- [Alloy's ordering module](https://github.com/AlloyTools/org.alloytools.alloy/blob/master/org.alloytools.alloy.core/src/main/resources/models/util/ordering.als): exact scope, nonempty orders, and the empty successor relation for a singleton.
