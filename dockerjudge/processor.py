# pylint: disable = missing-function-docstring, too-few-public-methods

import shlex
from enum import Enum
from pathlib import PurePosixPath

class Processor:
    """Defines the operations of a multi-version programming language processor

    ================== ========================================
    Data               Type
    ================== ========================================
    ``image``          `str`
    ``workdir``        :class:`~pathlib.PurePosixPath` or `str`
    ``source``         `str`
    ``before_compile`` `str` or `list`
    ``compile``        `str` or `list`
    ``after_compile``  `str` or `list`
    ``before_judge``   `str` or `list`
    ``judge``          `str`
    ``after_judge``    `str` or `list`
    ================== ========================================
    """

    @staticmethod
    def _get_image_with_tag(image, tag):
        return image + (f":{tag}" if tag else "")

    image = None
    workdir = PurePosixPath("/dockerjudge")
    source = None
    before_compile = None
    compile = None
    after_compile = None
    before_judge = None
    judge = None
    after_judge = None

    bare_program = ''
    initial_mem = None

class _Language(Enum):
    "Get programming language from enum"

    @classmethod
    def __get_language(cls, language, default=None):
        if isinstance(language, cls):
            return language
        try:
            return cls[language]
        except KeyError:
            try:
                return cls(language)
            except ValueError:
                return cls.__get_language(default)


class GCC(Processor):
    """GNU project C, C++ and Go compiler

    :param language: Programming panguage
        (``C``\\ /\\ ``c``, ``C++``\\ /\\ ``cpp`` or ``Go``\\ /\\ ``go``),
        `C++` by default
    :type language: :class:`dockerjudge.processor.GCC.Language` or `str`
    :param version: Tag name of Docker image |gcc|_
    :type version: `str`, `int` or `float`
    :param filenames: Filenames of source code and binary file,
        C++ default: ``{'src': 'a.cpp', 'bin': None}``
    :type filenames: `dict`
    :param options: Compiler options
    :type options: `list` or `str`

    .. |gcc| replace:: `gcc`
    .. _gcc: https://hub.docker.com/_/gcc
    """

    class Language(_Language):
        """Programming language, `C` (``c``), `C++` (``cpp``) or `Go` (``go``)

        :C: ``GCC.Language.c``,
            ``GCC.Language['c']`` or ``GCC.Language('C')``
        :C++: ``GCC.Language.cpp``,
            ``GCC.Language['cpp']`` or ``GCC.Language('C++')``
        :Go: ``GCC.Language.go``,
            ``GCC.Language['go']`` or ``GCC.Language('Go')``
        """

        c = "C"
        cpp = "C++"
        #go = "Go"

        @classmethod
        def _get_language(cls, language):
            return super().__get_language(language, cls.cpp)
    
    @classmethod
    def _get_bare_program(cls, lang):
        return {
            "C": b'#include <stdio.h>\nint main(){ while(1){} }',
            "Cpp": b'#include <iostream>\nusing namespace std;\nint main(){ while(1){} }'
        }[lang]
    
    initial_mem = None
    @classmethod
    def _get_initial_mem(cls):
        return cls.initial_mem
    
    @classmethod
    def _set_initial_mem(cls, mem):
        if cls.initial_mem is None:
            cls.initial_mem = mem
        else:
            cls.initial_mem = max(cls.initial_mem, mem)

    def __init__(
        self, language=None, version=None, filenames=None, options=None
    ):
        lang = self.Language._get_language(language)
        self.lang = lang

        fns = filenames or {}
        args = options or []

        self.image = self._get_image_with_tag("gcc", version)
        self.source = fns.get("src", f"a.{lang.name}")
        self.compile = (
            [
                {
                    self.Language.c: "gcc",
                    self.Language.cpp: "g++",
                    #self.Language.go: "gccgo",
                }[lang],
                self.source,
            ]
            + (["-o", fns["bin"]] if fns.get("bin") else [])
            + (shlex.split(args) if isinstance(args, str) else args)
        )
        self.after_compile = ["rm", self.source]
        self.judge = f"./{fns.get('bin', 'a.out')}"
    
    def __str__(self):
        return f"{self.Language._get_language(self.lang)} processor"

class OpenJDK(Processor):
    "Open Java Development Kit"

    def __init__(self, version=None):
        self.image = self._get_image_with_tag("openjdk", version)
        self.source = "Main.java"
        self.compile = ["javac", self.source]
        self.after_compile = ["rm", self.source]
        self.judge = "java Main"


    def __str__(self):
        return "Java processor"

    @classmethod
    def _get_bare_program(cls, lang):
        return b"""public class Main {\npublic static void main(String[] args) {\nwhile (true){}\n}\n}"""
    
    initial_mem = None
    @classmethod
    def _get_initial_mem(cls):
        return cls.initial_mem
    
    @classmethod
    def _set_initial_mem(cls, mem):
        cls.initial_mem = mem

class PyPy(Processor):
    "PyPy"

    def __init__(self, version=None):
        pypy = "pypy" if str(version).startswith("2") else "pypy3"

        self.image = self._get_image_with_tag("pypy", version)
        self.source = "__init__.py"
        self.compile = [pypy, "-m", "compileall", "."]
        self.judge = f"{pypy} {self.source}"

        b"while True: pass"
    
    def __str__(self):
        return "PyPy processor"
    
    @classmethod
    def _get_bare_program(cls, lang):
        return b"while True: pass"
    
    initial_mem = None
    @classmethod
    def _get_initial_mem(cls):
        return cls.initial_mem
    
    @classmethod
    def _set_initial_mem(cls, mem):
        cls.initial_mem = mem

class Python(Processor):
    "CPython"

    def __init__(self, version=None):
        self.image = self._get_image_with_tag("python", version)

        self.source = "__init__.py"
        pythonmodule = 'python' + ('2' if version==2 else '3')
        
        self.compile = [pythonmodule, "-m", "compileall", "."]
        self.compile = [pythonmodule, "-m", "compileall", "."]

        self.judge = f"{pythonmodule} {self.source}"

        self.bare_program = b"while True: pass"
    
    def __str__(self):
        return "CPython processor"
    
    @classmethod
    def _get_bare_program(cls, lang):
        return b"while True: pass"
    
    initial_mem = None
    @classmethod
    def _get_initial_mem(cls):
        return cls.initial_mem
    
    @classmethod
    def _set_initial_mem(cls, mem):
        cls.initial_mem = mem

## Other Processors:
#
#
#class Bash(Processor):
#    """Bash is the GNU Project's Bourne Again SHell
#
#    :param version: Tag name of Docker image |bash|_
#    :type version: `str`, `int` or `float`
#
#    .. |bash| replace:: `bash`
#    .. _bash: https://hub.docker.com/_/bash
#    """
#
#    def __init__(self, version=None):
#        self.image = self._get_image_with_tag("bash", version)
#        self.source = "bash.sh"
#        self.compile = ["bash", "-n", self.source]
#        self.judge = f"bash {self.source}"
#
#
#class Clang(Processor):
#    """Clang C Language Family Frontend for LLVM
#
#    :param language: Programming panguage
#        (``C``\\ /\\ `c` or ``C++``\\ /\\ ``cpp``), `C++` by default
#    :type language: :class:`dockerjudge.processor.Clang.Language` or `str`
#    :param version: Tag name of Docker image |clang|_
#    :type version: `str`, `int` or `float`
#    :param filenames: Filenames of source code and binary file,
#        C++ default: ``{'src': 'a.cpp', 'bin': None}``
#    :type filenames: `dict`
#    :param options: Compiler options
#    :type options: `list` or `str`
#
#    .. |clang| replace:: `clangbuiltlinux/ubuntu`
#    .. _clang: https://hub.docker.com/r/clangbuiltlinux/ubuntu
#    """
#
#    class Language(_Language):
#        """Programming language, `C` (``c``) or `C++` (``cpp``)
#
#        :C: ``Clang.Language.c``,
#            ``Clang.Language['c']`` or ``Clang.Language('C')``
#        :C++: ``Clang.Language.cpp``,
#            ``Clang.Language['cpp']`` or ``Clang.Language('C++')``
#        """
#
#        c = "C"
#        cpp = "C++"
#
#        @classmethod
#        def _get_language(cls, language):
#            return super().__get_language(language, cls.cpp)
#
#    def __init__(
#        self, language=None, version=None, filenames=None, options=None
#    ):
#        lang = self.Language._get_language(language)
#        fns = filenames or {}
#        args = options or []
#
#        self.image = "clangbuiltlinux/ubuntu" + f":llvm{version}-latest"
#        self.source = fns.get("src", f"a.{lang.name}")
#        self.compile = (
#            [
#                {self.Language.c: "clang", self.Language.cpp: "clang++"}[lang]
#                + f"-{version}",
#                self.source,
#            ]
#            + (["-o", fns["bin"]] if fns.get("bin") else [])
#            + (shlex.split(args) if isinstance(args, str) else args)
#        )
#        self.after_compile = ["rm", self.source]
#        self.judge = f"./{fns.get('bin', 'a.out')}"
#
#class Go(Processor):
#    """The Go Programming Language
#
#    :param version: Tag name of Docker image |golang|_
#    :type version: `str`, `int` or `float`
#    :param filenames: Filenames of source code and binary file,
#        default: ``{'src': 'main.go', 'bin': None}``
#    :type filenames: `dict`
#
#    .. |golang| replace:: `golang`
#    .. _golang: https://hub.docker.com/_/golang
#    """
#
#    def __init__(self, version=None, filenames=None, options=None):
#        fns = filenames or {}
#        args = options or []
#
#        self.image = self._get_image_with_tag("golang", version)
#        self.source = fns.get("src", "main.go")
#        self.compile = (
#            ["go", "build"]
#            + (["-o", fns["bin"]] if fns.get("bin") else [])
#            + args
#            + [self.source]
#        )
#        self.after_compile = ["rm", self.source]
#        self.judge = f"./{fns.get('bin', 'main')}"
#
#
#class Mono(Processor):
#    """**Mono** is a software platform
#    designed to allow developers to easily create
#    cross platform applications part of the `.NET Foundation`_.
#
#        Sponsored by Microsoft_,
#        Mono is an open source implementation of Microsoft's .NET Framework
#        based on the ECMA_ standards
#        for `C#`_ and the `Common Language Runtime`_.
#
#    :param language: Programming panguage
#        (``Visual Basic``\\ /\\ ``vb`` or ``C#``\\ /\\ ``csharp``),
#        C# by default
#    :type language: :class:`dockerjudge.processor.Mono.Language` or `str`
#    :param version: Tag name of Docker image |mono|_
#    :type version: `str`, `int` or `float`
#
#    .. _.NET Foundation: https://www.dotnetfoundation.org
#    .. _Microsoft: https://www.microsoft.com
#    .. _ECMA: https://www.mono-project.com/docs/about-mono/languages/ecma/
#    .. _C#: https://www.mono-project.com/docs/about-mono/languages/csharp/
#    .. _Common Language Runtime:
#        https://www.mono-project.com/docs/advanced/runtime/
#    .. |mono| replace:: `mono`
#    .. _mono: https://hub.docker.com/_/mono
#    """
#
#    class Language(_Language):
#        """Programming language, `Visual Basic` (``vb``) or `C#` (``csharp``)
#
#        :Visual Basic: ``GCC.Language.vb``,
#            ``GCC.Language['vb']`` or ``GCC.Language('Visual Basic')``
#        :C#: ``GCC.Language.csharp``,
#            ``GCC.Language['csharp']`` or ``GCC.Language('C#')``
#        """
#
#        vb = "Visual Basic"
#        csharp = "C#"
#
#        @classmethod
#        def _get_language(cls, language):
#            return super().__get_language(language, cls.csharp)
#
#    def __init__(self, language=None, version=None):
#        lang = self.Language._get_language(language)
#
#        self.image = self._get_image_with_tag("mono", version)
#        self.source = f"""mono.{
#            {self.Language.csharp: 'cs', self.Language.vb: 'vb'}[lang]
#        }"""
#        self.compile = [
#            {self.Language.csharp: "csc", self.Language.vb: "vbnc"}[lang],
#            self.source,
#        ]
#        self.after_compile = ["rm", self.source]
#        self.judge = "mono mono.exe"
#
#
#class Node(Processor):
#    "Node.js®"
#
#    def __init__(self, version=None):
#        self.image = self._get_image_with_tag("node", version)
#        self.source = "index.js"
#        self.compile = ["node", "-c", self.source]
#        self.judge = f"node {self.source}"
#
#
#
#class PHP(Processor):
#    "PHP"
#
#    def __init__(self, version=None):
#        self.image = self._get_image_with_tag("php", version)
#        self.source = "index.php"
#        self.compile = ["php", "-l", self.source]
#        self.judge = f"php {self.source}"
#
#
#class Ruby(Processor):
#    "Ruby"
#
#    def __init__(self, version=None):
#        self.image = self._get_image_with_tag("ruby", version)
#        self.source = "ruby.rb"
#        self.compile = ["ruby", "-wc", self.source]
#        self.judge = f"ruby {self.source}"
#
#
#class Swift(Processor):
#    "Swift"
#
#    def __init__(self, version=None):
#        self.image = self._get_image_with_tag("swift", version)
#        self.source = "main.swift"
#        self.compile = ["swiftc", self.source]
#        self.judge = "./main"
#