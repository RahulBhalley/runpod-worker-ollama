# Runpod serverless runner for ollama

## How to use

Start a runpod serverless with the docker container ``svenbrnn/runpod-ollama:latest``. Set ``OLLAMA_MODEL_NAME`` environment to a model from ollama.com to automatically download a model.
A mounted volume will be automatically used.

[![RunPod](https://api.runpod.io/badge/SvenBrnn/runpod-worker-ollama)](https://www.runpod.io/console/hub/SvenBrnn/runpod-worker-ollama)

## Environment variables

| Variable Name       | Description                              | Default Value       |
|---------------------|------------------------------------------|---------------------|
| `OLLAMA_MODEL_NAME` | The name of the model to download        | NULL                |

## Test requests for runpod.io console

See the [test_inputs](./test_inputs) directory for example test requests. 


## Streaming

Streaming for openai requests are fully working.

## Preload model into the docker image

See the [embed_model](./embed_model/) directory for instructions.

## Licence

This project is licensed under the Creative Commons Attribution 4.0 International License. You are free to use, share, and adapt the material for any purpose, even commercially, under the following terms:

- **Attribution**: You must give appropriate credit, provide a link to the license, and indicate if changes were made. You may do so in any reasonable manner, but not in any way that suggests the licensor endorses you or your use.
- **Reference**: You must reference the original repository at [https://github.com/svenbrnn/runpod-worker-ollama](https://github.com/svenbrnn/runpod-worker-ollama).

For more details, see the [license](https://creativecommons.org/licenses/by/4.0/).

---

## README – Local Build & Run Commands 🚀

Below is a **clean, minimal command sequence** extracted from your terminal session, suitable for a README.
Noise, retries, and logs are intentionally removed.

---

## 1. Clone the repository

```bash
gh repo clone RahulBhalley/runpod-worker-ollama
cd runpod-worker-ollama
```

---

## 2. Build Docker image (Apple Silicon compatible)

> **Important:** Force `linux/amd64` on Apple Silicon (M1/M2/M3)

```bash
docker build -t ollama-runpod-test --platform linux/amd64 .
```

---

## 3. Run container (example: `llama3`)

```bash
docker run --rm \
  --platform linux/amd64 \
  -p 8080:8080 \
  -p 11434:11434 \
  -e PORT_HEALTH=8080 \
  -e OLLAMA_MODEL_NAME=llama3 \
  ollama-runpod-test
```

---

## 4. Run container (example: `gemma3:4b`)

```bash
docker run --rm \
  --platform linux/amd64 \
  -p 8080:8080 \
  -p 11434:11434 \
  -e PORT_HEALTH=8080 \
  -e OLLAMA_MODEL_NAME=gemma3:4b \
  ollama-runpod-test
```

---

## 5. Fix “port already allocated” (if needed)

```bash
sudo lsof -i :8080
sudo kill -9 <PID>
```

---

## 6. Optional: Docker cleanup (disk / build cache issues)

```bash
docker system prune -a
docker volume prune
```

---

## 7. Health & API endpoints

* **Health check:** `http://localhost:8080`
* **Ollama API:** `http://localhost:11434`
* **List models:**

  ```bash
  curl http://localhost:11434/api/tags
  ```

---

## Notes ⚠️

* Platform warning (`amd64` vs `arm64`) is **expected** on macOS ARM.
* First run **downloads model weights** (3–5 GB).
* CPU-only mode is normal unless GPU passthrough is configured.