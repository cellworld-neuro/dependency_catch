cmake_minimum_required(VERSION 3.10)

project(catchtests
        VERSION 2019.1.0
        DESCRIPTION "Compact test framework"
        LANGUAGES CXX)

file(COPY Resources/catch.h
        DESTINATION ${CMAKE_CURRENT_BINARY_DIR} )

file(COPY ${CMAKE_CURRENT_SOURCE_DIR}/Resources/CatchTestsConfig.cmake
        DESTINATION ${CMAKE_CURRENT_BINARY_DIR} )

file(COPY ${CMAKE_CURRENT_SOURCE_DIR}/Resources/catchtests.cpp
        DESTINATION ${CMAKE_CURRENT_BINARY_DIR} )

set( catchtests_files
        Resources/catch.h
        Resources/CatchTestsConfig.cmake
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
