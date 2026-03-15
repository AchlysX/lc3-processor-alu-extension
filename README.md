# LC-3 Processor Extension — Custom Instruction Set & ALU Design

## Overview

This project extends an educational 16‑bit LC‑3 processor by modifying its Arithmetic Logic Unit (ALU) and control logic to support new custom instructions and enhanced memory operations.

The work combines **computer architecture**, **digital logic design**, and **assembly programming** to demonstrate low‑level hardware/software co‑design skills relevant to embedded systems, IoT firmware, and cybersecurity.

---

## Objectives

* Extend the processor instruction set with new bit‑manipulation operations
* Modify the ALU and essential datapath components
* Update the control unit to decode and execute new instructions
* Ensure correct NZP (Negative/Zero/Positive) flag behavior
* Validate all features using LC‑3 assembly test programs

---

## Added Instructions

### Bit Scan Forward (BSF)

Scans a 16‑bit register from Least Significant Bit (LSB) to Most Significant Bit (MSB) and returns the index of the first bit set to 1.

**Example:**

```
Input  = 1000 0000 0000 0010
Output = 1
```

### Bit Scan Backward (BSB)

Scans a 16‑bit register from MSB to LSB and returns the index of the first bit set to 1.

**Example:**

```
Input  = 1000 0000 0000 0010
Output = 15
```

### Memory & Addressing Instructions

* **LD** — Load from memory
* **ST** — Store to memory
* **LEA** — Load effective address

---

## Architectural Modifications

### ALU Enhancements

* Integration of custom bit‑scanning logic
* Multiplexer-based operation selection
* Result validation before register write-back

### Priority Encoder

* Detects the first active bit
* Converts bit position into a binary index

### Bit Reversal Unit

* Enables reverse bit scanning for BSB

### Instruction Decoder (Control Unit)

* New control signals for custom instructions
* Memory operation management
* Jump and arithmetic signal routing

### Write-Back Logic

Selects the correct value written to registers:

* Program Counter (JSR)
* Memory output (LD)
* Effective address (LEA)
* ALU result (default)

### NZP Flag Control

* Conditional flag updates
* Result-based status validation
* Instruction-aware flag management

---

## Testing & Validation

Multiple LC‑3 assembly programs were written to validate correctness.

### Example — BSF Test

```assembly
.ORIG x3000
LD R1, DATA
BSF R2, R1
HALT
DATA .FILL x8002
.END
```

### Example — BSB Test

```assembly
.ORIG x3000
LD R1, DATA
BSB R2, R1
HALT
DATA .FILL x8002
.END
```

### Example — Memory Operations

```assembly
.ORIG x3000
LEA R1, LABEL
LD R2, LABEL
HALT
LABEL .FILL x1234
.END
```

All tests produced expected results and confirmed reliable instruction execution and memory access.

---

## Tools & Technologies

* Digital logic simulator (Logisim or equivalent)
* LC‑3 Assembly language
* Custom datapath and control unit design
* Circuit optimization with gate-count constraints

---

## Project Structure

```
LC3-Processor-Extension/
│
├── circuits/        # Processor circuit files
├── assembly/        # LC-3 assembly test programs
├── obj/             # Compiled object files
├── docs/            # Project documentation
└── README.md
```

---


## Possible Improvements

* Reduce circuit depth for faster propagation
* Further ALU optimization
* Add automated instruction testbench
* Extend instruction set with arithmetic enhancements

---


Engineering project completed as part of a Computer Architecture course.
