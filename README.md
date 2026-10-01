# FIFO Buffer on FPGA (VHDL, Basys 3)

A 16-entry × 16-bit **FIFO (First-In, First-Out) memory** written in VHDL and running on a **Digilent Basys 3** board (Artix-7). Values are entered on the switches and written or read with buttons. The current value is shown in hexadecimal on the 7-segment display, and LEDs show the FIFO state (empty, last free slot, full).

Built as an extra-credit project for the **Digital Systems Design** course (2025).

## Features

- **16 × 16-bit storage** set by the generics `DEPTH` and `WIDTH`
- **Separate write and read pointers**, built from 4-bit up-counters that wrap around, so the buffer works as a circular buffer
- **Overflow and underflow protection:** writes are ignored when the FIFO is full, and reads are ignored when it is empty
- **Status LEDs:** `empty`, `last` (only one free slot left) and `full`
- **4-digit hexadecimal display**, multiplexed from the 100 MHz clock
- **Preview mode:** while the OK button is held, the display shows the value currently set on the switches
- **Button debouncing** with a single-pulse generator (MPG), so one press equals exactly one write or read

## Architecture

```
 switches[15:0] ─────────────┐
                             ▼
 btnL ─► MPG ─► write_en ─► [write ptr] ─┐
                                         ├─► 16×16 register array ─► display mux ─► 7-seg
 btnR ─► MPG ─► read_en ──► [read ptr] ──┘           │
                                                     ▼
                                   fifo_count ─► empty / last / full LEDs
```

| File | Role |
|---|---|
| `src/FIFO_Controller.vhd` | Top level: storage array, element counter, status flags, 7-segment display driver |
| `src/Numarator_SUS_JOS_4.vhd` | 4-bit up/down counter, used for the write and read pointers |
| `src/MPG.vhd` | Button debouncer and single-pulse generator |
| `constraints/Basys-3.xdc` | Pin assignments for the Basys 3 |
| `bit/FIFO_Controller.bit` | Prebuilt bitstream |

## Board controls

| Board | Signal | Function |
|---|---|---|
| `SW15–SW0` | `data_in` | 16-bit value to write |
| `btnL` | `btn_write` | Write the value into the FIFO |
| `btnR` | `btn_read` | Read the oldest value from the FIFO |
| `btnC` | `OK1` | Hold to preview the switch value on the display |
| `btnD` | `reset` | Clear the FIFO |
| `LD0` | `empty` | FIFO is empty |
| `LD1` | `last` | Only one free slot left |
| `LD2` | `full` | FIFO is full |
| 7-segment display | — | Last value written or read, in hex |

## Building

1. Create a Vivado project for the Basys 3 (part **xc7a35tcpg236-1**).
2. Add the three files from `src/` as design sources, with `FIFO_Controller` as the top module.
3. Add `constraints/Basys-3.xdc`.
4. Generate the bitstream and program the board. Or program it directly with `bit/FIFO_Controller.bit`.

## Tech

VHDL · Xilinx Vivado · Artix-7 FPGA (Basys 3)
