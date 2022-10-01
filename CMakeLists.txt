cmake_minimum_required(VERSION 3.10)
project(CatchTests)

get_directory_property(CATCH_TEST_HAS_PARENT_SCOPE PARENT_DIRECTORY)
if(CATCH_TEST_HAS_PARENT_SCOPE)
    set(CATCH_TEST_COUNTER 0 PARENT_SCOPE)
    set(CATCH_TEST_LOCATION ${CMAKE_CURRENT_SOURCE_DIR} PARENT_SCOPE )
else()
    set(CATCH_TEST_COUNTER 0)
    set(CATCH_TEST_LOCATION ${CMAKE_CURRENT_SOURCE_DIR})
endif()

if ("${CATCH_TESTS}" MATCHES "DISABLED")
    macro (test_library)
    endmacro()

    macro(test_files)
    endmacro()
else()
    enable_testing()
    macro(test_library CATCH_TEST_LIBRARIES)

        if ("${ARGN}" STREQUAL "")
            file(GLOB CATCH_TEST_FILES
                    "catchtests/*.h"
                    "catchtests/*.cpp"
                    )
        else()
            set (CATCH_TEST_FILES ${ARGN})
        endif()

        string(LENGTH ${CATCH_TEST_COUNTER} COUNTER_LEN)
        MATH(EXPR CATCH_TEST_COUNTER_START "2-${COUNTER_LEN}")
        string(SUBSTRING "00${CATCH_TEST_COUNTER}" ${CATCH_TEST_COUNTER_START} 2 CATCH_TEST_COUNTER_STR)
        set (CATCH_TEST_NAME ${PROJECT_NAME}_${CATCH_TEST_COUNTER_STR}_tests)

        add_executable(${CATCH_TEST_NAME} ${CATCH_TEST_LOCATION}/Resources/catchtests.cpp ${CATCH_TEST_FILES})

        target_include_directories(${CATCH_TEST_NAME} PRIVATE ${CATCH_TEST_LOCATION}/include)

        set_target_properties(${CATCH_TEST_NAME}
                PROPERTIES
                RUNTIME_OUTPUT_DIRECTORY ".tests")

        target_link_libraries(${CATCH_TEST_NAME} PRIVATE ${CATCH_TEST_LIBRARIES})

        add_test(${PROJECT_NAME}Tests .tests/${CATCH_TEST_NAME})
        if ("${CMAKE_BUILD_TYPE}" MATCHES "Release")
            add_custom_command(TARGET ${CATCH_TEST_NAME}
                    POST_BUILD
                    COMMAND .tests/${CATCH_TEST_NAME} )
        endif()
        MATH(EXPR CATCH_TEST_COUNTER "${CATCH_TEST_COUNTER}+1")
    endmacro()

    macro(add_catch_test CATCH_TEST_NAME)

        cmake_parse_arguments(CATCH_TEST
                "AUTO_RUN"
                "NAME"
                "TEST_FILES;SOURCE_FILES;LINK_LIBRARIES;INCLUDE_DIRECTORIES"
                ${ARGN} )

        add_executable(${CATCH_TEST_NAME} ${CATCH_TEST_LOCATION}/Resources/catchtests.cpp ${CATCH_TEST_TEST_FILES} ${CATCH_TEST_SOURCE_FILES})
        target_include_directories(${CATCH_TEST_NAME} PRIVATE ${CATCH_TEST_LOCATION}/include)

        set_target_properties(${CATCH_TEST_NAME}
                PROPERTIES
                RUNTIME_OUTPUT_DIRECTORY ".tests")

        if (NOT "${CATCH_TEST_LINK_LIBRARIES}" STREQUAL "")
            target_link_libraries(${CATCH_TEST_NAME} ${CATCH_TEST_LINK_LIBRARIES})
        endif()
        if (NOT "${CATCH_TEST_INCLUDE_DIRECTORIES}" STREQUAL "")
            message( "target_include_directories(${CATCH_TEST_NAME} PRIVATE ${CATCH_TEST_INCLUDE_DIRECTORIES})" )
            target_include_directories(${CATCH_TEST_NAME} PRIVATE ${CATCH_TEST_INCLUDE_DIRECTORIES})
        endif()

        add_test(${PROJECT_NAME}_TEST .tests/${CATCH_TEST_NAME})

        if (${CATCH_TEST_AUTO_RUN})
            add_custom_command(TARGET ${CATCH_TEST_NAME}
                    POST_BUILD
                    COMMAND .tests/<TARGET_FILE_NAME:${CATCH_TEST_NAME}> )
        endif()
    endmacro()
endif()

