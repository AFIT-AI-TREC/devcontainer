# Python AI/ML Devcontainer Example

This repository provides examples for setting up a robust Python development environment for AI and Machine Learning projects. The primary focus is on using Docker to create a reproducible, GPU-enabled environment that integrates seamlessly with Visual Studio Code via the [Dev Containers](https://code.visualstudio.com/docs/devcontainers/containers) extension.

Two types of containers are provided by different version tags. Tags ending in '-rl' contain extra libraries for Reinforcement Learning dev.
## Quick Start: Using the Prebuilt Docker Image in VS Code

1. **Pull the Docker Image**

    Pull the latest prebuilt image:

    ```bash
    docker pull afitaitrec/afitaitrec:latest
    ```

2. **Set Up VS Code Dev Container**

    - Create a `.devcontainer` folder in your project (if not already present).
    - Add a `devcontainer.json` file referencing the image:

      ```json
      {
            "name": "AI Dev Container",
            "image": "afitaitrec/afitaitrec:latest",
            "workspaceFolder": "/workspace",
            "mounts": [
                {
                    "source": "${localWorkspaceFolder}",
                    "target": "/workspace",
                    "type": "bind"
                }
            ]
        }
      ```
    - Open the project in VS Code and select **Reopen in Container** when prompted.

## Building the Docker Image Locally

If you want to build the image yourself:

```bash
docker build -t my-ml-devcontainer:latest -f Dockerfile .
```

You can then use this local image in your `devcontainer.json` as above.

### Using Docker Compose (Optional)

If your project requires multiple services (e.g., databases, message queues), you can use `docker-compose.yml`:

```bash
docker-compose up --build
```

Reference the service in your `devcontainer.json`:
```json
{
  "name": "AI/ML Dev Container",
  "dockerComposeFile": "../docker-compose.yml",
  "service": "<service-name>",
  "workspaceFolder": "/workspace"
}
```

## Alternative: Creating the Environment Without Docker

If you prefer not to use Docker, you can set up the environment directly on your machine:

### Using `requirements.txt`

```bash
python3 -m venv .venv
source .venv/bin/activate  # On Windows: .venv\Scripts\activate
pip install --upgrade pip
pip install -r requirements.txt
```

### Using `pyproject.toml` or `setup.py`

If your project uses [PEP 517/518](https://www.python.org/dev/peps/pep-0517/) standards:

```bash
pip install .
```
Or, with [Poetry](https://python-poetry.org/):
```bash
poetry install
```

## Files in This Repository

- `Dockerfile`: Defines the GPU-enabled Python environment with common AI/ML tools.
- `requirements.txt`: Lists core Python dependencies.
- `pyproject.toml` and `setup.py`: For advanced dependency and project management.
- `docker-compose.yml`: Example for multi-service setups.
- `gpu_test.py`: Simple script to test GPU access.

## Notes
- The default Docker image is based on TensorFlow's GPU Jupyter image and includes common OS and Python packages for AI/ML development.
- You can customize the Dockerfile or requirements as needed for your project.

---

For more details, see the comments in the `Dockerfile` and example configuration files.
