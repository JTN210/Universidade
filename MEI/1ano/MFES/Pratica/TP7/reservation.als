/*

Finish the specification of this notification concept,
including its events, scenarios, and operational principles.

*/ 

sig Resource {}

sig User {
	var reservations : set Resource
}

var sig Available in Resource {}

pred reserve[u : User, r : Resource] {
	// Make a reservation
	r in Available

	Available' = Available - r
	reservations' = reservations + u->r
}

pred cancel[u : User, r : Resource] {
	// Cancel a reservation

	r in  u.reservations

	Available' = Available + r
	reservations' = reservations - u->r
}

pred use[u : User, r : Resource] {
	// Use a reserved resource
	r in  u.reservations

	Available' = Available
	reservations' = reservations - u->r'



}

pred cleanup {
	// Make all used resources available again

	some Resource - Available - User.reservations
	Available' = Resource - reservations.Resource
    reservations' = reservations
}

pred stutter {
	Available' = Available
	reservations' = reservations
}

fact {
	Available = Resource
	no reservations
	always {
		stutter
		or 
		cleanup
		or 
		(some u : User, r : Resource| reserve[u,r] or cancel[u,r] or use[u,r])
	}
}

// Validation

run Example {
	// Empty run to be used for simulation
}

run Scenario1 {
	some u: User, r: Resource{
		reserve[u,r]; cleanup
	}
} expect 1

run Scenario2 {
	// A user reserves a resource, cancels the reservation, and reserves again
	some u : User, r : Resource{
		reserve[u,r]; cancel[u,r]; reserve[u,r];
	}

} expect 1

run Scenario3 {
	// A user reserves two resources, cancels one, uses the other, and finally a cleanup occurs
		some u : User, disj r1,r2 : Resource{
		reserve[u,r1]; reserve[u,r2]; cancel[u,r2]; cleanup
	}
} expect 1

run Scenario4 {
	// Two users try to reserve the same resource
	some disj u1,u2 : User, r : Resource{
		reserve[u1,r]; reserve[u2,r]
	}

} expect 0

run Scenario5 {
	// Eventually a cleanup is performed twice in a row
	Eventually(cleanup; cleanup)
} expect 0

// Verification

check OP1 {
	// Reserved resources aren't available

}

check OP2 {
	// The system starts in a cleaned state

}

check OP3 {
	// After a cleanup all unreserved resources are available

}

check OP4 {
	// A cleanup cannot affect existing reservations

}

check OP5 {
	// Cancel undoes reserve

}

check OP6 {
	// Used resources were reserved before

}

check OP7 {
	// Used resources can only be reserved again after a cleanup

}

check OP8 {
	// If a cleanup occurs some resource was used before

}

check OP9 {
	// Used resources were not canceled since being reserved

}

check OP10 {
	// Reserved resources can be used while not used or canceled

}

check OP11 {
	// The first event to occur will be a reservation

}

check OP12 {
	// If cleanups and cancels never occur the available resources keep diminishing

}