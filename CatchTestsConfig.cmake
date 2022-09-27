
get_directory_property(CATCH_TEST_HAS_PARENT_SCOPE PARENT_DIRECTORY)
if(CATCH_TEST_HAS_PARENT_SCOPE)
    set(CATCH_TEST_COUNTER 0 PARENT_SCOPE)
else()
    set(CATCH_TEST_COUNTER 0)
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

        add_executable(${CATCH_TEST_NAME} Resources/catchtests.cpp ${CATCH_TEST_FILES})

        target_include_directories(${CATCH_TEST_NAME} PRIVATE include)

        set_target_properties(${CATCH_TEST_NAME}
                PROPERTIES
                RUNTIME_OUTPUT_DIRECTORY ".tests")

        foreach(CATCH_TEST_LIBRARY ${CATCH_TEST_LIBRARIES})
            target_link_libraries(${CATCH_TEST_NAME} ${CATCH_TEST_LIBRARIES})
            get_target_property(CATCH_TEST_LIBRARY_INCLUDE_DIRECTORIES ${CATCH_TEST_LIBRARY} INCLUDE_DIRECTORIES)
            target_include_directories(${CATCH_TEST_NAME} PRIVATE ${CATCH_TEST_LIBRARY_INCLUDE_DIRECTORIES})
        endforeach()

        add_test(${PROJECT_NAME}Tests .tests/${CATCH_TEST_NAME})
        if ("${CMAKE_BUILD_TYPE}" MATCHES "Release")
            add_custom_command(TARGET ${CATCH_TEST_NAME}
                    POST_BUILD
                    COMMAND .tests/${CATCH_TEST_NAME} )
        endif()
        MATH(EXPR CATCH_TEST_COUNTER "${CATCH_TEST_COUNTER}+1")
    endmacro()

    macro(test_files)
        set(CATCH_TEST_FILES "")
        set(CATCH_TEST_SOURCES "")
        set(CATCH_TEST_LIBRARIES "")
        set(CATCH_TEST_CURRENT_LIST CATCH_TEST_FILES)
        foreach(arg IN ITEMS ${ARGN})
            if ("${arg}" MATCHES "SOURCES")
                set(CATCH_TEST_CURRENT_LIST CATCH_TEST_SOURCES)
            elseif("${arg}" MATCHES "TESTS")
                set(CATCH_TEST_CURRENT_LIST CATCH_TEST_FILES)
            elseif("${arg}" MATCHES "LIBRARIES")
                set(CATCH_TEST_CURRENT_LIST CATCH_TEST_LIBRARIES)
            else()
                list(APPEND ${CATCH_TEST_CURRENT_LIST} ${arg})
            endif()
        endforeach()
        string(LENGTH ${CATCH_TEST_COUNTER} COUNTER_LEN)
        MATH(EXPR CATCH_TEST_COUNTER_START "2-${COUNTER_LEN}")
        string(SUBSTRING "00${CATCH_TEST_COUNTER}" ${CATCH_TEST_COUNTER_START} 2 CATCH_TEST_COUNTER_STR)
        set (CATCH_TEST_NAME ${PROJECT_NAME}_${CATCH_TEST_COUNTER_STR}_tests)

        add_executable(${CATCH_TEST_NAME} Resources/catchtests.cpp ${CATCH_TEST_FILES} ${CATCH_TEST_SOURCES})

        target_include_directories(${CATCH_TEST_NAME} PRIVATE include)

        set_target_properties(${CATCH_TEST_NAME}
                PROPERTIES
                RUNTIME_OUTPUT_DIRECTORY ".tests")

        target_link_libraries(${CATCH_TEST_NAME} ${CATCH_TEST_LIBRARIES})

        add_test(${PROJECT_NAME}Tests .tests/${CATCH_TEST_NAME})
        if ("${CMAKE_BUILD_TYPE}" MATCHES "Release")
            add_custom_command(TARGET ${CATCH_TEST_NAME}
                    POST_BUILD
                    COMMAND .tests/${CATCH_TEST_NAME} )
        endif()
        MATH(EXPR CATCH_TEST_COUNTER "${CATCH_TEST_COUNTER}+1")
    endmacro()
endif()