import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import Qt.labs.folderlistmodel 2.12

ApplicationWindow {
    id:skinDialog
    width:650
    height:580
    title:qsTr("主题")

    property url usingImage:""

    ColumnLayout{
        Rectangle{
            width:650
            height:540
            ColumnLayout{
                anchors.fill:parent
                spacing:10
                Text{
                    Layout.topMargin: 10
                    Layout.leftMargin: 10
                    text:qsTr("正在使用")
                }
                Image{
                    id:image
                    Layout.preferredWidth: 150
                    Layout.preferredHeight: 120
                    Layout.leftMargin: 20
                    fillMode:Image.PreserveAspectCrop
                    asynchronous: true
                    source:usingImage
                }
                Text{
                    Layout.topMargin: 10
                    Layout.leftMargin: 10
                    text:qsTr("推荐")
                }
                GridView{
                    id:imageview
                    width:650
                    height:240
                    Layout.topMargin: 10
                    Layout.leftMargin: 20
                    model:imageModel
                    delegate:imageDelegate
                    cellWidth: 155
                    cellHeight: 125
                    currentIndex: 0
                    highlight: Rectangle{
                        border.color:"blue"
                        border.width:3
                    }
                }
            }
        }
        RowLayout{
            Layout.leftMargin: 20
            Layout.bottomMargin: 10
            spacing:20
            Button{
                text:"自定义"
                onClicked: {
                    dialogs.fileImageDialog.open()
                }
            }
            Button{
                text:"确定"
                onClicked: {
                    usingImage=imageUrl
                    close()
                }
            }
        }
    }

    FolderListModel{
        id:imageModel
        folder:"qrc:/background"
    }

    Component{
        id:imageDelegate
        Image{
            width:150
            height:120
            fillMode:Image.PreserveAspectCrop
            asynchronous: true
            source:fileUrl
            focus:true
            TapHandler{
                onTapped:{
                    imageview.currentIndex=index
                    imageUrl=fileUrl

                }
            }
        }
    }
}
