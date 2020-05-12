
#include <iostream>
#include <string>
#include <vector>
#include "commonLib.hpp"

int main(int argc, char const *argv[]) {
  if (argc == 1) {
    std::cout << "5.7 ";
    calling_from_fortran(5.7);
  } else {
    std::vector<std::string> args(argv + 1, argv + argc);
    for (auto &&a : args) {
      std::cout << a << " ";
      calling_from_fortran(stod(a));
    }
  }

  rust_hello();

  return 0;
}
