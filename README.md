# 🧠 TinyML Hardware Accelerator (Track A)
**High-Efficiency INT8 Systolic Array for Edge-AI Inference**

## 📂 Repository Structure
This repository follows industry-standard naming conventions to ensure a clean separation between hardware source code, automation scripts, and timing analysis documentation.

```text
.
├── rtl/                        # Hardware Source (The "DNA")
│   ├── top/
│   │   └── top_tinyml.v        # Top-Level: Integrates Compute, Memory, and Control.
│   ├── compute/
│   │   ├── systolic_array.v    # 2D Grid of Processing Elements (PEs).
│   │   ├── pe.v                # The MAC Unit: Multiplier-Accumulator.
│   │   └── relu.v              # Activation Logic: Non-linear thresholding.
│   ├── memory/
│   │   ├── weight_buffer.v     # Local Storage: Minimizes external weight fetches.
│   │   └── activation_buffer.v # Local Storage: Holds Input Feature Maps (IFMs).
│   └── control/
│       └── controller_fsm.v    # The Brain: Manages data flow and clock cycles.
├── scripts/                    # Automation Tooling
│   ├── synth.tcl               # Yosys Script: Maps Verilog to Sky130 Gates.
│   └── run_sta.tcl             # OpenSTA Script: Calculates Timing and Power.
├── constraints/
│   └── sky130.sdc              # Timing Constraints: Defines 91MHz clock & IO delays.
└── docs/                       # Project Evidence (Proofs)
    ├── synthesis.log           # Full log of the gate-level mapping process.
    └── timing_report.txt       # Confirms Timing (MET) and Power.
```

---

## 🌟 The Strategic Importance of Our Design

### The Problem: Von Neumann Bottleneck

In the current era of AI, the **Von Neumann Bottleneck**—the performance gap between the CPU and memory—is the primary obstacle to deploying intelligence at the "Edge" (e.g., in IoT sensors, cameras, or wearables).

### Our Solution: Domain-Specific Architecture (DSA)

Our design is not just a collection of gates; it is a **Domain-Specific Architecture (DSA)**. By moving computation directly into the data path (**Systolic Flow**) and prioritizing localized storage (**Buffers**), we effectively bypass the bottlenecks that plague general-purpose processors.

### Why Our Design Wins

#### ⚡ Energy-Efficiency
By minimizing global memory accesses, we reduce power consumption by **orders of magnitude** compared to standard ARM/RISC-V implementations.

#### ⏱️ Deterministic Latency
The Systolic Array ensures that inference happens in a **predictable number of cycles**—a requirement for real-time applications like robotics or autonomous monitoring.

#### 📈 Scalability
The modular nature of our PEs allows for future expansion into multi-layer pipelining without redesigning the core arithmetic logic.

---

## 🛠️ MVP Requirements: Implementation & Engineering Importance

### 1️⃣ INT8-based Convolution Layer (ConvNet Core)

**Why It Matters:**
Neural Networks are naturally resilient to quantization. Using 32-bit floating point (FP32) is often "over-engineering." By dropping to INT8, we achieve a **massive increase in computational density per square millimeter of silicon**.

**Our Implementation:**
- Mapped the convolution operation to an **8-bit signed integer pipeline**
- Utilized a **24-bit Accumulator** to prevent precision loss
- Prevents "clipping" of intermediate sum results
- Ensures high accuracy of the neural network despite low-bitwidth math
- Achieves optimal balance between **precision and efficiency**

**Key Benefits:**
