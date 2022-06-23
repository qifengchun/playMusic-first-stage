import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import QtQml.Models 2.15
import Song 1.0

ApplicationWindow {
    id:trackInformationDialog
    title:qsTr("曲目信息")
    width:680
    height:450

    property bool flag:false
    property var map:{"标题":" ","艺术家":" ","唱片集":" ","注释":" ","日期":" ","流派":" "};
    property alias song:song
    property alias albumImage:albumImage
    signal showalbumArt

    onShowalbumArt: {
        var str
        if("/*如果歌曲是从网上搜索的*/"){
            str="1"
        }
        else{//歌曲不是从网上搜索的
            str=""
        }
        dialogs.trackInformationDialog.song.getInformations(str,dirPath)
        dialogs.trackInformationDialog.get_Information_Meta()
        dialogs.trackInformationDialog.albumImage.source=""
        if(dialogs.trackInformationDialog.song.flag){
            rootImage.source=""
            rootImage.source="file://"+dirPath+"/pic.png"
            dialogs.trackInformationDialog.albumImage.source="file://"+dirPath+"/pic.png"
        }
        else if("/*如果歌曲是从网上搜索的*/"){
            dialogs.trackInformationDialog.albumImage.source=""
        }
        else{
            rootImage.source=imageUrl
        }
    }

    function get_Information_Meta(){
        titleInput.text="";
        artistInput.text="";
        albumInput.text="";
        genreInput.editText="";

        titleInput.text=song.Information["标题"]
        artistInput.text=song.Information["艺术家"]
        albumInput.text=song.Information["唱片集"]
        annotationInput.text=song.Information["注释"]
        if(song.Information["日期"]===0){
            dateInput.text="";
        }
        else{
            dateInput.text=song.Information["日期"]
        }
        genreInput.editText=song.Information["流派"]
        flag=false
    }

    function set_Information_Meta(){
        map["标题"]=titleInput.text;
        map["艺术家"]=artistInput.text;
        map["唱片集"]=albumInput.text;
        map["注释"]=annotationInput.text;
        map["流派"]=genreInput.editText;
        if(dateInput.text===""){
            map["日期"]=0;
        }
        else{
            map["日期"]=dateInput.text;
        }
        var path="/root/音乐播放器/playMusic-first-stage"
        song.saveInformations(path,map)
        flag=false
        trackInformationDialog.close()
    }

    ColumnLayout{
        anchors.fill:parent
        RowLayout{
            Layout.preferredWidth: parent.width
            Layout.preferredHeight: parent.height-bottomBtn.height-20
            spacing:10
            GroupBox{
                implicitWidth: parent.width/2-10
                implicitHeight: parent.height
                ColumnLayout{
                    anchors.fill:parent
                    Text{
                        id:albumArt//专辑封面
                        Layout.topMargin: 10
                        Layout.leftMargin: 10
                        text:qsTr("专辑封面")
                        Layout.alignment: Qt.AlignLeft | Qt.AlignTop
                    }
                    Image{
                        id:albumImage
                        Layout.preferredWidth: parent.width-40
                        Layout.preferredHeight: parent.height-100
                        Layout.alignment: Qt.AlignHCenter
                        fillMode:Image.PreserveAspectCrop
                        //source:skinDialog.usingImage
                    }
                }
            }
            GroupBox{
                implicitWidth: parent.width/2-10
                implicitHeight: parent.height
                ColumnLayout{
                    width:parent.width
                    spacing:10
                    Text{
                        id:information//音频信息
                        text:qsTr("音频信息")
                    }
                    ColumnLayout{
                        Layout.fillWidth:true
                        spacing:10
                        RowLayout{
                            Layout.fillWidth:true
                            Text{
                                id:title
                                text:qsTr("标题:")
                            }
                            TextField{
                                id:titleInput
                                Layout.fillWidth:true
                                focus:true
                                onTextChanged: {
                                    flag=true
                                }
                            }
                        }
                        RowLayout{
                            Layout.fillWidth:true
                            Text{
                                id:artist
                                text:qsTr("艺术家:")
                            }
                            TextField{
                                id:artistInput
                                Layout.fillWidth:true
                                focus:true
                                onTextChanged: {
                                    flag=true
                                }
                            }
                        }
                        RowLayout{
                            Layout.fillWidth:true
                            Text{
                                id:album
                                text:qsTr("唱片集:")
                            }
                            TextField{
                                id:albumInput
                                Layout.fillWidth:true
                                focus:true
                                onTextChanged: {
                                    flag=true
                                }
                            }
                        }
                        RowLayout{
                            Layout.fillWidth:true
                            Text{
                                id:date
                                text:qsTr("日期:")
                            }
                            TextField{
                                id:dateInput
                                Layout.fillWidth:true
                                focus:true
                                validator: RegularExpressionValidator{regularExpression: /[0-9]+/}
                                onTextChanged: {
                                    flag=true
                                }
                            }
                        }
                        RowLayout{
                            Layout.fillWidth:true
                            Text{
                                id:genre
                                text:qsTr("流派:")
                            }
                            ComboBox{
                                id:genreInput
                                Layout.fillWidth:true
                                height:50
                                editable: true
                                currentIndex: -1
                                model:ListModel{
                                    id:genreModel
                                    ListElement{text:"Acousic"}
                                    ListElement{text:"Abstract"}
                                    ListElement{text:"A Cappella"}
                                    ListElement{text:"Acid"}
                                    ListElement{text :"Acid Jazz"}
                                    onEditTextChanged: {
                                        flag = true
                                    }
                                }
                            }
                        }
                        RowLayout{
                            Layout.fillWidth:true
                            Text{
                                id:annotation
                                text:qsTr("注释:")
                            }
                            TextField{
                                id:annotationInput
                                Layout.fillWidth:true
                                focus:true
                                onTextChanged: {
                                    flag=true
                                }
                            }
                        }
                    }
                }
            }
        }
    }
    RowLayout{
        id:bottomBtn
        spacing:20
        Button{
            text:"保存到文件"
            onClicked: {
                set_Information_Meta();
            }
            Button{
                text:"关闭"
                onClicked: {
                    if(flag){
                        dialogs.saveDialog.open()
                    }
                    else{
                        close()
                    }
                }
            }
        }
    }
    onClosing: function(closeEvent){
        closeEvent.accepted=false
        if(flag){
            dialogs.saveDialog.open()
        }
        else{
            closeEvent.accepted=true
        }
    }

    Song{
        id:song
    }
}
