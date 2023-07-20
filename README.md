# Bike_Safety_project

Bike Safety Project - BiLSTM Model Deployment on Nano 33 iot

Overview
The Bike Safety Project is a MATLAB-based project that utilizes accelerometer and gyroscope datasets to classify bike movements for enhancing safety measures. The project involves developing a Bidirectional Long Short-Term Memory (BiLSTM) model in MATLAB, and subsequently quantizing the model to deploy it on the target device. This deployment will enable real-time classification of bike movements using the on-board sensors, making it a practical and portable solution for bike safety.

Features
Utilizes accelerometer and gyroscope datasets for bike movement classification.
BiLSTM model for sequence data processing in MATLAB.
Quantization of the model for efficient deployment on Arduino Nano 33 IoT.
Real-time classification of bike movements directly on the Nano 33 IoT board.

Prerequisites
Before using this project, make sure you have the following:

MATLAB: Install MATLAB with the Deep Learning Toolbox for model development.
Target Device: The board itself, used for model deployment.
Accelerometer and Gyroscope Dataset: Collect and preprocess the dataset for training the BiLSTM model.

Usage
1. Data Preprocessing
Ensure that you have a labeled dataset containing accelerometer and gyroscope data for different bike movements (e.g., turning left, turning right, bump, etc.). The dataset should be split into training and testing sets.

2. BiLSTM Model Development
In MATLAB, execute the script that builds and trains the BiLSTM model on the preprocessed dataset. The model should be designed to classify the different bike movements accurately. Fine-tune the hyperparameters as needed for optimal performance.

3. Model Quantization
Quantize the trained BiLSTM model to reduce its size and make it suitable for deployment on the Target Device.

Acknowledgments
I  extend our heartfelt gratitude to Dr. Deepak Gangaradhan Sir and  Usha Mam for their invaluable guidance, mentorship, and support throughout the development of this project. Their expertise and encouragement played a crucial role in the successful completion of the Bike Safety Project.
