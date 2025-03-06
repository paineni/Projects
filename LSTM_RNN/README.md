# Next Word Prediction Using LSTM 🤖📖

![Python](https://img.shields.io/badge/Python-3.7+-blue)
![Framework](https://img.shields.io/badge/Framework-TensorFlow-orange)
![License](https://img.shields.io/badge/License-MIT-green)
![Open Source](https://img.shields.io/badge/Open%20Source-%E2%9D%A4-red)
![NLTK](https://img.shields.io/badge/NLTK-Natural%20Language%20Toolkit-yellowgreen)
![Scikit-Learn](https://img.shields.io/badge/Scikit--Learn-ML-blue)
![LSTM-RNN](https://img.shields.io/badge/LSTM-RNN-deepblue)
![Streamlit](https://img.shields.io/badge/Streamlit-Web%20App-red)
![Early-Stopping](https://img.shields.io/badge/Early%20Stopping-Regularization-orange)

## 📌 Overview
This repository provides an implementation of a **Next Word Prediction** model using **Long Short-Term Memory (LSTM) networks**. The model is trained on **Shakespeare's Hamlet** text data and can predict the next word in a given sentence.

## 🚀 Key Features
- **Deployed on Streamlit Cloud**: The model is hosted on **Streamlit Cloud**, allowing users to interact with it online without any local setup.
- **Data Preprocessing**: Tokenization, sequence creation, and padding of textual data.
- **Deep Learning Model**: LSTM-based neural network for sequence prediction.
- **Training with Early Stopping**: Prevents overfitting by stopping when validation loss stops improving.
- **Model Deployment**: Interactive **Streamlit app** for real-time next-word prediction.
- **Pre-trained Model**: The trained LSTM model is saved and can be reused for further predictions.

---
## 🛠️ Setup Instructions

### **Prerequisites**
Ensure you have **Python 3.10+** installed.
Ensure you have **Python 3.7+** installed.

### **Installation Steps**
Clone the repository:
```sh
git clone https://github.com/paineni/Projects.git
cd LSTM_RNN
```

Create and activate a virtual environment:
```sh
python -m venv myenv
# Windows
myenv\Scripts\activate
# macOS/Linux
source myenv/bin/activate
```

Install dependencies:
```sh
pip install -r requirements.txt
```

---
## 🧑‍💻 Usage

### **🌐 Try it Online**
The model is deployed on **Streamlit Cloud** and can be accessed here:

🔗 **[Live Demo](your-streamlit-app-link)**


### **1️⃣ Train the Model**
Run the training script to preprocess data and train the LSTM model:
```sh
python lstm_rnn.py
```
This will:
- Load **Shakespeare’s Hamlet** dataset.
- Tokenize and create input sequences.
- Train an LSTM model and save it (`next_word_lstm.keras`).
- Save the tokenizer (`tokenizer.pkl`).

### **2️⃣ Run the Prediction App**
To launch the Streamlit web application:
```sh
streamlit run app.py
```
You can enter a partial sentence, and the model will predict the next word!

---
## 🔬 Model Architecture
The LSTM model consists of:
- **Embedding Layer**: Converts words into dense vectors.
- **LSTM Layers**: Captures sequential dependencies.
- **Dropout**: Prevents overfitting.
- **Dense Layer with Softmax Activation**: Predicts the next word.

---
## 📜 License
This project is licensed under the **MIT License**.

---
## 🤝 Contributing
Feel free to **open issues** or submit **pull requests** to improve this project. Suggestions are welcome!

---
## 📞 Contact
For any queries, reach out via **[your-email@example.com](mailto:your-email@example.com)** or open an issue in the repository.

🚀 Happy Coding!

