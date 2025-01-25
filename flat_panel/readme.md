# VGG16-SVM Image Classification Model

This project demonstrates the process of using a pre-trained VGG16 model to extract features from images and then applying a Support Vector Machine (SVM) classifier to classify the images into two categories. The project leverages deep learning and machine learning techniques for image feature extraction and classification.

## Project Workflow

### 1. **Data Preparation and Feature Extraction**
   - **VGG16 Model**: We start by loading a pre-trained VGG16 model, specifically fine-tuned for the task.
   - **Feature Extraction**: Using the model, features are extracted from the images by removing the final layers and keeping the output of the Flatten layer (before the fully connected layers). These features are saved into a pickle file for later use.
   - **Training Data**: The feature extraction is done on the training dataset and the features are stored in `/content/gdrive/MyDrive/features_till_flatten.pkl`.
   - **Validation Data**: Similarly, features are extracted from the validation data and stored in `/content/gdrive/MyDrive/features_till_flatten_validation.pkl`.
   - **Testing Data**: Features are also extracted from the testing data, stored in `/content/gdrive/MyDrive/features_till_flatten_testing.pkl`.

### 2. **Support Vector Machine (SVM) Model**
   - **SVM Classifier**: Once the features are extracted, an SVM classifier is trained using the features from the training dataset. The SVM is tuned using a Grid Search approach to find the best hyperparameters (C and kernel).
   - **Grid Search**: The SVM model is evaluated using a 10-fold cross-validation to find the best performing combination of hyperparameters. The best parameters are found to be `C=1.3` and `kernel='sigmoid'`.
   - **Model Evaluation**: The accuracy on the validation set is calculated, with the best model achieving an accuracy of **72.22%**.

### 3. **Model Testing**
   - The final model is used to make predictions on the validation data. Predictions are printed alongside the true labels to show how well the model performs on unseen data.

### 4. **Results**
   - The model achieved an accuracy of **96.95%** on the training set using 10-fold cross-validation.
   - The best model after fine-tuning achieved an accuracy of **72.22%** on the validation set.

---

## Requirements

- Python 3.x
- Keras
- TensorFlow
- Scikit-learn
- OpenCV
- Matplotlib
- NumPy

## Setup Instructions

1. **Clone the repository:**

   ```bash
   git clone https://github.com/paineni/Projects.git
