cmake_minimum_required(VERSION 3.13)

project(catch
        VERSION 2019.1.0
        DESCRIPTION "Compact test framework"
        LANGUAGES CXX)

add_library(catch
        include/catch.h
        src/catch-main.cpp)

set_property(TARGET catch PROPERTY CXX_STANDARD 14)

set_property(TARGET catch PROPERTY CXX_STANDARD_REQUIRED On)

target_include_directories(catch PRIVATE "${CMAKE_CURRENT_SOURCE_DIR}/include")

if(MSVC)
    target_compile_options(catch PRIVATE /W4)
else(MSVC)
    target_compile_options(catch PRIVATE -Wall -Wextra -pedantic)
endif(MSVC)

###
### LIBRARY INSTALLATION
###

include(GNUInstallDirs)

install(TARGETS catch EXPORT CatchConfig
        ARCHIVE  DESTINATION ${CMAKE_INSTALL_LIBDIR}
        LIBRARY  DESTINATION ${CMAKE_INSTALL_LIBDIR}
        RUNTIME  DESTINATION ${CMAKE_INSTALL_BINDIR})

install(DIRECTORY include/ DESTINATION ${CMAKE_INSTALL_INCLUDEDIR})

install(EXPORT CatchConfig
        DESTINATION ${CMAKE_INSTALL_DATADIR}/cmake/Catch
        EXPORT_LINK_INTERFACE_LIBRARIES )

export(TARGETS catch FILE CatchConfig.cmake)