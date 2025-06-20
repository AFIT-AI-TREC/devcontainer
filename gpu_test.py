"""Test if GPU is available for TensorFlow."""

import tensorflow as tf

print(tf.config.list_physical_devices("GPU"))
