import asyncio, websockets

async def to_server():
    uri = "ws://localhost:9998"
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

        tup = loads(await websocket.recv())
        print("Judge results:", tup[0])
        print("Compile results:", tup[1])
        print("Server closed the connection.")

asyncio.get_event_loop().run_until_complete(to_server())


async def pypy3_test():
    uri = "ws://localhost:9998"
    async with websockets.connect(uri) as websocket:
        from json import dumps, loads
        kwargs = {}
        kwargs["processor"] = "PyPy3"
        kwargs["source"] = """
n = int(input())
a = [i for i in range(n)]
print(a[-1])
"""
        kwargs["tests"] = [("1", "0"), ("10","9"), ("1000", "999")]
        kwargs["config"] = {}
        await websocket.send(dumps(kwargs))

        tup = loads(await websocket.recv())
        print("Judge results:", tup[0])
        print("Compile results:", tup[1])
        print("Server closed the connection.")
    
    async with websockets.connect(uri) as websocket:
        from json import dumps, loads
        kwargs = {}
        kwargs["processor"] = "PyPy3"
        kwargs["source"] = """
a, b = map(int, input().split())
print(a//b)
"""
        kwargs["tests"] = [("4 2", "2"), ("1 1","1"), ("0 0", "0")]
        kwargs["config"] = {}
        await websocket.send(dumps(kwargs))

        tup = loads(await websocket.recv())
        print("Judge results:", tup[0])
        print("Compile results:", tup[1])
        print("Server closed the connection.")

    async with websockets.connect(uri) as websocket:
        from json import dumps, loads
        kwargs = {}
        kwargs["processor"] = "PyPy3"
        kwargs["source"] = """
while True: pass
"""
        kwargs["tests"] = [("1", "0")]
        kwargs["config"] = {}
        await websocket.send(dumps(kwargs))

        tup = loads(await websocket.recv())
        print("Judge results:", tup[0])
        print("Compile results:", tup[1])
        print("Server closed the connection.")

    async with websockets.connect(uri) as websocket:
        from json import dumps, loads
        kwargs = {}
        kwargs["processor"] = "PyPy3"
        kwargs["source"] = """
n = int(input())
arr = list(range(0, 100000000))
print(arr[0])
"""
        kwargs["tests"] = [("1", "0")]
        kwargs["config"] = {}
        await websocket.send(dumps(kwargs))

        tup = loads(await websocket.recv())
        print("Judge results:", tup[0])
        print("Compile results:", tup[1])
        print("Server closed the connection.")