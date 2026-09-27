# Define your opcode mapping to match your Verilog localparams
OPCODES = {
    "ADD": 1,
    "SUB": 2,
    "SHIFT_LEFT": 3,
    "SHIFT_RIGHT": 4,
    "OUT": 5,
    "CLEAN": 6,
    "AND": 7,
    "OR": 8,
    "NOT": 9,
    "JUMP": 10,
    "ADD_MEM": 11,
    "SUB_MEM": 12,
    "SHIFT_LEFT_MEM": 13,
    "SHIFT_RIGHT_MEM": 14,
    "JNZ": 15,
    "JZ": 16,
}


def assemble_code(assembly_lines):
  mem_index = 1  # Starting at 8'h01 based on your testbench
  output_code = []

  for line in assembly_lines:
    # Strip comments and whitespace
    line = line.split("//")[0].strip()
    if not line:
      continue

    parts = line.split()
    mnemonic = parts[0].upper()
    operand = int(parts[1], 0) if len(parts) > 1 else 0

    if mnemonic not in OPCODES:
      raise ValueError(f"Unknown instruction: {mnemonic}")

    opcode_val = OPCODES[mnemonic]

    # Format into your exact Verilog syntax
    output_code.append(f"mem[8'h{mem_index:02X}] = 8'd{opcode_val};")
    mem_index += 1
    output_code.append(f"mem[8'h{mem_index:02X}] = 8'd{operand};")
    mem_index += 1

  return "\n".join(output_code)


# Example usage:
assembly_program = [
    "ADD 50",
    "OUT 1",  #OUTER LOOP
    "CLEAN 0",
    "ADD 50",
    "OUT 2",  #INNER LOOP
    "CLEAN 0",
    "ADD 50",
    "OUT 3", #INNER+ LOOP
    "CLEAN 0", # ADDRESS B
    "ADD 1",
    "OUT 255", #LED REG
    "CLEAN 0",
    ##DELAY START##
    "CLEAN 0" ,  ##ADDRESS A
    "ADD_MEM 3",
    "SUB 1",
    "OUT 3",
    "JNZ 25",
    "CLEAN 0",
    "ADD 50",
    "OUT 3",
    "CLEAN 0",
    "ADD_MEM 2",
    "SUB 1",
    "OUT 2",
    "JNZ 25",
    "CLEAN 0",
    "ADD 50",
    "OUT 2",
    "CLEAN 0",
    "ADD_MEM 1",
    "SUB 1",
    "OUT 1",
    "JNZ 25",
    "CLEAN 0",
    "ADD 50",
    "OUT 1",
    "CLEAN 0",
    ##DELAY FINISH##
    "ADD_MEM 255",
    "SHIFT_LEFT 1",
    "OUT 255",
    "JNZ 25",
    "JZ 17"
]

print(assemble_code(assembly_program))