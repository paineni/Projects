# YOLOv1 (from scratch) with VGG-16 Integration: A Custom Object Detection Model 🚀

![Python version](https://img.shields.io/badge/Python%20version-3.10.10-light)
![Framework](https://img.shields.io/badge/Framework-PyTorch-blue)
![Type](https://img.shields.io/badge/Type-Object%20Detection-green)
![License](https://img.shields.io/badge/License-Public-green)
![Open Source Love](https://img.shields.io/badge/%E2%9D%A4%EF%B8%8F-Open%20Source-pink)

This repository implements **YOLOv1** from scratch, incorporating **VGG-16** as an integrated classifier in the training loop for object detection. The model is trained to detect objects by leveraging YOLO's architecture along with VGG-16 for classifying the detected objects in a single training .

---

## 📚 Key Features

- **End-to-End YOLOv1 Implementation**: Built from scratch, including custom **BeanDataset** and model architecture.
- **VGG-16 Integration**: Integrates **VGG-16** as a classifier in the training loop to enhance classification.
- **Bounding Box Processing**: Uses **Non-Maximum Suppression (NMS)** to refine predictions and remove redundant boxes.
- **Image Transformations**: Applies custom image transformations, including resizing and tensor conversion.

---

## 🛠️ Workflow Overview

1. **Dataset Preparation**:
   - Custom **BeanDataset** for training and testing.
   - Images and labels are organized into separate directories.

2. **Model Architecture**:
   - **YOLOv1**: A custom YOLOv1 implementation with 7x7 grid and 2 bounding boxes per grid cell.
   - **VGG-16**: Pretrained VGG-16 model integrated to enhance classification performance.

3. **Training Loop**:
   - The model is trained with custom loss functions to optimize both object detection and classification tasks.

4. **Bounding Box Refinement**:
   - **NMS** is applied to remove overlapping bounding boxes and retain the most confident detections.

5. **Evaluation**:
   - The model's performance is evaluated based on **Mean Average Precision (mAP)**.
   - Bounding boxes are visualized for qualitative assessment.

---

## 🖥️ How to Run

1. Clone the repository:
   ```bash
   git clone https://github.com/paineni/Projects.git
   cd yolov1
   ```

2. Install dependencies:
   ```bash
   pip install pytorch torchvision torchaudio
   ```

3. Train the model:
   ```bash
   python train.py
   ```

4. Run inference on test images:
   - test.ipynb

---

## 🤝 Contributing

Contributions are welcome! Feel free to open issues or submit pull requests to improve this project. 💡

---

## 📜 License

This project is licensed under the **Public License**. Feel free to use it for your own projects! 🎉
