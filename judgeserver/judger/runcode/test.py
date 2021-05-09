from dockerjudge import judge
from dockerjudge.processor import GCC, PyPy, OpenJDK

# o = judge (
#     GCC(GCC.Language.c),
#     b'''
#         #include <stdio.h>
#         
#         int main() {
#             int a, b;
#             scanf("%d%d", &a, &b);
#             printf("%d", a/b);
#             return 0;
#         }
#     ''',
#     [
#         (b'1 1', b'1'),
#         (b'5 2', b'2'),
#         (b'0 0', b'0')
#     ]
# )
# print(o)
# 
o = judge (
    GCC(GCC.Language.cpp),
    b'''
        #include <iostream>
        #include <vector>
        
        int main() {
            int a, b;
            std::cin>>a>>b; std::cout<<(a/b);
            return 0;
        }
    ''',
    [
        (b'1 1', b'1'),
        (b'5 2', b'2'),
        (b'0 0', b'0')
    ]
)
print(o)

#o = judge (
#    PyPy(),
#    b'''a = int(input())
#res = 0
#l=[0]*1024*1024*1024
#for x in range(a):
#    res += x%2
#print(0)
#''',
#    [
#        (b'100', b'0\n'),
#    ],
#)
#print(o)