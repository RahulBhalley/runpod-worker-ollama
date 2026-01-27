import runpod
import os
from handler import handler

DEFAULT_MAX_CONCURRENCY = 8
max_concurrency = int(os.getenv("MAX_CONCURRENCY", DEFAULT_MAX_CONCURRENCY))

runpod.serverless.start(
    {
        "handler": handler,
        "concurrency_modifier": lambda x: max_concurrency,
        "return_aggregate_stream": True,
    }
)
