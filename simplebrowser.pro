TEMPLATE = app
TARGET = simplebrowser
QT += webenginewidgets

HEADERS += \
    browser.h \
    browserwindow.h \
    downloadmanagerwidget.h \
    downloadwidget.h \
    tabwidget.h \
    webpage.h \
    webpopupwindow.h \
    webview.h

SOURCES += \
    browser.cpp \
    browserwindow.cpp \
    downloadmanagerwidget.cpp \
    downloadwidget.cpp \
    main.cpp \
    tabwidget.cpp \
    webpage.cpp \
    webpopupwindow.cpp \
    webview.cpp

FORMS += \
    certificateerrordialog.ui \
    passworddialog.ui \
    downloadmanagerwidget.ui \
    downloadwidget.ui

RESOURCES += data/simplebrowser.qrc

RC_FILE= data/resource.rc

win32 {
    message("in win32")
    LIBS += -L$$PWD/DllFunc/bin/debug/ -lDllFunc
}

CONFIG += sdk_no_version_check

# install
target.path = $$[QT_INSTALL_EXAMPLES]/webenginewidgets/simplebrowser
INSTALLS += target

#win32:CONFIG(release, debug|release): LIBS += -L$$PWD/DllFunc/bin/release/ -lDllFunc
#else:win32:CONFIG(debug, debug|release): LIBS += -L$$PWD/DllFunc/bin/debug/ -lDllFunc

#INCLUDEPATH += $$PWD/DllFunc/bin/debug
#DEPENDPATH += $$PWD/DllFunc/bin/debug
