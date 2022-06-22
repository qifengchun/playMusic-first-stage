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

   background: Image {
       id: name
       fillMode: Image.PreserveAspectCrop
       source: imageUrl
       anchors.fill: parent
       opacity: 0.3
   }







}
