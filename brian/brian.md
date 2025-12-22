# gRPC
# Brian Salehi
## user
## Brian Salehi
### synapse
### Brian Salehi
#### surface

#### CMake Integration
##### gRPC
###### Make a dependency between protobuf files CMake targets?

```cmake
cmake_minimum_required(VERSION 4.0.0)
project(Example VERSION 1.0 LANGUAGES CXX)

find_package(Protobuf 3.19.0 REQUIRED)
find_package(gRPC 1.48.0 REQUIRED)
find_program(grpc_cpp_plugin NAMES grpc_cpp_plugin REQUIRED)

set(service_sources
    ${CMAKE_CURRENT_BINARY_DIR}/service.pb.h
    ${CMAKE_CURRENT_BINARY_DIR}/service.pb.cpp
    ${CMAKE_CURRENT_BINARY_DIR}/service.grpc.pb.h
    ${CMAKE_CURRENT_BINARY_DIR}/service.grpc.pb.cpp
)

add_custom_command(
    OUTPUT ${service_sources}
    COMMAND ${Protobuf_EXECUTABLE}
    ARGS
        --grpc_out=${CMAKE_CURRENT_BINARY_DIR}
        --cpp_out=${CMAKE_CURRENT_BINARY_DIR}
        --plugin=${grpc_cpp_plugin}
        -I ${CMAKE_CURRENT_SOURCE_DIR}/proto
        -I ${Protobuf_INCLUDE_DIRS}
        ${CMAKE_CURRENT_SOURCE_DIR}/proto/service.proto
    DEPENDS
        ${CMAKE_CURRENT_SOURCE_DIR}/proto/service.proto
)

add_executable(program main.cpp ${service_sources})
target_link_libraries(program PRIVATE protobuf::libprotobuf gRPC::grpc++)
```

---

# Subject
# Resource
## Resource Type (book, website, course, video, channel, mailing list, manual, slides)
## Provider
### Section Pattern (chapter, page, course, video, post)
### Presenter
#### Topic Level (surface, depth, origin)

#### <Topic>
##### <Section>
###### <Card>

---
# Subject
#### Topic Level (surface, depth, origin)

#### <Topic>
###### <Card>
