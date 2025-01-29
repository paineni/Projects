# Detectron2 Integration with FiftyOne for Dataset Preparation & Management 🤖📊 

![Python version](https://img.shields.io/badge/Python%20version-3.7+-light)

![Framework](https://img.shields.io/badge/Framework-Detectron2-blue)

![Type](https://img.shields.io/badge/Type-Object%20Detection-green)

![License](https://img.shields.io/badge/License-MIT-green)

![Open Source Love](https://img.shields.io/badge/%E2%9D%A4%EF%B8%8F-Open%20Source-pink)

This repository provides tools to prepare datasets for **Detectron2**, utilizing **FiftyOne** for dataset management. It includes dataset splitting, annotation formatting, dataset registration, and model training.

---

## 📚 Key Features

- **Dataset Loading**: Import datasets into **FiftyOne** for easy visualization and management.
- **Dataset Splitting**: Split datasets into **train**, **test**, and **validation** sets with fixed random seed for reproducibility.
- **Detectron2 Compatibility**: Convert datasets into the format required by **Detectron2** and register them for seamless integration.
- **Visualization**: (Planned) Tools for visualizing datasets and annotations.
- **Model Training & Evaluation**: (Planned) Train and evaluate models using FiftyOne metrics.

---

## 🛠️ Setup Instructions

### Prerequisites

Ensure Python **3.7+** is installed on your system.

### Installation Steps

1. Clone the repository:

   ```bash
   git clone https://github.com/paineni/Projects.git
   cd Projects
   ```

2. Create and activate a virtual environment:

   ```bash
   python -m venv myenv
   myenv\Scripts\activate  # Windows
   source myenv/bin/activate  # macOS/Linux
   ```

3. Install dependencies:

   ```bash
   pip install fiftyone
   pip install -r requirements_git.txt
   ```

4. Place your dataset in the **prepared** directory.

---

## 🧑‍💻 Usage

### 1. Load Dataset

```python
import fiftyone as fo
dataset = fo.Dataset.from_dir(dataset_dir="prepared", dataset_type=fo.types.FiftyOneDataset)
```

### 2. Split Dataset

```python
def split_dataset(dataset):
    # Split into train, valid, and test
    ...
    dataset.save()
    return dataset
```

### 3. Convert to Detectron2 Format

```python
def get_fiftyone_dicts(dataset):
    # Convert dataset to Detectron2 format
    ...
    return dataset_dicts
```

### 4. Register Dataset with Detectron2

```python
from detectron2.data.datasets import register_coco_instances
register_coco_instances("my_dataset", {}, "path/to/annotations.json", "path/to/images")
```

---

## 🤝 Contributing

Feel free to open issues or submit pull requests to improve this project.

---

## 📜 License

This project is licensed under the **MIT License**.

