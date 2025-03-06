#!/usr/bin/env python
# coding: utf-8

# ## Project Description: Next Word Prediction Using LSTM
# This project aims to develop a deep learning model for predicting the next word in a given sequence of words.

# 🔹 Import all necessary libraries
import nltk
import numpy as np
import pandas as pd
import pickle
import tensorflow as tf
from nltk.corpus import gutenberg
from sklearn.model_selection import train_test_split
from tensorflow.keras.models import Sequential
from tensorflow.keras.layers import Embedding, LSTM, Dense, Dropout
from tensorflow.keras.preprocessing.text import Tokenizer
from tensorflow.keras.preprocessing.sequence import pad_sequences
from tensorflow.keras.callbacks import EarlyStopping

# 🔹 Download necessary dataset
nltk.download('gutenberg')

# 🔹 Load the text dataset (Shakespeare's Hamlet)
data = gutenberg.raw('shakespeare-hamlet.txt')

# Save to a file
with open('hamlet.txt', 'w') as f:
    f.write(data)

# 🔹 Load and preprocess the dataset
with open('hamlet.txt', 'r') as file:
    data = file.read().lower()

# 🔹 Tokenization: Creating word index
tokenizer = Tokenizer()
tokenizer.fit_on_texts([data])
total_words = len(tokenizer.word_index) + 1  # Add 1 for padding index

# 🔹 Create input sequences
input_sequences = []
for line in data.split('\n'):
    token_list = tokenizer.texts_to_sequences([line])[0]
    for i in range(1, len(token_list)):
        n_gram_sequence = token_list[:i + 1]
        input_sequences.append(n_gram_sequence)

# 🔹 Padding sequences
max_sequence_length = max([len(x) for x in input_sequences])
input_sequences = np.array(pad_sequences(input_sequences, maxlen=max_sequence_length, padding='pre'))

# 🔹 Create predictors (X) and labels (y)
predictors, Label = input_sequences[:, :-1], input_sequences[:, -1]
Label = tf.keras.utils.to_categorical(Label, num_classes=total_words)

# 🔹 Split data into training and testing sets
x_train, x_test, y_train, y_test = train_test_split(predictors, Label, test_size=0.2, random_state=42)

# 🔹 Build the LSTM Model
model = Sequential([
    Embedding(total_words, 100, input_length=max_sequence_length - 1),
    LSTM(150, return_sequences=True),
    Dropout(0.2),
    LSTM(100),
    Dense(total_words, activation='softmax')
])

# 🔹 Compile the model
model.compile(loss='categorical_crossentropy', optimizer='adam', metrics=['accuracy'])
model.summary()

# 🔹 Implement Early Stopping
early_stopping = EarlyStopping(monitor='val_loss', patience=15)

# 🔹 Train the model
model.fit(x_train, y_train, epochs=100, validation_data=(x_test, y_test), verbose=1)

# 🔹 Save the trained model
model.save('next_word_lstm.keras')

# 🔹 Save the tokenizer
with open('tokenizer.pkl', 'wb') as f:
    pickle.dump(tokenizer, f, pickle.HIGHEST_PROTOCOL)

# 🔹 Function to predict the next word
def predict_next_word(model, tokenizer, text, max_sequence_length):
    token_list = tokenizer.texts_to_sequences([text])[0]
    if len(token_list) > max_sequence_length:
        token_list = token_list[-max_sequence_length:]
    token_list = pad_sequences([token_list], maxlen=max_sequence_length - 1, padding='pre')
    predicted = model.predict(token_list, verbose=0)
    predicted_word_index = np.argmax(predicted, axis=1)
    for word, index in tokenizer.word_index.items():
        if index == predicted_word_index:
            return word
    return None

# 🔹 Example: Predict the next word
input_text = "To be or not to be"
print(f"Input Text: {input_text}")
max_sequence_length = model.input_shape[1] + 1
predicted_word = predict_next_word(model, tokenizer, input_text, max_sequence_length)
print(f"Predicted Word: {predicted_word}")
