namespace Bell
{
    open Microsoft.Quantum.Canon;
    open Microsoft.Quantum.Intrinsic;

    operation HelloQ () : Unit {
        Message("Hello quantum world!");
    }

	operation Set (desired: Result, q1: Qubit) : Unit {
        if (desired != M(q1)) {
            X(q1);
        }
    }

	operation BellTest (count : Int, initial: Result) : (Int, Int) {

        mutable numOnes = 0;
        using (qubit = Qubit()) {

            for (test in 1..count) {
                Set (initial, qubit);
				
				// Use Hadamard Gate to put qbit into superposition
				H(qubit);
                let res = M (qubit);

                // Count the number of ones we saw:
                if (res == One) {
                    set numOnes += 1;
                }
            }
            Set(Zero, qubit);
        }

        // Return number of times we saw a |0> and number of times we saw a |1>
        return (count-numOnes, numOnes);
    }
}
