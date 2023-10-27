from fastapi import FastAPI, Body, Response
import uvicorn

app = FastAPI()

logs = []


@app.post("/save_log")
async def save_log(log: str = Body(..., media_type="text/plain")):
    logs.append(log)
    return {"message": "Log saved successfully"}


@app.get("/get_logs")
async def get_logs(response: Response):
    response.headers["Content-Type"] = "text/plain"
    return "\n".join(logs)

if __name__ == "__main__":
    uvicorn.run(app, host="localhost", port=8000)