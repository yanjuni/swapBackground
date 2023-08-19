import QtQuick 2.12
import QtQuick.Window 2.12
import QtQml.Models 2.1
import QtQuick.Controls 2.12
import QtQuick.Dialogs 1.2
import "qrc:/qml"
Window {
    id:root01
    visible: true
    maximumWidth: 610
    maximumHeight: 900

    minimumWidth: 610
    minimumHeight: 900
    modality: Qt.ApplicationModal

    title: qsTr("Mk_simon")
    property alias root: root01
    property int step: 50
    property url picPath
    property string fileName
    property int isSe02: 0
    property string mouseColStr:"选定颜色:"
                                +worker01.r+","
                                +worker01.g+","
                                +worker01.b

    Component.onCompleted: {
         // 信号signal1
        worker01.setMouseColorSig.connect(setMouseColorSlot);
        worker01.mkPathSig()
     }
    Shortcut {
        sequence: "Ctrl+Q"
        onActivated: {
            console.log("---------------Ctrl+Q------------")
            worker01.exitSlot();
            Qt.quit()
        }
    }
    Shortcut {
        sequence: "Ctrl+w"
        onActivated: {
            console.log("---------------Ctrl+w------------")
            worker01.getMouseColorSig();

        }
    }
    Shortcut {
        sequence: "Ctrl+s"
        onActivated: {
            console.log("---------------Ctrl+s------------")
            savePic()

        }
    }


    function setMouseColorSlot(){
        root.mouseColStr="选定颜色:"
                    +worker01.r.toString()+","
                    +worker01.g.toString()+","
                    +worker01.b.toString()
        setCorTimer.running = true;
    }

    Button{
        id:selectPicButton
        anchors.leftMargin: 5
        anchors.rightMargin: 5
        text:"图片"
        width: 50
        height: 20
        property  int showDgxFlag:1
        property  int cnt:1
        z:99
        onClicked: {
            showDgxFlag = !showDgxFlag
            fd01.open();
        }
    }
    FileDialog{
        id:fd01
        nameFilters: [
            "图片(*.jpg *.jpeg *.bmp *.png)",
            "jpg(*.jpg)",
            "jpeg(*.jpeg)",
            "bmp(*.bmp)",
            "png(*.png)",
            "all(*.*)",
        ]
        onFileUrlChanged: {
            wa01.picPathUrl = fileUrl

            var filenameList =fileUrl.toString().split(".");
            filenameList.pop()
            root.fileName= filenameList.pop().split("/").pop();
        }
    }
    ColorDialog{
        id:cd01
         color:"white";
        onColorChanged: {
            wa01.color = cd01.color
        }
    }
    Button{
        id:sCorB
        anchors.left: selectPicButton.right
        anchors.leftMargin: 5
        anchors.rightMargin: 5
        text:"背景颜色"
        width: 80
        height: 20
        property  int cnt:1
        z:99
        onClicked: {
            cd01.open();

        }
        background:Rectangle{
        implicitWidth:80
        implicitHeight:60
        color:sCorB.pressed?"yellow":cd01.color
        border.width:2
        border.color:(sCorB.hovered||sCorB.pressed)?"blue":"green"
        }
    }

    Button{
        id:mouseColB
        anchors.left: sCorB.right
        anchors.leftMargin: 5
        anchors.rightMargin: 5
        Text {
        y:3
        renderType: Text.NativeRendering
        horizontalAlignment: Text.Left
        text:root.mouseColStr
      }


        width: 120
        height: 20
        property  color color1:"green"
        property  int cnt:1
        z:99

        background:Rectangle{
        implicitWidth:80
        implicitHeight:60
        color:mouseColB.color1
        border.width:2
        border.color:(mouseColB.hovered||mouseColB.pressed)?"blue":"green"
        }
    }
    Button{
        id:isSe02B
        anchors.right: isSliShow.left
        anchors.leftMargin: 5
        anchors.rightMargin: 5
        text:root.isSe02?"隐藏图层2":"显示图层2"
        width: 80
        height: 20
        z:99
        onClicked: {
            root.isSe02=!root.isSe02;
        }
    }

    Button{
        id:isSliShow
        anchors.right: savePicB.left
        anchors.leftMargin: 5
        anchors.rightMargin: 5
        text:wa01.isSliShow?"隐藏滑竿":"显示滑竿"
        width: 80
        height: 20
        z:99
        onClicked: {
            if(wa01.isSliShow){
                wa01.se01.lastR = wa01.se01.r
                wa01.se01.r = 0
            }else{
                wa01.se01.r = wa01.se01.lastR
                wa01.se01.lastR = 0
            }
            wa01.isSliShow=!wa01.isSliShow;
        }

    }

    Button{
        id:savePicB
        anchors.right: parent.right
        anchors.leftMargin: 5
        anchors.rightMargin: 5
        text:"保存"
        width: 80
        height: 20
        property  int showDgxFlag:1
        property  int cnt:1
        z:99
        onClicked: {
            savePic()
        }

    }

    WorkZoom{
        id:wa01
        anchors.right: parent.right
        anchors.bottom: parent.bottom
        width: parent.width
        height: parent.height-selectPicButton.height

    }

    Timer{
        id:savePicTimer01
        interval: 500;
        running: false;
        repeat: false
        onTriggered: {
            console.log("savePicTimer01 onTriggered")
            isSliShow.clicked()
        }
    }
    Timer {
        id:setCorTimer
        interval: 20;
        running: false;
        repeat: false
        onTriggered: {
            wa01.rSlider011.setValue(worker01.r-step)
            wa01.rSlider011.setValue2(worker01.r+step)
            wa01.gSlider011.setValue(worker01.g-step)
            wa01.gSlider011.setValue2(worker01.g+step)
            wa01.bSlider011.setValue(worker01.b-step)
            wa01.bSlider011.setValue2(worker01.b+step)
        }
    }
    function savePic(){
        isSliShow.clicked()
        var widthTmp=  wa01.width
        var heightTmp=  wa01.height


        wa01.se01.grabToImage(function(result) {
            result.saveToFile("./Pic/"+root.fileName+"_无背景.png");
        });

        wa01.grabToImage(function(result) {
            result.saveToFile("./Pic/"+root.fileName+"_大.png");
        });

        wa01.width=413
        wa01.height=626
        wa01.grabToImage(function(result) {
            result.saveToFile("./Pic/"+root.fileName+"_2寸.png");
        });
        wa01.width=390
        wa01.height=567
        wa01.grabToImage(function(result) {
            result.saveToFile("./Pic/"+root.fileName+"_小2寸.png");
        });
        wa01.width=295
        wa01.height=413
        wa01.grabToImage(function(result) {
            result.saveToFile("./Pic/"+root.fileName+"_1寸.png");
        });
        wa01.width=widthTmp
        wa01.height=heightTmp
        savePicTimer01.running=1
        console.log("savePicB onClicked")
    }
}
