# Dockerize Poetry

Dockerized version of Poetry whose main purpose is to generate `poetry.lock` files, but, it allows you to run any Poetry commands as well.

Since there is incompatibility between versions of Poetry and generally tends to need to generate the `poetry.lock` file to be taken by containers that run services and install the dependencies from this file, this project was created to generate the file without having problems with the version of Poetry installed on the local machine.

## Tech Stack

The image is based on the [python:x.x-alpine](https://hub.docker.com/_/python/tags?page=1&name=alpine) images

| Application                                        |
| -------------------------------------------------- |
| [Python](https://www.python.org/)                  |
| [Docker](https://www.docker.com/)                  |
| [Poetry](https://python-poetry.org/)               |

## Build Docker image

To build the image you can run:

  ```shell
  docker build --no-cache --build-arg PYTHON_VERSION=<Python version you need to use> --build-arg POETRY_VERSION=<Poetry version you need to use> -t <Name you want the image to have> .
  ```

Example:

  ```shell
  docker build --no-cache --build-arg PYTHON_VERSION=3.11 --build-arg POETRY_VERSION=1.4.2 -t dockerize-poetry .
  ```

## Execute Poetry commands

Once you have built the image you can run any Poetry commands taking into count that the image container copy the `pyproject.toml` file from the root directory of this project.

If you need to modify or generate files from the container, for example, to generate, or update, the `poetry.lock` file you can set a volumen to the container that must be bound with the path of the `PYSETUP_PATH` variable showed in the Dockerfile.

At the moment this README was created the value was `PYSETUP_PATH="/opt/pysetup"`.

For instance, if you want to bind the container with the directory of this project to generate the `poetry.lock` file, you can execute:

  ```shell
  docker run --rm --name <Name you want the container to have> -v "$(pwd):/opt/pysetup" <Name given to the image at the time it was built> lock
  ```

Following the example of building the image, this command would be:

  ```shell
  docker run --rm --name dockerize-poetry -v "$(pwd):/opt/pysetup" dockerize-poetry lock
  ```

### Generate `poetry.lock` file

Exectute:

  ```shell
  docker run --rm --name <Name you want the container to have> -v "<local path to bind>:/opt/pysetup" <Name given to the image at the time it was built> lock
  ```

Following the example of building the image, this command would be:

  ```shell
  docker run --rm --name dockerize-poetry -v "$(pwd):/opt/pysetup" dockerize-poetry lock
  ```

### Generate `poetry.lock` file without updating the dependencies

Exectute:

  ```shell
  docker run --rm --name <Name you want the container to have> -v "<local path to bind>:/opt/pysetup" <Name given to the image at the time it was built> lock --no-update
  ```

Following the example of building the image, this command would be:

  ```shell
  docker run --rm --name dockerize-poetry -v "$(pwd):/opt/pysetup" dockerize-poetry lock --no-update
  ```
