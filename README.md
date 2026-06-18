# Sum-rate-Maximization-and-Outage-Analysis-of-RIS-assisted-RSMA-System-under-EMI

MATLAB simulation code for "Sum-rate Maximization and Outage Analysis of RIS-Assisted RSMA Systems under Electromagnetic Interference." The repository implements alternating optimization-based beamforming and RIS phase-shift design for maximizing sum rate and evaluating outage performance in EMI environment.

## Content of Code Package

Here is a detailed description of the package:

The code is implemented in the MATLAB environment. By running the script `Main.m`, the simulation results corresponding to Figs. 5 and 6 of the paper can be reproduced. The framework can also be extended by modifying the alternating optimization (AO) procedure, RIS phase-shift design, and precoding strategies to evaluate and compare different multiple-access schemes, including RSMA, NOMA, and SDMA.

## Abstract of the Article

Rate-splitting multiple access (RSMA) and reconfigurable intelligent surfaces (RIS) are key enablers for 6G communications. This study examines a downlink multiple-input single-output system using RIS-assisted RSMA (RIS-RSMA) in the presence of electromagnetic interference (EMI). Although RIS improves wireless propagation through passive beamforming, it can also reflect EMI from ambient sources, which may disrupt the decoding order and limit system performance. To overcome this, we jointly optimize the transmit beamformer and phase shifts of the RIS using an alternating optimization approach. We derive and validate the analytical expressions for the outage probability (OP) and sum rate of the system via Monte Carlo simulations. The obtained results validate that RIS-RSMA reduces the OP by 60% and achieves a higher sum rate of 3.22 × 10^5 bit/s compared with RIS-assisted NOMA, and mitigates the impact of EMI.

## Requirements

* MATLAB R2024a

## Citation

If you use this code in your research, please cite:

N. Soudarsanane and S. Maruthu, "Sum-rate Maximization and Outage Analysis of RIS-Assisted RSMA Systems under Electromagnetic Interference."
