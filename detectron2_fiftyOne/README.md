# Detectron2 Fiftyone

This repository contains tools and scripts for preparing datasets to be used with Detectron2, a popular object detection and segmentation framework. The project leverages FiftyOne for dataset management and provides functionality to split datasets, format annotations, register datasets with Detectron2 also train and evaluate the model performance.

---

## Features

### 1. Dataset Loading
- Import datasets into FiftyOne from a specified directory.
- Support for the `FiftyOneDataset` format.

### 2. Dataset Splitting
- Divide the dataset into training, validation, and testing subsets.
- Ensures reproducibility by using a fixed random seed.
- Tags samples with appropriate labels (`train`, `valid`, `test`).

### 3. Detectron2 Compatibility
- Converts dataset annotations into the format required by Detectron2, including bounding boxes and metadata.
- Registers the dataset in Detectron2 for seamless integration.

### 4. Visualization Tools
- (Planned) Visualization utilities to inspect dataset annotations and splits.

### 4. Train and Evaluate the model
- Train and evaluate the metrics the appropriate metrics using fifty-one evaluation
---

## Installation

### Prerequisites
Ensure that Python 3.7 or higher is installed on your system.

### Steps
1. Clone the repository:
   ```bash
   git clone https://github.com/paineni/Projects.git
   cd Projects
   ```

2. Create and activate a virtual environment:
   ```bash
   python -m venv myenv
   myenv\Scripts\activate  # On Windows
   source myenv/bin/activate  # On macOS/Linux
   ```

3. Install dependencies:
   ```bash
   pip install -r requirements.txt
   pip install -r requirements_git.txt
   ```

4. Ensure your dataset is placed in the `prepared` directory. Modify paths in the notebook if necessary.

---

## Usage

### Step 1: Load the Dataset
Load your dataset into FiftyOne using the following command:
```python
import fiftyone as fo

dataset = fo.Dataset.from_dir(
    dataset_dir="prepared",
    dataset_type=fo.types.FiftyOneDataset,
)
```

### Step 2: Split the Dataset
Use the `split_dataset` function to divide the dataset into training, validation, and testing subsets:
```python
def split_dataset(dataset):
    # Tag test images.
    testset_view = dataset.take(round(0.1 * len(dataset)), seed=42)
    testset_view.tag_samples("test")

    # Split remaining images into train and valid.
    nontestset_view = dataset.match_tags("test", bool=False)
    validset_view = nontestset_view.take(
        round(0.2 * len(nontestset_view)), seed=42
    )
    validset_view.tag_samples("valid")
    nontestset_view.match_tags("valid", bool=False).tag_samples("train")

    dataset.save()
    return dataset
```

### Step 3: Convert Dataset for Detectron2
Convert the dataset into Detectron2 format:
```python
def get_fiftyone_dicts(dataset):
    dataset.compute_metadata()

    dataset_dicts = []
    for sample in dataset:
        height = sample.metadata["height"]
        width = sample.metadata["width"]
        record = {}
        record["file_name"] = sample.filepath
        record["image_id"] = sample.id
        record["height"] = height
        record["width"] = width

        objs = []
        for det in sample.ground_truth.detections:
            tlx, tly, w, h = det.bounding_box
            bbox = [int(tlx*width), int(tly*height), int(w*width), int(h*height)]

            obj = {
                "bbox": bbox,
                "bbox_mode": BoxMode.XYWH_ABS,
                "category_id": dataset.default_classes.index(det.label),
            }
            objs.append(obj)

        record["annotations"] = objs
        dataset_dicts.append(record)

    return dataset_dicts
```

### Step 4: Register the Dataset
Register the dataset with Detectron2 for training and evaluation:
```python
from detectron2.data.datasets import register_coco_instances
from detectron2.data import MetadataCatalog, DatasetCatalog

register_coco_instances("my_dataset", {}, "path/to/annotations.json", "path/to/images")
```

---

## Dependencies
- Python 3.7+
- [FiftyOne](https://voxel51.com/fiftyone/)
- [Detectron2](https://github.com/facebookresearch/detectron2)
- NumPy, OpenCV, Matplotlib, Pandas


---

## Contributing
Contributions are welcome! Feel free to open issues or submit pull requests to improve this project.

---

## License
This project is licensed under the MIT License. See the `LICENSE` file for details.

