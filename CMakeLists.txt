cmake_minimum_required(VERSION 3.10)

project(catchtests
        VERSION 2019.1.0
        DESCRIPTION "Compact test framework"
        LANGUAGES CXX)

add_library(catchtests
        include/catch.h
        src/catch-main.cpp
        Resources/catchtests.cpp)


file(COPY ${CMAKE_CURRENT_SOURCE_DIR}/include/catch.h
        DESTINATION ${CMAKE_CURRENT_BINARY_DIR} )

file(COPY ${CMAKE_CURRENT_SOURCE_DIR}/Resources/catchtests.cmake
        DESTINATION ${CMAKE_CURRENT_BINARY_DIR} )

file(COPY ${CMAKE_CURRENT_SOURCE_DIR}/Resources/catchtests.cpp
        DESTINATION ${CMAKE_CURRENT_BINARY_DIR} )


set_property(TARGET catchtests PROPERTY CXX_STANDARD 20)

set_property(TARGET catchtests PROPERTY CXX_STANDARD_REQUIRED On)

target_include_directories(catchtests PRIVATE "${CMAKE_CURRENT_SOURCE_DIR}/include")

add_custom_command(
        TARGET catchtests
        POST_BUILD
        COMMAND echo "include'(''$$'\{CMAKE_CURRENT_LIST_DIR\}/catchtests.cmake')'" >> ${CMAKE_CURRENT_BINARY_DIR}/CatchTestsConfig.cmake
)

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

install(FILES ${CMAKE_CURRENT_BINARY_DIR}/catchtests.cmake ${CMAKE_CURRENT_BINARY_DIR}/catchtests.cpp
        DESTINATION ${CMAKE_INSTALL_DATADIR}/CatchTests)

export(TARGETS catchtests FILE CatchTestsConfig.cmake)
#install(CODE "FILE(APPEND ${CMAKE_INSTALL_FULL_DATADIR}/cmake/CatchTests/CatchTestsConfig.cmake \"include (${CMAKE_INSTALL_FULL_DATADIR}/CatchTests/catchtests.cmake)\n\") ")
