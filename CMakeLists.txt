cmake_minimum_required(VERSION 3.10)

project(catchtests
        VERSION 2019.1.0
        DESCRIPTION "Compact test framework"
        LANGUAGES CXX)

####
#### DEPENDENCIES
####
#
#if (NOT EXISTS ${CMAKE_CURRENT_SOURCE_DIR}/DependenciesConfig.cmake)
#    file(DOWNLOAD https://raw.githubusercontent.com/germanespinosa/dependencies/main/DependenciesConfig.cmake ${CMAKE_CURRENT_SOURCE_DIR}/DependenciesConfig.cmake)
#endif()
#set(Dependencies_DIR "${CMAKE_CURRENT_SOURCE_DIR}")
find_package (Dependencies REQUIRED)

####
####
####

dependency_include(include)

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
