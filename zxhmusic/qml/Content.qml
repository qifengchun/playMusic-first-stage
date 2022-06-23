import QtQuick
import QtQuick.Dialogs
import QtMultimedia
import QtQuick.Controls  as QQC
import QtQuick.Layouts

Item {

    property alias player: player


    function setFilesModel(){
        filesModel.clear();
        for(var i=0;i<arguments[0].length;i++){
            var data={"filePath": arguments[0][i]};
            filesModel.append(data);
            list.model=filesModel;
            list.currentIndex=0;
        }
    }
    function song_previous(){
//接受数据
        filesModel.clear();
        for(var i=0;i<arguments[0].length;i++){
            var data={"filePath": arguments[0][i]};
            filesModel.append(data);
            list.model=filesModel;
            list.currentIndex=0;

//判断当前索引在


                  list.currentIndex = index
                   player.source = arguments[0][list.currentIndex]
                    player.play()

    }
 }


        ListView{
            z:1
            id:list
            anchors.fill: parent

            ListModel{
                id: filesModel
            }
            delegate:audioDelegate
        }



    Component{
        id:audioDelegate
        Text{
            id:rec
            text:filePath

            TapHandler{
                onTapped: {
                    list.currentIndex = index
                    console.log(index)
                    player.source=  filePath
                    player.play()
                }
            }
        }
    }
    MediaPlayer{
        id:player
        audioOutput:

            AudioOutput{


        }
    }
}
