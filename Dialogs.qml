import QtQuick
import QtQuick.Controls 2.5 as QQC
import QtQuick.Dialogs
import Qt.labs.platform

Item {
    property alias fileOpenDialog: fileOpen


    property alias skinDialog:skinDialog
    property alias fileImageDialog:fileimageDialog
    //property alias aboutDialog:aboutDialog

    function openFileDialog() { fileOpen.open(); }
    function openAboutDialog() { about.open(); }
//打开音乐文件
    FileDialog {
        id: fileOpen
        title: "Select some music files"
        fileMode: FileDialog.OpenFiles
        nameFilters: [ "Song files (*.mp3)" ]


    }



//工具栏中的主题
    FileDialog{
        id:fileimageDialog
        title:"请选择一张图片"
        //folder:shortcuts.documents
        nameFilters:["Image files (*.png *.jpeg *.jpg)"]
        onAccepted: {
            imageUrl=fileImageDialog.fileUrl
            dialogs.skinDialog.usingImage=imageUrl
            dialogs.skinDialog.close()
        }
    }
//帮助
    QQC.Dialog{
        id:about
        title:"关于"
        contentItem:Text{
            text:"本软件名为Cloud Music,由齐逢春，向文勇，曾祥欢共同实现。"
        }
        standardButtons: StandardButton.Ok
    }

    SkinDialog{
        id:skinDialog
        visible:false
    }


}
