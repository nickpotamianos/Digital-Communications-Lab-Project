# Digital Telecommunications Laboratory Project

This repository contains the implementation of the first set of laboratory exercises for the **Digital Telecommunications** course at the Department of Computer Engineering & Informatics, University of Patras.

## Table of Contents
- [Project Overview](#project-overview)
- [Requirements](#requirements)
- [Installation](#installation)
- [Usage](#usage)
- [Code Details](#code-details)
- [Results](#results)

## Project Overview

This project explores various aspects of digital telecommunications using MATLAB, focusing on the following key areas:
- **Information theory**: Estimation of pixel symbol probabilities from an image and calculation of entropy.
- **Huffman Coding**: Creation of a Huffman tree and analysis of code efficiency.
- **Binary Symmetric Channel (BSC)**: Simulation of BSC and calculation of mutual information and channel capacity.
- **DPCM**: Implementation of Differential Pulse Code Modulation (DPCM) encoding and decoding.

### Key Exercises:
1. **Probability and Entropy Calculations**:
   - Calculation of symbol probabilities from an image (e.g., "parrot.png").
   - Estimation of entropy using Shannon's formula.
   
2. **Huffman Coding**:
   - Construction of a Huffman tree and calculation of code lengths.
   - Efficiency analysis of Huffman coding.

3. **DPCM Coding**:
   - Implementation of a DPCM encoder and decoder.
   - Analysis of prediction error and quantization error with different bit depths (N) and predictor order (p).

## Requirements

- **MATLAB**: This project is written in MATLAB and requires MATLAB to run the scripts.
  
## Installation

To install and run the project locally:

1. Clone the repository:
    ```bash
    git clone https://github.com/your-username/digital-telecom-lab.git
    ```

2. Make sure you have MATLAB installed and configured on your system.

3. Open MATLAB, navigate to the project directory, and run the necessary scripts (e.g., `source.m`).

## Usage

### Running the Scripts

- To calculate pixel probabilities, entropy, and Huffman coding, run the following script in MATLAB:
  ```matlab
  run('source.m');
  ```
### Simulating the Binary Symmetric Channel (BSC)

To simulate the **Binary Symmetric Channel (BSC)** and compute mutual information and channel capacity, run the following MATLAB script:

```matlab
run('bsc_simulation.m');
```
##Code Details
Key Functions and Scripts

    Pixel Symbol Probability Calculation: The script reads an image file and calculates the probability of each pixel value occurring.

    matlab

[symbols, ~, idx] = unique(I);
counts = accumarray(idx(:), 1);
probabilities = counts / numel(I);

Entropy Calculation: Shannon's entropy formula is used to calculate the entropy of the image pixel values:

matlab

entropy = -sum(probabilities .* log2(probabilities));

Huffman Coding: Construction of the Huffman tree and calculation of the average code length and efficiency:

matlab

dict = huffmandict(symbols, probabilities);
avglen = sum(probabilities .* cellfun('length', dict(:, 2)));
efficiency = entropy / avglen;

DPCM Encoding and Decoding: The implementation of DPCM encoding and decoding using different predictor orders and quantization levels.

Example DPCM Code:

```matlab

    memory = zeros(p, 1);
    for i = 1:signalLength
        y(i) = t(i) - y_toned;
        y_hat(i) = my_quantizer(y(i), N, minValue, maxValue);
        y_toned = a' * memory;
    end
```
## Results

- **Entropy Calculation**:
    - The entropy of the image "parrot.png" was found to be approximately **3.7831 bits per symbol**.

- **Huffman Coding Efficiency**:
    - The efficiency of the Huffman coding for the pixel values was **0.9859**, indicating a highly efficient coding scheme.

- **DPCM Analysis**:
    - Increasing the predictor order (`p`) and the bit depth (`N`) significantly reduced the prediction and quantization error.
    - The Mean Squared Error (MSE) decreased as `N` increased from **1 bit** to **3 bits**.

- **BSC Simulation**:
    - The simulation of the Binary Symmetric Channel (BSC) showed that with a bit error probability of **p = 0.88**, the channel capacity was **C ≈ 0.467**.
