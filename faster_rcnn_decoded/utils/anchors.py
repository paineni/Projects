import numpy as np


def generate_anchor_boxes(
    feature_map_size, window_size, aspect_ratios, scales
):
    """
    Generate anchor boxes for object detection given the feature
    map size, sub-sample size, aspect ratios, and anchor scales.

    Generate a grid of anchor boxes (bounding boxes) centered on each point of
    a feature map. Each center point has a set of anchors with different
    aspect ratios and scales.

    @param int feature_map_size: The size of the feature map (e.g., 50).
    @param int window_size: The stride of the sliding window or feature map
    stride (e.g., 16).
    @param list aspect_ratios: Aspect ratios of the anchors (e.g., [0.5, 1, 2]).
    @param list shapes: Anchor scales (e.g., [8, 16, 32]).
    :raises ValueError: If feature_map_size or window_size is not a positive
    integer.
    :raises TypeError: If aspect_ratios or shapes is not a list.
    :return np.ndarray: A numpy array of shape (num_anchors, 4) containing the
    anchor boxes, where each anchor box is defined by [y_min, x_min, y_max,
    x_max].
    """
    if not isinstance(feature_map_size, int) or feature_map_size <= 0:
        raise ValueError("feature_map_size most be a positive integer")
    if not isinstance(window_size, int) or window_size <= 0:
        raise ValueError("window_size most be a positive integer")
    if not isinstance(aspect_ratios, list) or not all(
        isinstance(r, (int, float)) for r in aspect_ratios
    ):
        raise TypeError("aspect_ratios must be a list of numbers")
    if not isinstance(scales, list) or not all(
        isinstance(s, (int, float)) for s in scales
    ):
        raise TypeError("sclaes must be a list of numbers")

    # Getting the centers of 16 by 16 patches
    # We will generate the rightbottom coordinate of each patch, and
    # then subtract 8 from it to get the center
    # This center will be used to generate anchor bboxes
    # Generate center points for the feature map
    corner_x = np.arange(
        window_size, (feature_map_size + 1) * window_size, window_size
    )
    corner_y = np.arange(
        window_size, (feature_map_size + 1) * window_size, window_size
    )

    # Create a grid of center points
    centre_pts = np.array([(x - 8, y - 8) for x in corner_x for y in corner_y])
    # Calculate total number of anchor boxes
    num_anchor_boxes = (
        feature_map_size * feature_map_size * len(aspect_ratios) * len(scales)
    )
    # initialize the anchor boxes array
    anchor_boxes = np.zeros((num_anchor_boxes, 4))

    index = 0
    # Iterate over each center point
    for c in centre_pts:
        corner_y, corner_x = c
        # Iterate over each combination of ratio and scale
        for i in range(len(aspect_ratios)):
            for j in range(len(scales)):
                # Calculate the height and width of the anchor
                h = window_size * scales[j] * np.sqrt(aspect_ratios[i])
                w = window_size * scales[j] * np.sqrt(1.0 / aspect_ratios[i])

                # Calculate the coordinates of the anchor box
                anchor_boxes[index, 0] = corner_y - h / 2.0  # y_min
                anchor_boxes[index, 1] = corner_x - w / 2.0  # x_min
                anchor_boxes[index, 2] = corner_y + h / 2.0  # y_max
                anchor_boxes[index, 3] = corner_x + w / 2.0  # x_max

                # Move to the next anchor index
                index += 1

    return anchor_boxes


def get_anchors_for_coordinate(anchor_boxes, coordinate):
    """
    Retrieve all anchor boxes whose centers match a specific image coordinate.

    Given a list of anchor boxes and a specific image coordinate (x, y),
    retrieve all anchor boxes whose centers match that coordinate.

    :param list anchor_boxes: List of anchor boxes in the format
    [y_min, x_min, y_max, x_max].
    :param tuple coordinate: Tuple (x, y) specifying the image coordinate.
    :return: List of anchor boxes whose centers match the specified coordinate.
    """

    x, y = coordinate
    result_anchor_boxes = []

    for anchor in anchor_boxes:
        center_x = (anchor[1] + anchor[3]) / 2
        center_y = (anchor[0] + anchor[2]) / 2
        if center_x == x and center_y == y:
            result_anchor_boxes.append(anchor)

    return result_anchor_boxes
