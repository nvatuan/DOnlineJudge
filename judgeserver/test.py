from dockerjudge import judge
from dockerjudge.processor import GCC

o = judge (
    GCC(GCC.Language.c),
    b'''
        #include <stdio.h>
        
        int main() {
            int a, b;
            scanf("%d%d", &a, &b);
            printf("%d", a/b);
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