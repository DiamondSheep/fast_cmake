# fast_cmake
This is a bash script to build cpp project fastly.

# How to use

Tape commands as following:

```bash
git clone https://github.com/DiamondSheep/fast_cmake.git
cd fast_cmake
sh ./cmake_build.sh [your_project_name]
```

Then it will build a simple cpp project with directory tree structure like:

```bash
[your_project_name]
├── CMakeLists.txt
├── include
│   └── [your_project_name].hpp
├── lib
│   └── CMakeLists.txt
└── src
    ├── CMakeLists.txt
    └── [your_project_name].cpp
```

