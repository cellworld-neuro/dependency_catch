cmake_minimum_required(VERSION 3.10)

project(catchtests
        VERSION 2019.1.0
        DESCRIPTION "Compact test framework"
        LANGUAGES CXX)

add_library(catchtests
        src/catch-main.cpp
        Resources/catchtests.cpp)

set_property(TARGET catchtests PROPERTY CXX_STANDARD 14)

set_property(TARGET catchtests PROPERTY CXX_STANDARD_REQUIRED On)

find_package(Dependencies)

if (Dependencies_FOUND)
    dependency_include(include)
else()
    target_include_directories(catchtests include)
endif()


if(MSVC)
    target_compile_options(catchtests PRIVATE /W4)
else(MSVC)
    target_compile_options(catchtests PRIVATE -Wall -Wextra -pedantic)
endif(MSVC)

###
### LIBRARY INSTALLATION
###

include(GNUInstallDirs)

install(TARGETS catchtests EXPORT CatchTestsConfig
        ARCHIVE  DESTINATION ${CMAKE_INSTALL_LIBDIR}
        LIBRARY  DESTINATION ${CMAKE_INSTALL_LIBDIR}
        RUNTIME  DESTINATION ${CMAKE_INSTALL_BINDIR})

install(DIRECTORY include/ DESTINATION ${CMAKE_INSTALL_INCLUDEDIR})

install(EXPORT CatchTestsConfig
        DESTINATION ${CMAKE_INSTALL_DATADIR}/cmake/CatchTests
        EXPORT_LINK_INTERFACE_LIBRARIES )
file(READ Resources/catchtests.cmake tests_code)

install(DIRECTORY Resources/ DESTINATION ${CMAKE_INSTALL_DATADIR}/CatchTests)

export(TARGETS catchtests FILE CatchTestsConfig.cmake)
install(CODE "FILE(APPEND ${CMAKE_INSTALL_FULL_DATADIR}/cmake/CatchTests/CatchTestsConfig.cmake \"include (${CMAKE_INSTALL_FULL_DATADIR}/CatchTests/catchtests.cmake)\n\") ")
