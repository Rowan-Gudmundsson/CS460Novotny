PROJECT(Compiler)
CMAKE_MINIMUM_REQUIRED(VERSION 2.6)

FIND_PACKAGE(BISON REQUIRED)
SET(BISON_OUTPUT ${CMAKE_SOURCE_DIR}/flex_bison/parser.cpp)
IF(BISON_FOUND)
    ADD_CUSTOM_COMMAND(
      OUTPUT ${BISON_OUTPUT}
      COMMAND ${BISON_EXECUTABLE}
              --defines=${CMAKE_SOURCE_DIR}/flex_bison/tokendef.h
              --output=${BISON_OUTPUT}
                ${CMAKE_SOURCE_DIR}/src/calc.y
      DEPENDS ${CMAKE_SOURCE_DIR}/include/bison_header.h
      COMMENT "Generating parser.cpp"
    )
ENDIF(BISON_FOUND)

FIND_PACKAGE(FLEX REQUIRED)
SET(FLEX_OUTPUT ${CMAKE_SOURCE_DIR}/flex_bison/scanner.cpp)
IF(FLEX_FOUND)
    ADD_CUSTOM_COMMAND(
      OUTPUT ${FLEX_OUTPUT}
      COMMAND ${FLEX_EXECUTABLE}
              --outfile=${FLEX_OUTPUT}
                ${CMAKE_SOURCE_DIR}/src/calc.lex
      COMMENT "Generating scanner.cpp"
    )
ENDIF(FLEX_FOUND)

ADD_LIBRARY(FLEX_BISON ${BISON_OUTPUT} ${FLEX_OUTPUT})

SET(CMAKE_MODULE_PATH ${CMAKE_MODULE_PATH} "${PROJECT_SOURCE_DIR}/CMakeModules")
SET(CXX11_FLAGS -std=c++11)
SET(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} ${CXX11_FLAGS}")

INCLUDE_DIRECTORIES(
  "${PROJECT_SOURCE_DIR}/include"
)

# Set Includes
SET(INCLUDES ${PROJECT_SOURCE_DIR}/include)
INCLUDE_DIRECTORIES(${INCLUDES})

# Set sources
FILE(GLOB_RECURSE SOURCES "src/*.cpp" "flex_bison")
ADD_EXECUTABLE(${PROJECT_NAME} ${SOURCES})

add_custom_target("${PROJECT_NAME}_SUCCESSFUL" ALL
                  DEPENDS ${PROJECT_NAME}
                  COMMAND ${CMAKE_COMMAND} -E echo ""
                  COMMAND ${CMAKE_COMMAND} -E echo "====================="
                  COMMAND ${CMAKE_COMMAND} -E echo "  Compile complete!"
                  COMMAND ${CMAKE_COMMAND} -E echo "====================="
                  COMMAND ${CMAKE_COMMAND} -E echo "${CMAKE_CURRENT_BINARY_DIR}"
                 )
