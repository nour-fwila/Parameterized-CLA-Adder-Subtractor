# Parameterized Carry Look-Ahead Adder/Subtractor (RTL)

A fully parameterized, generic **Carry Look-Ahead (CLA) Adder/Subtractor** designed in **Verilog HDL**. This design calculates carries in parallel using Generate ($G$) and Propagate ($P$) logic to eliminate ripple-carry propagation delay, supporting 2's complement arithmetic and hardware signed overflow detection.

---

## 🔑 Key Features
* **Parameterization:** Easily scalable bit-width (`WIDTH`) defaults to 4-bit, compatible with 8-bit, 16-bit, or 32-bit setups.
* **High Performance:** Parallel carry lookup logic using $P_i = A_i \oplus B_i$ and $G_i = A_i \cdot B_i$.
* **Dual Operation:** Supports addition (`mode = 0`) and 2's complement subtraction (`mode = 1`).
* **Overflow Detection:** Real-time hardware flag (`Overflow`) for 2's complement signed arithmetic overflow.

---

## 🛠️ Architecture Overview

The system consists of three main hardware modules:
1. **`hadd`**: Computes base Propagate ($P$) and Generate ($G$) bits.
2. **`ci_one`**: Computes look-ahead carries recursively: $C_{i+1} = G_i + (P_i \cdot C_i)$.
3. **`cla_add_sub`**: Top-level wrapper managing $B$ inversion (via `mode`), carry generation, sum evaluation, and overflow logic.

### Mathematical Logic:
* **Inversion for Subtraction:** $B_{eff} = B \oplus \text{mode}$
* **Sum Calculation:** $Sum_i = P_i \oplus C_i$
* **Signed Overflow:** $Overflow = (A_{msb} \cdot B_{msb} \cdot \overline{Sum_{msb}}) + (\overline{A_{msb}} \cdot \overline{B_{msb}} \cdot Sum_{msb})$

---

## 🔬 Simulation & Verification

The design was simulated using **Icarus Verilog (`iverilog`)** and verified via **GTKWave**.

### Test Cases Verified:
1. **Addition:** $3 + 2 = 5$ (`mode = 0`)
2. **Subtraction:** $5 - 3 = 2$ (`mode = 1`)
3. **Signed Overflow:** $-4 - 5 = -9$ (Triggers `Overflow = 1` as result exceeds 4-bit range $[-8, +7]$).

### How to Run Simulation:
```bash
# Compile RTL and Testbench
iverilog -o sim.vvp rtl/cla_add_sub.v rtl/hadd.v rtl/ci_one.v tb/cla_tb.v

# Run Simulation
vvp sim.vvp

# Open Waveform in GTKWave
gtkwave cla_add_sub_tb.vcd
