cmake_minimum_required(VERSION 3.5)

project(SimpleBrowser LANGUAGES CXX)
#message('PROJECT_NAME=${PROJECT_NAME}')

set(CMAKE_INCLUDE_CURRENT_DIR ON)

set(CMAKE_AUTOUIC ON)
set(CMAKE_AUTOMOC ON)
set(CMAKE_AUTORCC ON)

set(CMAKE_CXX_STANDARD 11)
set(CMAKE_CXX_STANDARD_REQUIRED ON)

# QtCreator supports the following variables for Android, which are identical to qmake Android variables.
# Check https://doc.qt.io/qt/deployment-android.html for more information.
# They need to be set before the find_package( ...) calls below.

#if(ANDROID)
#    set(ANDROID_PACKAGE_SOURCE_DIR "${CMAKE_CURRENT_SOURCE_DIR}/android")
#    if (ANDROID_ABI STREQUAL "armeabi-v7a")
#        set(ANDROID_EXTRA_LIBS
#            ${CMAKE_CURRENT_SOURCE_DIR}/path/to/libcrypto.so
#            ${CMAKE_CURRENT_SOURCE_DIR}/path/to/libssl.so)
#    endif()
#endif()

set(CMAKE_PREFIX_PATH $ENV{QTDIR-5_15_2})
message("CMAKE_PREFIX_PATH=${CMAKE_PREFIX_PATH}")

find_package(QT NAMES Qt6 Qt5 COMPONENTS Widgets REQUIRED)
find_package(Qt${QT_VERSION_MAJOR} COMPONENTS Widgets Network REQUIRED)
find_package(Qt${QT_VERSION_MAJOR}WebEngineWidgets REQUIRED)
#find_package(Qt${QT_VERSION_MAJOR}Network REQUIRED)
ADD_DEFINITIONS(-DUNICODE -D_UNICODE)

message("QT_VERSION_MAJOR=${QT_VERSION_MAJOR}")

add_subdirectory(DllFunc)

set(PROJECT_SOURCES
        main.cpp
        browser.cpp
        browserwindow.cpp
        downloadmanagerwidget.cpp
        downloadwidget.cpp
        main.cpp
        tabwidget.cpp
        webpage.cpp
        webpopupwindow.cpp
        webview.cpp
        )

SET(PROJECT_FORMS
        certificateerrordialog.ui
        passworddialog.ui
        downloadmanagerwidget.ui
        downloadwidget.ui
        )

SET(PROJECT_RESOURCES
        data/simplebrowser.qrc
        data/resource.rc
        )


#CMake配置Qt工程 https://zhuanlan.zhihu.com/p/268209090
#引入库目录路径
#SET(SDK_PATH "../SDK-PATH")
#LINK_DIRECTORIES(${SDK_PATH}/Lib ${SDK_PATH}/opencv3.4/lib ${SDK_PATH}/libpng/lib ${SDK_PATH}/log4cplus/lib ${SDK_PATH}/zlib/lib)

##引入库目录头文件
#INCLUDE_DIRECTORIES(
#        ${SDK_PATH}/libpng/include
#        ${SDK_PATH}/zlib/include
#        ${SDK_PATH}/log4cplus/include
#        ${SDK_PATH}/opencv3.4/include
#        ${SDK_PATH}/opencv3.4/include/opencv
#        ${SDK_PATH}/opencv3.4/include/opencv2
#)
#INCLUDE_DIRECTORIES(${AUTOGEN_BUILD_DIR})

#ARGET_LINK_LIBRARIES(${PROJECT_NAME} ${PROJECT_LIBRARIES})
#
##链接opencv开发库
#TARGET_LINK_LIBRARIES(${PROJECT_NAME}
#        debug opencv_world343d.lib			optimized opencv_world343.lib
#        debug zlibstaticd.lib				optimized zlibstatic.lib
#        debug libpng16_staticd.lib			optimized libpng16_static.lib
#        debug log4cplusUD.lib				optimized log4cplusU.lib
#        )

if (${QT_VERSION_MAJOR} GREATER_EQUAL 6)
    qt_add_executable(SimpleBrowser
            ${PROJECT_SOURCES}
            )
else ()
    if (ANDROID)
        add_library(SimpleBrowser SHARED
                ${PROJECT_SOURCES}
                )
    else ()
        add_executable(${PROJECT_NAME}
                ${PROJECT_SOURCES}
                ${PROJECT_FORMS}
                ${PROJECT_RESOURCES}
                )
    endif ()
endif ()

target_link_libraries(${PROJECT_NAME} PRIVATE Qt${QT_VERSION_MAJOR}::Widgets Qt${QT_VERSION_MAJOR}::WebEngineWidgets DllFunc)
