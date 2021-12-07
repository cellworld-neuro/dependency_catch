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
#
#export(TARGETS catchtests FILE CatchTestsConfig.cmake)
#
#add_custom_command(
#        TARGET catchtests
#        PRE_BUILD
#        COMMAND echo "include'(''$$'\{CMAKE_CURRENT_LIST_DIR\}/CatchTestsConfig.cmake')'" >> ${CMAKE_CURRENT_BINARY_DIR}/CatchTestsConfig.cmake
#)
#
#
#install(TARGETS catchtests EXPORT CatchTestsConfig
#        ARCHIVE  DESTINATION ${CMAKE_INSTALL_LIBDIR}
#        LIBRARY  DESTINATION ${CMAKE_INSTALL_LIBDIR}
#        RUNTIME  DESTINATION ${CMAKE_INSTALL_BINDIR})

install(FILES Resources/catch.h
        DESTINATION ${CMAKE_INSTALL_INCLUDEDIR})
install(FILES
        Resources/catchtests.cpp
        Resources/CatchTestsConfig.cmake
        DESTINATION ${CMAKE_INSTALL_DATADIR}/cmake/CatchTests)
#
#install(EXPORT CatchTestsConfig
#        DESTINATION ${CMAKE_INSTALL_DATADIR}/cmake/CatchTests
#        EXPORT_LINK_INTERFACE_LIBRARIES )
#
#file(READ Resources/CatchTestsConfig.cmake tests_code)
#
#install(FILES ${CMAKE_CURRENT_BINARY_DIR}/CatchTestsConfig.cmake ${CMAKE_CURRENT_BINARY_DIR}/catchtests.cpp
#        DESTINATION ${CMAKE_INSTALL_DATADIR}/CatchTests)
#
#install(SCRIPT hello.cmake)
#
##install(CODE "FILE(APPEND ${CMAKE_INSTALL_FULL_DATADIR}/cmake/CatchTests/CatchTestsConfig.cmake \"include (${CMAKE_INSTALL_FULL_DATADIR}/CatchTests/CatchTestsConfig.cmake)\n\") ")
