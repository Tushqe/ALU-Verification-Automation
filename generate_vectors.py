# -*- coding: utf-8 -*-
"""
Created on Sun Mar  8 20:00:34 2026

@author: bolorchu
"""

import random

OUTPUT_FILE = "test_vectors.txt"
NUM_RANDOM_TESTS = 100
RANDOM_SEED = 42


def alu_model(a: int, b: int, k2: int, k1: int, k0: int):
    """
    Returns:
        y          : expected 8-bit output
        cout       : expected carry-out
        check_cout : 1 if Cout should be checked, else 0
    """
    op = (k2 << 2) | (k1 << 1) | k0

    # Logic operations
    if op == 0b000:      # ~A
        y = (~a) & 0xFF
        cout = 0
        check_cout = 0

    elif op == 0b001:    # A ^ B
        y = a ^ b
        cout = 0
        check_cout = 0

    elif op == 0b010:    # A & B
        y = a & b
        cout = 0
        check_cout = 0

    elif op == 0b011:    # A | B
        y = a | b
        cout = 0
        check_cout = 0

    # Arithmetic operations
    elif op == 0b100:    # A + B
        total = a + b
        y = total & 0xFF
        cout = (total >> 8) & 0x1
        check_cout = 1

    elif op == 0b101:    # A
        y = a
        cout = 0
        check_cout = 1

    elif op == 0b110:    # A - B = A + (~B) + 1
        total = a + ((~b) & 0xFF) + 1
        y = total & 0xFF
        cout = (total >> 8) & 0x1
        check_cout = 1

    elif op == 0b111:    # A + 1
        total = a + 1
        y = total & 0xFF
        cout = (total >> 8) & 0x1
        check_cout = 1

    else:
        raise ValueError("Invalid ALU op")

    return y, cout, check_cout


def format_line(a, b, k2, k1, k0, y, cout, check_cout):
    return f"{a:02X} {b:02X} {k2} {k1} {k0} {y:02X} {cout} {check_cout}"


def main():
    random.seed(RANDOM_SEED)

    lines = []

    # Directed tests
    directed_tests = [
        (0x5A, 0x3C, 0, 0, 0),  # ~A
        (0x5A, 0x3C, 0, 0, 1),  # XOR
        (0x5A, 0x3C, 0, 1, 0),  # AND
        (0x5A, 0x3C, 0, 1, 1),  # OR
        (0x5A, 0x3C, 1, 0, 0),  # ADD
        (0x5A, 0x3C, 1, 0, 1),  # PASS A
        (0x5A, 0x3C, 1, 1, 0),  # SUB
        (0x5A, 0x3C, 1, 1, 1),  # INC
        (0xFF, 0x01, 1, 0, 0),  # add rollover
        (0x10, 0x01, 1, 1, 0),  # subtraction check
        (0xFF, 0x00, 1, 1, 1),  # increment rollover
        (0x00, 0x00, 0, 0, 0),  # ~0 = FF
        (0x00, 0x00, 1, 0, 1),  # pass A = 00
        (0xAA, 0x55, 0, 0, 1),  # XOR = FF
        (0xF0, 0x0F, 0, 1, 0),  # AND = 00
        (0xF0, 0x0F, 0, 1, 1),  # OR = FF
        (0x00, 0x01, 1, 1, 0),  # 00 - 01
        (0x80, 0x80, 1, 0, 0),  # 80 + 80
        (0x7F, 0x01, 1, 1, 1),  # increment 7F
    ]

    for a, b, k2, k1, k0 in directed_tests:
        y, cout, check_cout = alu_model(a, b, k2, k1, k0)
        lines.append(format_line(a, b, k2, k1, k0, y, cout, check_cout))

    # Random tests
    for _ in range(NUM_RANDOM_TESTS):
        a = random.randint(0, 255)
        b = random.randint(0, 255)
        op = random.randint(0, 7)

        k2 = (op >> 2) & 1
        k1 = (op >> 1) & 1
        k0 = op & 1

        y, cout, check_cout = alu_model(a, b, k2, k1, k0)
        lines.append(format_line(a, b, k2, k1, k0, y, cout, check_cout))

    with open(OUTPUT_FILE, "w") as f:
        for line in lines:
            f.write(line + "\n")

    print(f"Wrote {len(lines)} test vectors to {OUTPUT_FILE}")


if __name__ == "__main__":
    main()