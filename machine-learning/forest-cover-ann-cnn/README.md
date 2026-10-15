This project explores supervised learning using ANNs (Artificial Neural Networks) and CNNs (Convolutional Neural Networks). 

I trained three models across two datasets:
  - Forest Cover Dataset (simple ANN and classification model)
  - Fashion MNIST (image classification using ANN)
  - Fashion MNIST (image classification using CNN)
All of my models were implemented in PyTorch and trained in Google Colab.

_______________________________________________________________________________________________________

PART ONE - FOREST COVER CLASSIFICATION (ANN):

Objective: Build a neural network to classify forest cover types using 10 numerical features.

Data:
  - File: forest_cover.csv
  - 10 numerical features
  - 2 categorical features (ignored)
  - Labels originally 1-7, encoded to 0-6

Model Architecture:
  nn.Sequential(
    nn.Linear(10, 32),
    nn.ReLU(),
    nn.Linear(32, 16),
    nn.ReLU(),
    nn.Linear(16,7)
  )

Training Setup: 
  - Epochs: 220
  - Batch size: 32
  - Learning rate: 0.002
  - Validation split: 0.2
  - Seed: 1

Results:
  -Final Validation Accuracy: ~0.705
  - My accuracy remained above 0.70 for many final epochs = Goal achieved!

______________________________________________________________________________________________________

PART TWO - FASHION MNIST CLASSIFICATION (ANN):

Objective: Train a neural network on the Fashion MNIST dataset using flattened pixel values.

Data:
  - 60,000 grayscale images
  - Pixel values scaled to 0-1
  - 28x28 flattened to 784 features

Model Architecture:
  nn.Sequential(
    nn.Linear(784, 128),
    nn.ReLU(),
    nn.Linear(128, 64),
    nn.ReLU(),
    nn.Linear(64,32)
    nn.ReLU(),
    nn.Linear(32, 16)
  )

Training Setup: 
  - Epochs: 30
  - Batch size: 64
  - Learning rate: 0.001
  - Validation split: 0.2

Results:
  -Final Validation Accuracy: ~0.902
  - My accuracy went above the required 0.87 threshold; Stable performance across final epochs

_______________________________________________________________________________________________________

PART THREE - FASHION MNIST CLASSIFICATION (CNN):

Objective: Build a CNN to improve performance over the ANN model I previously created.

Data:
  - 60,000 grayscale images reshaped to (60000, 1, 28, 28) for CNN input

Model Architecture:
  nn.Sequential(
    nn.Conv2d(1, 8, 3, 1, padding='same'),
    nn.ReLU(),
    nn.MaxPool2d(2),
    nn.Conv2d(8, 16, 3, 1, padding='same'),
    nn.ReLU(),
    nn.MaxPool2d(2),
    nn.Flatten(),
    nn.Linear(784, 64),
    nn.ReLU(),
    nn.Linear(64, 10),
)

Training Setup: 
  - Epochs: 30
  - Batch size: 64
  - Learning rate: 0.001
  - Validation split: 0.2

Results:
  -Final Validation Accuracy: ~0.934
  - My accuracy went above the required 0.91 threshold; the CNN outperformed the ANN model

_____________________________________________________________________________________________________

Key Takeaways:
  1) ANN works well for both tabular and image data, but CNN is stronger for image classification.
  2) Scaling and reshaping the data is essential for stable training
  3) GPU acceleration is required for CNN training in Google Colab

___________________________________________________________________________________________________________

NOTEBOOK LINK:
https://colab.research.google.com/drive/1K9GjBdsx9nsuyzUW8gIz8oc2UbkKebiS?usp=sharing
