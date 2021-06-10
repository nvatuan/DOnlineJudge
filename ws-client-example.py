import asyncio, websockets

kw_c = {
"processor": "C",
"source": "#include <stdio.h>\nint main(){ int a, b;\nscanf(\"%d%d\",&a,&b);printf(\"%d\",a+b);}\n",
"tests": [("1 1", "2"), ("3 4", "7")],
}
kw_cpp = {
"processor": "Cpp",
"source": "#include <iostream>\nusing namespace std;\nint main(){ int a, b;\ncin >> a >> b; cout << (a+b);}\n",
"tests": [("1 1", "2"), ("3 4", "7")],
}
kw_python = {
"processor": "Python",
"source": "print(sum(list(map(int, input().split()))))",
"tests": [("1 1", "2"), ("3 4", "7")],
}
kw_python3 = {
"processor": "Python3",
"source": "print(sum(list(map(int, input().split()))))",
"tests": [("1 1", "2"), ("3 4", "7")],
}
kw_pypy3 = {
"processor": "PyPy3",
"source": "print(sum(list(map(int, input().split()))))",
"tests": [("1 1", "2"), ("3 4", "7")],
}
kw_java = {
"processor": "Java",
"source": """
import java.util.Scanner;
public class Main {
        static Scanner sc = new Scanner(System.in);
        public static void main(String[] args) {
                int a = sc.nextInt();
                int b = sc.nextInt();
                System.out.println(a+b);
        }
}
""",
"tests": [("1 1", "2"), ("3 4", "7")],
}

async def send2server(kwargs, msg):
        print(msg)
        uri = "ws://localhost:9998"
        async with websockets.connect(uri) as websocket:
                from json import dumps, loads
                await websocket.send(dumps(kwargs))

                tup = loads(await websocket.recv())
                print("Judge results:", tup[0])
                print("Compile results:", tup[1])
                print("Server closed the connection.")

if __name__ == '__main__':
        #asyncio.get_event_loop().run_until_complete(to_server())
        asyncio.get_event_loop().run_until_complete(send2server(kw_c, "C"))
        asyncio.get_event_loop().run_until_complete(send2server(kw_cpp, "C++"))
        asyncio.get_event_loop().run_until_complete(send2server(kw_python, "Python"))
        asyncio.get_event_loop().run_until_complete(send2server(kw_python3, "Python3"))
        asyncio.get_event_loop().run_until_complete(send2server(kw_pypy3, "PyPy3"))
        asyncio.get_event_loop().run_until_complete(send2server(kw_java, "Java"))


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