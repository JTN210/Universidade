/*

Finish the specification of this notification concept,
including its events, scenarios, and operational principles.

*/ 

sig Event {}

sig User {
	var subscriptions : set Event,
	var notifications : set Event
}

pred stutter {
	subscriptions' = subscriptions
	notifications' = notifications
}

pred read[u : User] {
	// Read all notifications

}

pred subscribe[u : User, e : Event] {
	// Subscribe an event

}

pred unsubscribe[u : User, e : Event] {
	// Unsubscribe from a event

}

pred occur [e : Event] {
	// Occurrence of an event

}

fact {
	no subscriptions
	no notifications
	always {
		stutter or
		(some u : User | read[u]) or
		(some u : User, e : Event | subscribe[u,e] or unsubscribe[u,e]) or
		(some e : Event | occur[e])
	}
}

// Validation

run Example {
	// Empty run to be used for simulation
}

run Scenario1 {
	// An event is subscribed, then occurs, and the respective notification is read 

} expect 1

run Scenario2 {
	// An event is subscribed, unsubscribed, and then occurs

} expect 1

run Scenario3 {
	// An event is subscribed by two users and then occurs

} expect 1

run Scenario4 {
	// A user subscribes two events, then both occur, then unsubscribes one of them, and finally reads the notifications

} expect 1

run Scenario5 {
	// A user subscribes the same event twice in a row

} expect 0

run Scenario6 {
	// Eventually an user reads notification twice in a row

} expect 0

// Verification 

check OP1 {
	// Users can only have notifications of subscribed events

}

check OP2 {
	// Users can only read notifications if they have some subscription

}

check OP3 {
	// When an event occurs, no existing notifications are lost

}

check OP4 {
	// Unsubscribe undos subscribe

}

check OP5 {
	// Notify is idempotent

}

check OP6 {
	// It's impossible to read notifications before some event is subscribed

}

check OP7 {
	// After notifications are read, it is only possible to read again after some notification on a subscribed event occurs

}
