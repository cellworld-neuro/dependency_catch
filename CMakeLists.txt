cmake_minimum_required(VERSION 3.10)

project(catchtests
        VERSION 2019.1.0
        DESCRIPTION "Compact test framework"
        LANGUAGES CXX)

find_package(Dependencies)

if (Dependencies_FOUND)
    dependency_include(include)
else()
    include_directories(include)
endif()

file(COPY Resources/CatchTestsConfig.cmake
        DESTINATION ${CMAKE_CURRENT_BINARY_DIR} )

file(COPY Resources/catchtests.cpp
        DESTINATION ${CMAKE_CURRENT_BINARY_DIR} )

set( catchtests_files
        Resources/catchtests.cpp )

add_custom_target(catchtests SOURCES ${catchtests_files})

###
### LIBRARY INSTALLATION
###

include(GNUInstallDirs)

install(FILES Resources/catch.h
        DESTINATION ${CMAKE_INSTALL_INCLUDEDIR})
install(FILES
        Resources/catchtests.cpp
        Resources/CatchTestsConfig.cmake
        DESTINATION ${CMAKE_INSTALL_DATADIR}/cmake/CatchTests)
