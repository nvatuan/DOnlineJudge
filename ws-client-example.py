import asyncio, websockets

async def to_server():
    uri = "ws://localhost:9987"
    async with websockets.connect(uri) as websocket:
            from json import dumps, loads
            kwargs = {}
            kwargs["processor"] = "PyPy3"
            kwargs["source"] = """
n = int(input())
a = [i for i in range(n)]
print(a[-1])
"""
            kwargs["tests"] = [("1", "0"), ("10","9")]
            kwargs["config"] = {}
            await websocket.send(dumps(kwargs))

            resCompile = loads(await websocket.recv())
            print(f"{resCompile}")
            resJudge = loads(await websocket.recv())
            print(f"{resJudge}")
            resVerdict = loads(await websocket.recv())
            print(f"{resVerdict}")
            print("Server closed the connection.")

asyncio.get_event_loop().run_until_complete(to_server())