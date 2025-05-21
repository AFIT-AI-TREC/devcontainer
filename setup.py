from setuptools import setup, find_packages

setup(
    name="aitrec-toolbox",
    version="0.1.0",
    description="Docker image for TensorFlow/Pytorch GPU development, now installable via a venv.",
    author="AI TREC",
    author_email="afit.en.aitrec@us.af.mil",
    packages=find_packages(),
    install_requires=[
        "numpy",
        "pandas",
        "matplotlib",
        "opencv-python",
        "scikit-learn",
        "seaborn",
        "tqdm",
        "plotly",
        "gif",
        "ray[data,train,tune,serve]",
        "optuna",
        "hyperopt",
        "tensorflow[and-cuda]",
        "tensorflow_datasets",
        "torch",
        "torch-geometric"
    ],
)