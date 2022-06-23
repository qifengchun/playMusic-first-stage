import QtQuick
import QtQuick.Controls 2.5 as QQC
import QtQuick.Dialogs
import Qt.labs.platform

Item {

    function openAboutDialog() { about.open(); }

    property alias fileImageDialog:fileimageDialog
    property alias skinDialog:skinDialog
    property alias trackInformationDialog:trackInformationDialog
    property alias saveDialog:saveDialog
    //property alias aboutDialog:aboutDialog

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

    TrackInformationDialog{
        id:trackInformationDialog
        visible:false
    }

    QQC.Dialog{
        id:saveDialog
        title:qsTr("提示")
        text:qsTr("曲目信息已被修改，是否要进行保存？")
        standardButtons:StandardButton.Save| StandarButton.Discard|StandardButton.Cancel
        onButtonClicked:{
            if(clickedButton===StandardButton.Save){
                if(dialogs.trackInformationDialog.visible){
                    dialogs.trackInformationDialog.set_Information_Meta()
                }
            }
            else if(StandarButton.Discard){
                if(dialogs.trackInformationDialog.visible){
                    dialogs.trackInformationDialog.flag=flase
                    dialogs.trackInformationDialog.close()
                }
            }
            else{
                close()
            }
        }
    }
}
