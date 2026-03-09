# ALU-Verification-Automation

Python-assisted verification automation flow for a structural 8-bit Verilog ALU using self-checking simulation, directed tests, and randomized regression in Vivado/xsim.

---

## Overview

This project demonstrates an automated verification flow for a custom **8-bit structural ALU** written in **Verilog**. The verification environment uses:

- **Python** to generate directed and randomized test vectors
- a **self-checking Verilog testbench** to read vectors and compare DUT outputs against expected results
- **Vivado/xsim** to run automated simulation and report pass/fail status

The goal of this project was to build hands-on experience with the kind of scripting and debug workflow commonly used in **digital VLSI verification**, especially for regression-style checking and automated validation.

<img width="1920" height="878" alt="Screenshot 2026-03-08 at 21 43 11" src="https://github.com/user-attachments/assets/a19744bd-5f30-4649-90e7-885289eaed1b" />

<img width="1901" height="875" alt="Screenshot 2026-03-08 at 21 42 04" src="https://github.com/user-attachments/assets/be42cac4-3a82-477d-b5b4-af9bb9a7e9e4" />

<img width="1916" height="870" alt="Screenshot 2026-03-08 at 21 44 14" src="https://github.com/user-attachments/assets/fa1ca468-a1d9-40bc-bc27-f5b3e7e25940" />



---

## Why This Project

This repository was created to practice skills relevant to digital design and verification roles, including:

- verification automation
- regression testing
- self-checking testbench development
- debugging functional mismatches in Verilog designs
- scripting support for simulation workflows

---

## Device Under Test (DUT)

The DUT is a structural **8-bit combinational ALU** with:

- two 8-bit operands: `A`, `B`
- three control bits: `K2`, `K1`, `K0`
- one 8-bit output: `Y`
- one carry output: `Cout`

The ALU is built hierarchically using:

- `ALU_8b`
- `BitSlice`
- `LogicBlk`
- `ArithBlk`
- `FullAdder`
- `MUX_21`
- `MUX_41`

---

## ALU Operation Table

| K2 | K1 | K0 | Operation |
|----|----|----|-----------|
| 0  | 0  | 0  | `~A`      |
| 0  | 0  | 1  | `A ^ B`   |
| 0  | 1  | 0  | `A & B`   |
| 0  | 1  | 1  | `A \| B`  |
| 1  | 0  | 0  | `A + B`   |
| 1  | 0  | 1  | `A`       |
| 1  | 1  | 0  | `A - B`   |
| 1  | 1  | 1  | `A + 1`   |

---

## Verification Flow

The verification flow is organized around three parts:

### 1. Python Test Vector Generation
A Python script generates:

- directed test cases for known functional checks
- randomized test cases for broader coverage
- expected output values for `Y`
- expected `Cout` values for arithmetic operations

The script writes test vectors into a plain-text file:

`test_vectors.txt`

### 2. Self-Checking Testbench
A Verilog testbench:

- reads test vectors from `test_vectors.txt`
- applies each test case to the ALU
- compares DUT outputs to expected values
- prints `PASS` or `FAIL` messages
- summarizes total tests and failures at the end

### 3. Simulation in Vivado/xsim
Simulation is run in Vivado using `xsim`, allowing the ALU to be verified with an automated, repeatable regression-style flow.

---

## Test Vector Format

Each line in `test_vectors.txt` uses the format:

```text
A B K2 K1 K0 EXP_Y EXP_COUT CHECK_COUT
```

## Verification Results

The regression flow successfully ran:

- **119 total automated test cases**
- **directed and randomized inputs**
- **all cases passing**

### Checked behaviors included:
- all 8 ALU control modes
- arithmetic carry behavior
- subtraction behavior
- increment rollover
- logical operations with distinct bit patterns
- random regression coverage across the ALU control space

---

## How to Run 

```text
python generate_vectors.py
```

This creates: test_vectors.txt

2. Run simulation:

```text
test_vectors.txt
```

