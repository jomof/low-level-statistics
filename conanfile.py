from conans import ConanFile
import os
from conans.tools import download, unzip, replace_in_file
from conans import CMake, ConfigureEnvironment


class StatisticsConan(ConanFile):
    name = "statistics"
    version = "0.0.1"
    generators = "cmake"
    settings = "os", "arch", "compiler", "build_type"
    options = {"shared": [True, False]}
    default_options = "shared=False"
    exports = ["CMakeLists.txt", "FindStatistics.cmake"]
    url="https://github.com/jomof/low-level-statistics"
    license="https://raw.githubusercontent.com/jomof/low-level-statistics/master/LICENSE"
    description="Very low level C functions for statistics"
    
    def config(self):
        del self.settings.compiler.libcxx 

    def build(self):
        cmake = CMake(self.settings)
        self.run('cmake %s %s' % (self.conanfile_directory, cmake.command_line))
        self.run("cmake --build . %s" % cmake.build_config)


    def package(self):
        self.copy("*.h", dst="include")
        self.copy("*.lib", dst="lib", src="lib")
        self.copy("*.a", dst="lib", src="lib")

    def package_info(self):
        self.cpp_info.libs = ["statistics"]