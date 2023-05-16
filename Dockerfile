# Define build arguments
ARG PYTHON_VERSION
ARG POETRY_VERSION

# Use Python Alpine image with specified Python version
FROM python:${PYTHON_VERSION}-alpine AS poetry-install

# Set environment variables for Poetry
ENV POETRY_VERSION=${POETRY_VERSION} \
    POETRY_HOME="/opt/poetry" \
    POETRY_VIRTUALENVS_IN_PROJECT=true \
    POETRY_NO_INTERACTION=1 \
    PYSETUP_PATH="/opt/pysetup" \
    VENV_PATH="/opt/pysetup/.venv"

# Prepend Poetry and venv directories to PATH
ENV PATH="$POETRY_HOME/bin:$VENV_PATH/bin:$PATH"

# Install dependencies required for Poetry and the project
RUN apk update && apk add --no-cache \
    curl \
    build-base \
    git \
    python3-dev \
    && rm -rf /var/cache/apk/* \
    && curl -sSL https://install.python-poetry.org | python3 -

# Set working directory
WORKDIR $PYSETUP_PATH

# Copy the pyproject.toml file to the working directory
COPY pyproject.toml ./

# Set the entrypoint as "poetry" and the default command as "--version"
ENTRYPOINT ["poetry"]
CMD ["--version"]
