import os
import uvicorn
from fastapi import FastAPI

app = FastAPI()

@app.get("/ping")
async def ping():
    """Health check endpoint for RunPod"""
    return {"status": "ok"}

def start_health_server():
    """Start the health check server"""
    port = int(os.getenv("PORT_HEALTH", "8080"))
    host = os.getenv("HOST_HEALTH", "0.0.0.0")
    
    print(f"Starting health server on {host}:{port}")
    uvicorn.run(app, host=host, port=port, log_level="warning")

if __name__ == "__main__":
    start_health_server()
