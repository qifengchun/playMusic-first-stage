import QtQuick
import QtQuick.Layouts
import QtQuick.Controls

ApplicationWindow {
    id:appwindow
    width: 840
    height: 680
    visible: true
    title: qsTr("Music")

    menuBar:MenuBar{
        id:menubar
        Menu{
            title:qsTr("&文件")
            contentData: [
                actions.openFileAction,//打开音乐
                actions.openFolderAction,
                actions.exitAction
            ]
        }

        Menu{
            title:qsTr("&歌词")
            contentData: [
                actions.openLyricAction,//打开歌词
                actions.closeLyricAction//关闭歌词
            ]
        }

        Menu{
            title:qsTr("&歌单")
            contentData: [
                actions.addSongListAction,//添加歌单
            ]
        }

        Menu{
            title:qsTr("&播放列表")
            contentData:[
                actions.songListAction,//歌曲列表
                actions.songdeleteAction,//删除歌曲
                actions.songSearchAction,//搜索歌曲
                actions.mvSearchAction//搜索MV
            ]
        }

        Menu{
            title:qsTr("&工具")
            contentData:[
                actions.recentPlayAction,//最近播放
                actions.skinAction,//主题
                actions.trackInformationAction//曲目信息
            ]
        }

        Menu{
            title:qsTr("&登陆")
            contentData:[actions.loginAction]//登陆
        }

        Menu{
            title:qsTr("&帮助")
            contentData:[actions.aboutAction]//关于
        }
    }

    footer:ToolBar{
        RowLayout{
            ToolButton{action:actions.previousAction}
            ToolButton{action:actions.playAction}
            ToolButton{action:actions.pauseAction}
            ToolButton{action:actions.nextAction}
            ToolButton{action:actions.openLyricAction}
            ToolButton{action:actions.songListAction}
        }
    }



    Actions{
        id:actions
    }


}
