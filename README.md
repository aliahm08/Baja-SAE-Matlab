# Baja-SAE-Matlab

Unit conversions and structural equivalency testing to verify tubing standards for an SAE Baja off-road vehicle.

---

## Overview

This MATLAB script performs **equivalency calculations** for two round steel tube sizes (Primary vs. Secondary). It computes and compares:

* **Area moment of inertia** *(I)*
* **Bending stiffness** *(E · I)*
* **Yield-based bending strength estimate** *(Sy · I / c)*

These outputs help validate that alternate tube sizes maintain acceptable stiffness/strength behavior for chassis/roll-cage use.

---

## Project Info

* **Title:** Equivalency Calculations
* **Team:** Baja SAE — George Washington University
* **Year:** 2015–2016
* **Programmers:** Ali Ahmed, Jacari Matthews
* **Leader:** Tyler Miller

---

## What the Script Computes

### 1) Tube geometry (Primary vs. Secondary)

The script defines tube dimensions using **outer diameter (OD)** and **inner diameter (ID)**.

**Primary Tube**

* OD = 1.25 in
* ID = 1.12 in

**Secondary Tube**

* OD = 1.00 in
* ID = 0.87 in

Dimensions are converted using:

* `convlength(value, 'in', 'm')`

---

### 2) Material properties

The script uses:

* **Elastic modulus:** `E = 205.`
* **Yield strength:** `Sy = convpres(109000, 'psi', 'Pa') * 10^(-6)`

> Note: `E` and `Sy` are treated as numeric constants in the script. If you need strict dimensional correctness, normalize all values into a consistent unit system.

---

### 3) Radius values

Outer radius is computed in **mm**:

* `c1 = (OD1/2) * 10^3`
* `c2 = (OD2/2) * 10^3`

---

## Calculations

### 1) Area moment of inertia (tube)

For a circular tube:

[
I = \frac{\pi}{64}\left(OD^4 - ID^4\right)
]

Computed as:

```matlab
I1 = (pi * ((OD1*10.^3.)^4. - (ID1*10.^3.)^4.)) / 64.;
I2 = (pi * ((OD2*10.^3.)^4. - (ID2*10.^3.)^4.)) / 64.;
```

Expected outputs (from script comments):

* `I1 ≈ 1.7732e+04` *(mm^4)*
* `I2 ≈ 8.7264e+03` *(mm^4)*

---

### 2) Bending stiffness

[
B = E \cdot I
]

```matlab
B1 = E * I1;
B2 = E * I2;
```

Expected outputs:

* `B1 ≈ 3.6351e+6`
* `B2 ≈ 1.7889e+6`

---

### 3) Bending strength (yield-based estimate)

[
BS = \frac{S_y \cdot I}{c}
]

```matlab
BS1 = (Sy * I1)/c1;
BS2 = (Sy * I2)/c2;
```

Expected outputs:

* `BS1 ≈ 8.3946e+5` *(N·mm, per script comment)*
* `BS2 ≈ 5.1639e+5` *(N·mm, per script comment)*

---

## Requirements

* MATLAB
* Access to unit conversion functions:

  * `convlength`
  * `convpres`

If MATLAB errors on these functions, verify the required toolbox is installed or provide custom conversion helpers.

---

## How to Run

1. Open MATLAB.
2. Save the script (example: `equivalency_calculations.m`).
3. Run the script.

Key variables produced in the workspace:

* `I1, I2` — moments of inertia
* `B1, B2` — bending stiffness
* `BS1, BS2` — bending strength estimates

---

## Notes / Assumptions

* Tube geometry is converted from inches → meters, then converted to **mm** inside the inertia calculation.
* `I` is computed in **mm^4**, and `c` is computed in **mm**.
* `Sy` is converted from psi → Pa and then scaled by `10^-6`.

If you plan to use absolute physical values (not just comparisons), standardize all units (e.g., full SI or full mm–MPa system).

---

## Suggested Extensions

* Print results using `fprintf` for reporting.
* Add ratio comparisons:

  * `I2/I1`, `B2/B1`, `BS2/BS1`
* Wrap calculations into a function to test multiple tube sizes quickly.
* Add explicit rule thresholds for SAE Baja equivalency checks.

---

## Suggested Repository Layout

```text
Baja-SAE-Matlab/
  equivalency_calculations.m
  README.md
```

If using custom conversion helpers:

```text
  convlength.m
  convpres.m
```
