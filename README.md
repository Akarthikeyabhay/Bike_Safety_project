# Bike Safety Project - BiLSTM Model Deployment on Arduino Nano 33 IoT



## Overview

The Bike Safety Project is a MATLAB-based project that utilizes accelerometer and gyroscope datasets to classify bike movements for enhancing safety measures. The project involves developing a Bidirectional Long Short-Term Memory (BiLSTM) model in MATLAB, and subsequently quantizing the model to deploy it on the Arduino Nano 33 IoT board. This deployment will enable real-time classification of bike movements using the on-board sensors, making it a practical and portable solution for bike safety.

## Features

- Utilizes accelerometer and gyroscope datasets for bike movement classification.
- BiLSTM model for sequence data processing in MATLAB.
- Quantization of the model for efficient deployment on Arduino Nano 33 IoT.
- Real-time classification of bike movements directly on the Nano 33 IoT board.

## Prerequisites

Before using this project, make sure you have the following:

1. MATLAB: Install MATLAB with the Deep Learning Toolbox for model development.
2. Arduino IDE: Install the Arduino IDE to deploy the quantized model on Arduino Nano 33 IoT.
3. Arduino Nano 33 IoT: The board itself, used for model deployment.
4. Accelerometer and Gyroscope Dataset: Collect and preprocess the dataset for training the BiLSTM model.

## Usage

### 1. Data Preprocessing

Ensure that you have a labeled dataset containing accelerometer and gyroscope data for different bike movements (e.g., turning left, turning right, braking, etc.). The dataset should be split into training and testing sets.

### 2. BiLSTM Model Development

In MATLAB, execute the script that builds and trains the BiLSTM model on the preprocessed dataset. The model should be designed to classify the different bike movements accurately. Fine-tune the hyperparameters as needed for optimal performance.

### 3. Model Quantization

Quantize the trained BiLSTM model to reduce its size and make it suitable for deployment on the Arduino Nano 33 IoT board. This step is essential as the Nano 33 IoT has limited computational resources.

### 4. Arduino Deployment

Upload the quantized BiLSTM model to the Arduino Nano 33 IoT board using the Arduino IDE. The board's onboard accelerometer and gyroscope will be used for real-time data input.


## Acknowledgments

I extend my sincere appreciation to Dr. Deepak Gangaradhan for his expert guidance and support throughout this project. I am also grateful to Ms. Usha for her valuable collaboration and assistance. Special thanks to the creators of the Arduino Nano 33 IoT board and the MATLAB Deep Learning Toolbox for making this project possible.


