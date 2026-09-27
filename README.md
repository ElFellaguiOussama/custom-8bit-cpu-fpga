# Custom 8-bit FPGA CPU & Toolchain

A fully custom, scratch-built 8-bit CPU architecture designed, simulated, assembled, and synthesized from the ground up for the **Tang Nano 20K FPGA**. Built for portfolio authenticity to demonstrate deep mastery of digital design, instruction set architecture (ISA), RTL synthesis, and hardware-software co-design.

---

## 🚀 Project Overview

This project implements a complete, working embedded computing system on an FPGA, featuring:
* **Custom ISA:** Purpose-built instruction set architecture supporting arithmetic, jumps, conditional branching (`JNZ`), and memory operations.
* **Memory-Mapped I/O:** Peripheral interaction mapped directly to address space (`0xFF`) for real-time hardware control (such as driving LEDs).
* **Custom Python Toolchain:** An automated assembler (`assembler.py`) that parses custom assembly code and compiles it directly into binary instructions baked into the combinational instruction ROM (`inst_rom`).
* **Hardware Validation:** Successfully synthesized and deployed on physical Tang Nano 20K hardware running a custom LED chaser program clocked via an internal PLL/clock divider.

---

## ⚙️ Architecture & Specifications

* **Target Hardware:** Gowin Tang Nano 20K FPGA (GW2AR-18 chip)
* **Clock Source:** 27 MHz system oscillator (scaled down via custom clock divider for visual inspection)
* **Data Path:** 8-bit ALU supporting core arithmetic and logical operations
* **Memory Map:** 
  * Instruction ROM (`inst_rom`): Asynchronous combinational ROM initialized via compiled binary
  * Data RAM: Internal RAM blocks for variable storage and data manipulation
  * Memory-Mapped I/O: Address `0xFF` routed directly to physical LED output pins

---

## 🛠️ The Custom Toolchain

Writing machine code by hand is tedious, so this repository includes a custom Python assembler located in the `assembler/` directory.

```bash
# Example workflow: Compile assembly to binary instruction ROM
python assembler/assembler.py source_code.asm --output inst_rom.v
