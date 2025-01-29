# VGG16-SVM Image Classification Model 🖼️🤖

![Python version](https://img.shields.io/badge/Python%20version-3.x-light)
![Framework](https://img.shields.io/badge/Framework-TensorFlow-blue)
![Type](https://img.shields.io/badge/Type-Image%20Classification-green)
![License](https://img.shields.io/badge/License-Public-green)
![Open Source Love](https://img.shields.io/badge/%E2%9D%A4%EF%B8%8F-Open%20Source-pink)

This project demonstrates the process of using a **pre-trained VGG16 model** to extract features from images and then applying a **Support Vector Machine (SVM)** classifier to classify the images into two categories. The project leverages deep learning and machine learning techniques for image feature extraction and classification.

---

## 📚 Project Workflow

### 1. **Data Preparation and Feature Extraction**
   - **VGG16 Model**: The project begins by loading a pre-trained VGG16 model, specifically fine-tuned for the task.
   - **Feature Extraction**: Features are extracted from the images by removing the final layers of the VGG16 model and keeping the output of the Flatten layer (before the fully connected layers). These features are saved into a pickle file for later use.
   - **Training Data**: Feature extraction is performed on the training dataset, with features stored in `/content/gdrive/MyDrive/features_till_flatten.pkl`.
   - **Validation Data**: Features are extracted from the validation dataset and stored in `/content/gdrive/MyDrive/features_till_flatten_validation.pkl`.
   - **Testing Data**: Features are also extracted from the testing dataset, stored in `/content/gdrive/MyDrive/features_till_flatten_testing.pkl`.

### 2. **Support Vector Machine (SVM) Model**
   - **SVM Classifier**: After feature extraction, an SVM classifier is trained using the features from the training dataset. The SVM is tuned using a **Grid Search** approach to find the best hyperparameters (C and kernel).
   - **Grid Search**: The SVM model is evaluated using **10-fold cross-validation** to identify the best performing combination of hyperparameters. The optimal parameters found are `C=1.3` and `kernel='sigmoid'`.
   - **Model Evaluation**: The accuracy on the validation set is calculated, with the best model achieving an accuracy of **72.22%**.

### 3. **Model Testing**
   - The final model is used to make predictions on the validation data. Predictions are printed alongside the true labels to demonstrate the model's performance on unseen data.

### 4. **Results**
   - The model achieved an accuracy of **96.95%** on the training set using 10-fold cross-validation.
   - The best model after fine-tuning achieved an accuracy of **72.22%** on the validation set.

---

## 🚀 Setup Instructions

1. **Clone the repository:**
   ```bash
   git clone https://github.com/paineni/Projects.git
   cd Projects/flat_panel
   ```

2. **Run the Jupyter Notebook:**
   - Open the notebook in Google Colab or Jupyter Notebook to execute the code and visualize the results.

---

## 🤝 Contributing

Contributions are welcome! Feel free to open issues or submit pull requests to enhance this project. 💡

---

## 📜 License

This project is licensed under the **Public License**. Feel free to use it for your own projects! 🎉


