
import QtQuick
import QtQuick.Layouts
import QtQuick.Controls
Window {
    id:window
    width: 1200
    height: 800
    visible: true
    title: qsTr("Music")
//三个列排列
    ColumnLayout{
        spacing: 1
        anchors.fill: parent
//第一排
        Rectangle {
            Layout.alignment: Qt.AlignCenter
            Layout.preferredWidth:  window.width
            Layout.preferredHeight: 100

            RowLayout {
                id: layout1
                anchors.fill: parent
                spacing:0
                Rectangle {
                    color: 'teal'

                    Layout.preferredWidth: 200
                    Layout.preferredHeight: 100
                    Label {
                        text: "云上音乐"
                        font.pixelSize: 22
                        font.italic: true
                    }

                }
                Rectangle {
                    color: 'plum'
                    Layout.fillWidth: true
                    Layout.preferredWidth: 700
                    Layout.preferredHeight: 100
                    Button{

                    }


                }

                Rectangle{
                    Layout.fillWidth: true
                    color: 'teal'
                    Layout.preferredWidth: 300
                    Layout.preferredHeight: 100

            }

        }
  }
//中间
        Rectangle {
            Layout.alignment: Qt.AlignRight
            color: "gray"
            Layout.fillWidth: true
            Layout.fillHeight: true
            Layout.preferredWidth:  window.width
            Layout.preferredHeight: 600

            RowLayout {
                id: layout2
                anchors.fill: parent
                Rectangle {
                    color: 'teal'

                    Layout.fillHeight: true
                    Layout.preferredWidth: 200
                    Layout.preferredHeight: 600
                    ColumnLayout{
                        spacing: 1
                        anchors.fill: parent
                        Rectangle{
                                //color: 'blue'
                                Layout.preferredWidth: 200
                                Layout.preferredHeight: 150

                        }
                        Rectangle{

                                color: 'plum'
                                Layout.preferredWidth: 200
                                Layout.preferredHeight: 150
                        }
                        Rectangle{
                                color: 'blue'
                                Layout.fillHeight:  true
                                Layout.preferredWidth: 200
                                Layout.preferredHeight: 300
                        }
                   }
             }
                Rectangle {
                    color: 'plum'
                    Layout.fillWidth: true
                    Layout.fillHeight: true
                    Layout.preferredWidth: 1000
                    Layout.preferredHeight: 600

                }
            }
        }
//第三排
        Rectangle {
            Layout.alignment: Qt.AlignBottom
            Layout.preferredWidth:  window.width
            Layout.preferredHeight: 100

           RowLayout {
                id: layout3
                anchors.fill: parent
                spacing:0
                Rectangle {
                    color: 'teal'
                    Layout.preferredWidth: 200
                    Layout.preferredHeight: 100


                }
                Rectangle {
                    color: 'plum'
                    Layout.fillWidth: true
                    Layout.preferredWidth: 700
                    Layout.preferredHeight: 100

                }
                Rectangle {
                    color: 'gray'
                    Layout.fillWidth: true
                    Layout.preferredWidth: 200
                    Layout.preferredHeight: 100

                }
                Rectangle{
                    color: 'teal'
                    Layout.fillWidth: true
                    Layout.preferredWidth: 100
                    Layout.preferredHeight: 100

                }
            }
        }
    }

}



