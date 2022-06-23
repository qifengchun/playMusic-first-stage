QT += quick

SOURCES += \
        main.cpp \
        song.cpp

resources.files = main.qml
resources.files = Actions.qml
resources.prefix = /$${TARGET}
RESOURCES += ./qml/qml.qrc \
    ./resource/CloudMusic.qrc

# Additional import path used to resolve QML modules in Qt Creator's code model
QML_IMPORT_PATH =

# Additional import path used to resolve QML modules just for Qt Quick Designer
QML_DESIGNER_IMPORT_PATH =

# Default rules for deployment.
qnx: target.path = /tmp/$${TARGET}/bin
else: unix:!android: target.path = /opt/$${TARGET}/bin
!isEmpty(target.path): INSTALLS += target

#DISTFILES += \
#    Actions.qml \
#    main.qml

HEADERS += \
    song.h

unix|win32: LIBS += -ltag

unix|win32: LIBS += -ltag_c

unix|win32: LIBS += -lz

unix|win32: LIBS += -lavutil
unix|win32: LIBS += -lavformat
unix|win32: LIBS += -lavcodec
unix|win32: LIBS += -lswresample
