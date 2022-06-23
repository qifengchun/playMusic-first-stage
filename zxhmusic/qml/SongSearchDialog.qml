import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import QtQuick.Dialogs

ApplicationWindow {
    id:songSearchWindow
    width:600
    height:500
    title: qsTr("搜索歌曲")
    visible: true
    property bool networkPlay:false
    property bool network:false
    property bool videoPlayFlag: false
    property double mX:0.0
    property double mY:0.0
    property alias songListView: songListView
    property alias play1: play1
    //    property alias pauseVideo: pauseVideo
    property alias songListModel: songListModel
    property alias inputField: inputField
    property string netLyric:""



    background: Image {
        id: name
        fillMode: Image.PreserveAspectCrop
        source: imageUrl
        anchors.fill: parent
        opacity: 0.3
    }
    //搜索的主界面
    Rectangle{
        id:re1
        visible: true
        ColumnLayout{
            spacing: 10
            RowLayout{
                id:rowLayout
                TextField{
                    id:inputField
                    Layout.preferredWidth:300
                    Layout.preferredHeight: 40
                    Layout.leftMargin: (songSearchWindow.width-inputField.width)/2.5
                    focus: true
                    placeholderText: qsTr("薛之谦")
                    Layout.topMargin: 30
                    selectByMouse: true//鼠标可以选择
                    font.pointSize: 12//字体大小
                    background: Rectangle{//设置边框
                        radius: 4
                        border.color: "black"
                    }
                    Keys.onPressed: {
                        if(event.key===Qt.Key_Return)
                        {
                            kugou.kuGouSong.searchSong(inputField.placeholderText)
                            inputField.text=inputField.placeholderText
                        }else{
                            kugou.kuGouSong.searchSong(inputField.text)
                        }
                    }



                }
                Button{
                    id:songSearchButton
                    text: qsTr("搜索")
                    Layout.preferredWidth: 70
                    Layout.preferredHeight: 40
                    Layout.topMargin: 30

                    onClicked: {
                        if(inputField.text.length===0){}else{}
                    }

                }
            }
            TabBar{
                id:bar
                Layout.preferredWidth: parent.width/3

                TabButton{
                    text:qsTr("单曲")
                    implicitHeight: 30
                    implicitWidth:10
                    onClicked: {
                        if(inputField.text.length===0){}else{}

                    }
                }

                TabButton {
                    text: qsTr("歌单")
                    implicitHeight:30
                    implicitWidth: 10
                    onClicked: {
                        if(inputField.text.length===0) {
                            kugou.kuGouPlayList.searchPlayList(inputField.placeholderText)
                            inputField.text=inputField.placeholderText
                        } else {
                            kugou.kuGouPlayList.searchPlayList(inputField.text)
                        }
                    }
                }

                TabButton{
                    text: qsTr("mv")
                    implicitHeight: 30
                    implicitWidth: 10
                    onClicked: {
                        if(inputField.text.length===0) {}else{}

                    }

                }
            }
            //StackLayout 类提供了一个项目堆栈，其中一次只有一个项目可见
            StackLayout {
                id: stack
                width: parent.width
                height: parent.height-bar.height-rowLayout-15
                currentIndex: bar.currentIndex//当前索引
                //歌曲界面
                Rectangle{
                    id:rec1
                    radius: 4
                    Layout.preferredWidth: songSearchWindow.width
                    Layout.preferredHeight: songSearchWindow.height-inputField.height
                    visible:false
                    border.color: "black"//边框颜色
                    //搜索歌曲排列

                    ColumnLayout{
                        anchors.fill: parent
                        //搜索歌曲的信息排列
                        RowLayout{
                            id:row1
                            Layout.fillWidth: true
                            Layout.leftMargin: 5
                            Text {
                                Layout.preferredWidth: 160
                                Layout.rightMargin: 40
                                text: qsTr("歌曲")
                                font.pixelSize: 15
                            }
                            Text {
                                Layout.preferredWidth: 120
                                Layout.rightMargin: 40
                                text: qsTr("专辑")
                                font.pixelSize: 15
                            }
                            Text {
                                Layout.preferredWidth: 80
                                text: qsTr("时长")
                                font.pixelSize: 15
                            }
                            Text {
                                Layout.preferredWidth: 60
                                Layout.leftMargin: 40
                                text: qsTr("来源")
                                font.pixelSize: 15
                            }
                        }
                        ListView{
                            id:songListView
                            Layout.preferredWidth: songSearchWindow.width
                            Layout.leftMargin: 5
                            Layout.preferredHeight: parent.height-row1.height
                            clip: true//此属性保存是否启用剪辑。 默认剪辑值为 false.
                            //                            //如果启用了剪辑，则项目会将其自己的绘画以及其子项的绘画剪辑到其边界矩形。
                            spacing: 5
                            model:songListModel
                            delegate: songListDelegate
                            //                            //垂直互式滚动条
                            ScrollBar.vertical: ScrollBar {
                                width: 12

                                policy: ScrollBar.AlwaysOn//ScrollBar.AsNeeded仅当内容太大而无法容纳时，才会显示滚动条。
                            }
                        }
                    }
                    ListModel{
                        id:songListModel

                    }
                    Component{
                        id:songListDelegate
                        Rectangle {

                            radius: 4
                            width: songListView.width - 20
                            height: 40
                            focus: true
                            color:ListView.isCurrentItem ? "lightgrey" : "white"//选择时的颜色
                            RowLayout{
                                id:sarchLayout
                                Text {
                                    text:song
                                    Layout.preferredWidth: 160
                                    Layout.rightMargin: 40
                                    elide: Text.ElideRight
                                }
                                Text {
                                    text: album
                                    Layout.preferredWidth: 120
                                    Layout.rightMargin: 40
                                    elide: Text.ElideRight
                                }
                                Text {
                                    text: duration
                                    Layout.preferredWidth: 80
                                    Layout.rightMargin: 20
                                }
                                Text {
                                    id: kugouText
                                    text: qsTr("酷狗音乐")
                                    Layout.preferredWidth:60
                                }
                            }
                            TapHandler{
                                id:tapHandler
                                acceptedButtons: Qt.RightButton
                                onTapped: {
                                    mX=mouseArea1.mouseX
                                    mY=mouseArea1.mouseY
                                    menu1.open()
                                }
                            }
                            MouseArea{
                                id:mouseArea1
                                anchors.fill: parent
                                acceptedButtons: Qt.LeftButton
                                onClicked: {
                                    if(mouse.button===Qt.LeftButton) {
                                        songListView.currentIndex=index//索引
                                    }
                                }
                                onDoubleClicked: {
                                    play1.trigger()
                                }
                            }
                            Menu{
                                id:menu1
                                x:mX
                                y:mY
                                contentData: [
                                    play1,
                                    pause1,
                                    downloadSong
                                ]

                            }


                        }
                    }
                }
                //歌单界面
                Rectangle{
                    id:rec2
                    radius: 4
                    Layout.preferredWidth: songSearchWindow.width
                    Layout.preferredHeight: songSearchWindow.height-inputField.height
                    visible: false
                    border.color: "black"

                    ColumnLayout{
                        anchors.fill: parent
                        RowLayout{
                            id:row2
                            Layout.fillWidth: true
                            Layout.leftMargin: 5
                            Text {
                                Layout.preferredWidth: 220
                                Layout.rightMargin: 40
                                text: qsTr("歌单名")
                                font.pixelSize: 15
                            }
                            Text {
                                Layout.preferredWidth: 120
                                Layout.rightMargin: 40
                                text: qsTr("创建人")
                                font.pixelSize: 15
                            }
                            Text {
                                Layout.preferredWidth: 60
                                text: qsTr("收藏")
                                font.pixelSize: 15
                            }
                        }
                        ListView{
                            id:playListView
                            Layout.preferredWidth: songSearchWindow.width
                            Layout.leftMargin: 5
                            Layout.preferredHeight: parent.height-row2.height
                            clip: true
                            spacing: 5
                            model:playListModel
                            delegate: playListDelegate
                            ScrollBar.vertical: ScrollBar {
                                width: 12
                                policy: ScrollBar.AlwaysOn
                            }
                        }

                    }
                    ListModel{
                        id:playListModel
                    }
                    Component {
                        id:playListDelegate
                        Rectangle {
                            radius: 4
                            width: playListView.width - 20
                            height: 40
                            focus: true
                            color:ListView.isCurrentItem ? "lightgrey" : "white"
                            RowLayout{
                                id:sarchLayout
                                Text {
                                    text:specialName//歌单名c加加
                                    Layout.preferredWidth: 220
                                    Layout.rightMargin: 40
                                    elide: Text.ElideRight//省略，设置此属性以删除适合文本项宽度的部分文本.仅当设置了显式宽度时，文本才会消失。
                                }
                                Text {
                                    text: nickName//创建人
                                    Layout.preferredWidth: 120
                                    Layout.rightMargin: 40
                                    elide: Text.ElideRight
                                }
                                Text {
                                    text: playCount//收藏量
                                    Layout.preferredWidth: 60
                                }

                            }
                            MouseArea{
                                id:mouseArea2
                                anchors.fill: parent
                                acceptedButtons: Qt.LeftButton
                                onClicked: {
                                    if(mouse.button===Qt.LeftButton) {
                                        playListView.currentIndex=index//引用
                                    }
                                }
                                //点击事件需要C加加实现
                                onDoubleClicked: {
                                    re1.visible=false
                                    re2.visible=true
                                    songModel.clear()
                                    kugou.kuGouPlayList.getSongList(playListView.currentIndex)
                                }
                            }
                        }
                    }
                }
                //MV界面
                Rectangle{
                    id:rec3
                    radius: 4
                    Layout.preferredWidth: songSearchWindow.width
                    Layout.preferredHeight: songSearchWindow.height-inputField.height
                    visible:false
                    border.color: "black"

                    GridView{
                        id: mvListView
                        anchors.fill:parent
                        anchors.leftMargin: 25
                        cellWidth: (parent.width-40)/4
                        cellHeight: parent.height/3.5
                        clip: true//剪辑
                        model:mvListModel
                        delegate: mvListDelegate
                        ScrollBar.vertical: ScrollBar {
                            width: 12
                            policy: ScrollBar.AlwaysOn //滚动条一直显示
                        }

                    }
                    ListModel{
                        id:mvListModel
                    }
                    Component{
                        id:mvListDelegate
                        Rectangle{
                            width: (rec3.width-40)/4
                            height: rec3.height/3.5
                            focus: true
                            color:ListView.isCurrentItem ? "lightgrey" : "white"
                            ColumnLayout{
                                id:searchLayout
                                spacing: 5
                                Image {
                                    id: mvImage
                                    source: mvPic
                                    Layout.preferredWidth: (rec3.width-40)/4-20
                                    Layout.preferredHeight: rec3.height/3.5-50
                                    Layout.topMargin: 10
                                    fillMode: Image.PreserveAspectCrop//设置此属性以定义当源图像的大小与项目不同时发生的情况。统一缩放不裁剪
                                    MouseArea{
                                        id:mouseArea3
                                        anchors.fill: parent
                                        acceptedButtons: Qt.LeftButton
                                        onClicked: {
                                            if(mouse.button===Qt.LeftButton) {
                                                mvListView.currentIndex=index
                                                playVideo.trigger()
                                            }
                                        }
                                    }
                                }
                                Text {
                                    id:mvNameText
                                    text:mvName
                                    Layout.preferredWidth: (rec3.width-40)/4-20
                                    lineHeight: 0.7
                                    elide: Text.ElideRight
                                    HoverHandler{
                                        onHoveredChanged: {
                                            if(hovered) {
                                                mvNameText.color="Teal"
                                            } else {
                                                mvNameText.color="black"
                                            }
                                        }
                                    }
                                    TapHandler{
                                        onTapped: {
                                            mvListView.currentIndex=index
                                            playVideo.trigger()
                                        }
                                    }
                                }
                                Text {
                                    text: mvSinger
                                    lineHeight: 0.7//设置文本的行高。 该值可以是像素或乘数
                                    color: "Teal"
                                    Layout.preferredWidth: (rec3.width-40)/4-20
                                    elide: Text.ElideRight//省略

                                    //鼠标和平板电脑悬停处理程序
                                    HoverHandler{
                                        //不同的设备显示不同的文字颜色
                                        onHoveredChanged: {
                                            if(hovered) {
                                                mvNameText.color="Teal"
                                            } else {
                                                mvNameText.color="black"
                                            }
                                        }
                                    }
                                    TapHandler{
                                        onTapped: {
                                            mvListView.currentIndex=index
                                            playVideo.trigger()
                                        }
                                    }
                                    Text{
                                        id:mvSinger
                                        color: "Teal"
                                        Layout.preferredWidth: (rec3.width-40)/4-20
                                        elide: Text.ElideRight

                                    }
                                }



                            }

                        }

                    }
                }
            }

        }

    }
    //退出之后清理后台缓存资源
    onClosing: {
        songListModel.clear()
        playListModel.clear()
        mvListModel.clear()
        network = false
        inputField.clear();
    }
    //进入歌单后的界面
    Rectangle{
        id:re2
        visible: false
        ColumnLayout{
            spacing: 5
            RowLayout{
                Button{
                    id:backButton
                    Layout.preferredWidth: 70
                    Layout.preferredHeight: 40
                    text: "返回"
                    Layout.topMargin:10
                    //点击之后返回主界面
                    onClicked: {
                        re1.visible=true
                        re2.visible=false
                    }
                }
                Text{
                    id:spacialText
                    Layout.alignment: Qt.AlignCenter//居中
                    Layout.topMargin:10
                    Layout.preferredWidth: 400
                    elide: Text.ElideRight//省略
                    //需要C加加实现
                    text: kugou.kuGouPlayList.specialName[playListView.currentIndex]+"--歌曲列表"

                }
            }
            //歌曲展示
            Rectangle{
                id:re4
                radius: 4
                Layout.preferredWidth: songSearchWindow.width
                Layout.preferredHeight: songSearchWindow.height-backButton.height
                border.color: "black"
                ListView{
                    id:songList
                    anchors.fill: parent
                    Layout.leftMargin: 5
                    clip: true//剪辑
                    spacing: 5
                    model: songModel
                    delegate: songDelegate
                    ScrollBar.vertical: ScrollBar {
                        width: 12
                        policy: ScrollBar.AlwaysOn
                    }
                }
                ListModel{
                    id:songModel
                }
                Component{
                    id:songModel
                    Rectangle{
                        radius: 4
                        width: songList.width - 20
                        height: 40
                        focus: true
                        color:ListView.isCurrentItem ? "lightgrey" : "white"
                        RowLayout{
                            Text {
                                text: serialNum//歌曲序号
                                Layout.leftMargin: 10
                                Layout.preferredWidth: 50
                                Layout.rightMargin: 30
                                elide: Text.ElideRight
                            }
                            Text {
                                text: songName//歌曲名
                                Layout.preferredWidth: 220
                                Layout.rightMargin: 60
                                elide: Text.ElideRight
                            }
                            Text {
                                text: albumName//专辑名
                                Layout.preferredWidth: 120
                                elide: Text.ElideRight
                            }


                        }
                        //右键选项菜单
                        TapHandler{
                            id:tapHandler
                            acceptedButtons: Qt.RightButton
                            onTapped: {
                                mX=mouseArea4.mouseX
                                mY=mouseArea4.mouseY
                                menu2.open()
                            }
                        }
                        //左键播放选中歌曲
                        MouseArea{
                            id:mouseArea4
                            anchors.fill: parent
                            acceptedButtons: Qt.LeftButton
                            onClicked: {
                                if(mouse.button===Qt.LeftButton) {
                                    songList.currentIndex=index
                                }
                            }
                            onDoubleClicked: {
                                play1.trigger()
                            }
                        }
                        Menu{
                            id:menu2
                            x:mX
                            y:mY
                            contentData: [
                                play1,
                                pause1,
                                downloadSong
                            ]


                        }
                    }
                }
            }
        }
        KuGou{
            id:kugou
        }
        VideoPage{
            id:videoPage
        }

    }




}



















