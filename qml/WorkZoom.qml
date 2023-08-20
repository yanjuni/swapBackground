import QtQuick 2.12
import QtQuick.Controls 2.12
import QtQml 2.12
import "qrc:/qml"
import "qrc:/glsl"
Rectangle{
    id:wa01
//    anchors.fill: parent
/*
[
          State { name: "activated" },
          State { name: "deactivated" }
      ]
*/
    property url picPathUrl: ""
    property int isSliShow: 1
    property alias se01: se01
    property alias rSlider011: rSlider01
    property alias gSlider011: gSlider01
    property alias bSlider011: bSlider01




    function setSize(w,h){
        width=w
        height=h
    }
    function printSize(){
        console.log("width:",width)
        console.log("height:",height)
    }
    Text {
        id: cntR
        text: se01.cntRecod
        z:99
        visible: isSliShow
    }

    color: "white"

    Image{
        id:picIma
        anchors.fill: parent
        source: picPathUrl
        visible: false
    }
    ShaderEffectSource {
        id: ses01
        sourceItem: picIma
    }
    ShaderEffect {
        id:se01
        z:root.isSe02?2:3
        anchors.fill: parent
        visible: 01?true:false
        property variant source: ses01
        property ShaderEffectSource effectSource: ses01
        property int rowCount: 10
        property int columnCount: 10
        property int duration: 1000
        property int dir: 0

        property variant qt_Opacity: opacity
        property real bend: 0
        property real minimize: 0
        property real xx: 0.0
        property real fxFlag: 0
        property real percent: 0

        property real sideRu: rSlider01.value2
        property real sideRd: rSlider01.value
        property real sideGu: gSlider01.value2
        property real sideGd: gSlider01.value
        property real sideBu: bSlider01.value2
        property real sideBd: bSlider01.value

        property real frequency: 20
        property real time: 0
        property real mouseX: 0
        property real mouseY: 0
        property real r: 0.07
        property real lastMouseX: 0
        property real lastMouseY: 0
        property real lastR: 0.07

        property real pX01: 0
        property real pX02: 0
        property real pX03: 0
        property real pX04: 0
        property real pX05: 0
        property real pX06: 0
        property real pX07: 0
        property real pX08: 0
        property real pX09: 0
        property real pX10: 0

        property real pY01: 0
        property real pY02: 0
        property real pY03: 0
        property real pY04: 0
        property real pY05: 0
        property real pY06: 0
        property real pY07: 0
        property real pY08: 0
        property real pY09: 0
        property real pY10: 0

        property real pR01: 0
        property real pR02: 0
        property real pR03: 0
        property real pR04: 0
        property real pR05: 0
        property real pR06: 0
        property real pR07: 0
        property real pR08: 0
        property real pR09: 0
        property real pR10: 0

        property int maxRecod:10
        property int cntRecod:0


        function popMousePos(){
            if(cntRecod){
                cntRecod--
            }
            console.log(cntRecod)
        }

        function saveMousePos(){
            if(
                    lastMouseX==mouseX&&
                    lastMouseY==mouseY&&
                    lastR==r
              ){console.log("没变化")}
            else if(maxRecod<=cntRecod){console.log("最多存"+maxRecod+"组")}
            else{
                cntRecod++
                 switch(cntRecod){
                 case 1:{
                     pX01 = mouseX
                     pY01 = mouseY
                     lastMouseX=mouseX
                     lastMouseY=mouseY
                     pR01=r
                 break;
                 }
                 case 2:{
                     pX02 = mouseX
                     pY02 = mouseY
                     lastMouseX=mouseX
                     lastMouseY=mouseY
                     pR02=r
                 break;
                 }
                 case 3:{
                     pX03 = mouseX
                     pY03 = mouseY
                     lastMouseX=mouseX
                     lastMouseY=mouseY
                     pR03=r
                 break;
                 }
                 case 4:{
                     pX04 = mouseX
                     pY04 = mouseY
                     lastMouseX=mouseX
                     lastMouseY=mouseY
                     pR04=r
                 break;
                 }
                 case 5:{
                     pX05 = mouseX
                     pY05 = mouseY
                     lastMouseX=mouseX
                     lastMouseY=mouseY
                     pR05=r
                 break;
                 }
                 case 6:{
                     pX06 = mouseX
                     pY06 = mouseY
                     lastMouseX=mouseX
                     lastMouseY=mouseY
                     pR06=r
                 break;
                 }
                 case 7:{
                     pX07 = mouseX
                     pY07 = mouseY
                     lastMouseX=mouseX
                     lastMouseY=mouseY
                     pR07=r
                 break;
                 }
                 case 8:{
                     pX08 = mouseX
                     pY08 = mouseY
                     lastMouseX=mouseX
                     lastMouseY=mouseY
                     pR08=r
                 break;
                 }
                 case 9:{
                     pX09 = mouseX
                     pY09 = mouseY
                     lastMouseX=mouseX
                     lastMouseY=mouseY
                     pR09=r
                 break;
                 }
                 case 10:{
                     pX10 = mouseX
                     pY10 = mouseY
                     lastMouseX=mouseX
                     lastMouseY=mouseY
                     pR10=r
                 break;
                 }
                 default:{
                 break;
                 }
                 }

                 console.log(pR[0])
//                 console.log(pX01,pY01,pR01,cntRecod)
//                 console.log(pX02,pY02,pR02,cntRecod)
//                 console.log(pX03,pY03,pR03,cntRecod)
            }
        }
        Shortcut {
            sequence: "Ctrl+e"
            onActivated: {
                console.log("---------------Ctrl+e------------")
                se01.saveMousePos()
            }
        }
        Shortcut {
            sequence: "Ctrl+z"
            onActivated: {
                console.log("---------------Ctrl+z------------")
                se01.popMousePos()
            }
        }
        fragmentShader: "qrc:/glsl/cbk01.frag"

        //! [vertex]
        mesh: Qt.size(10, 10)
        //! [vertex]

        MouseArea{
            id:ma01
            anchors.fill: parent
            acceptedButtons: Qt.LeftButton|Qt.RightButton;
            property int isLB: 0
            onPressed: {
//                console.log("onPressed in ",isLB)
                if(mouse.button==Qt.LeftButton)
                    {
                    isLB =1;
                    }
                    else
                    {
                    }
            }
            onReleased: {
                if(mouse.button==Qt.LeftButton)
                    {
                        isLB =0;
                    }
                    else
                    {
                    }
            }
            onClicked: {
                if(mouse.button==Qt.LeftButton)
                    {
                    }
                    else
                    {
                    se01.saveMousePos()
                    }

            }
            onDoubleClicked: {
                if(mouse.button==Qt.LeftButton)
                    {
                    worker01.getMouseColorSig();
                    }
                    else
                    {
                    }
            }
            onWheel: {
                if(wheel.angleDelta.y>0){
                    se01.r +=  0.01
                }else{
                    se01.r -=  0.01
                }
            }

            onMouseXChanged: {
                if(isLB){
                    se01.mouseX = mouseX/se01.width
                }
            }
            onMouseYChanged: {
                if(isLB){
                    se01.mouseY = mouseY/se01.height
                }
            }

        }

    }


    DropArea {
                anchors.fill: parent
                onDropped: {
                    if(drop.hasUrls){
                        for(var i = 0; i < drop.urls.length; i++){
                            console.log(i,drop.urls[i]);
                            console.log(i,drop.urls[i].slice(8,)); //去掉前缀：file:///
                              var fileName = drop.urls[i]
                              var filenameList =fileName.split(".");
                              var ss = filenameList.pop()
                              root.fileName= filenameList.pop().split("/").pop();

                            console.log(i,ss);
                            console.log("root.fileName:",root.fileName);
                              if(ss=="jpg"||ss=="jpeg"||ss=="bmp"||ss=="png"){
                                      picIma.source = drop.urls[i]
                                  break
                              }
                        }
                    }
                }
            }

    Slider {
        z:4
        id: rSlider01
        anchors.left: parent.left
        anchors.right: parent.right
        anchors.bottom: gSlider01.top
        height: 20
        myCorStr: "红色："
        myCor:"red"
        visible: isSliShow&&!root.isSe02
        isUseBar1Cor: 1
        isUseBar2Cor: 1
        myBar1CorStr:"#ffb9b9"
        myBar2CorStr:"#FF0000"
//        valueSet2:width-20-4

    }

    Slider {
        z:4
        id: gSlider01
        anchors.left: parent.left
        anchors.right: parent.right
        anchors.bottom: bSlider01.top
        height: 20
        myCorStr: "绿色："
        myCor:"green"
        visible: isSliShow&&!root.isSe02
        isUseBar1Cor: 1
        isUseBar2Cor: 1
        myBar1CorStr:"#b9ffb9"
        myBar2CorStr:"#00FF00"
    }

    Slider {
        z:4
        id: bSlider01
        anchors.left: parent.left
        anchors.right: parent.right
        anchors.bottom: parent.bottom
        height: 20
        myCorStr: "蓝色："
        myCor:"blue"
        visible: isSliShow&&!root.isSe02
        isUseBar1Cor: 1
        isUseBar2Cor: 1
        myBar1CorStr:"#b9b9ff"
        myBar2CorStr:"#0000FF"
    }

    Slider {
        z:4
        id: rSlider02
        anchors.left: parent.left
        anchors.right: parent.right
        anchors.bottom: gSlider01.top
        height: 20
        myCorStr: "红色："
        myCor:"red"
        visible: isSliShow&&root.isSe02
        isUseBar1Cor: 1
        isUseBar2Cor: 1
        myBar1CorStr:"#ffb9b9"
        myBar2CorStr:"#FF0000"
//        valueSet2:width-20-4

    }

    Slider {
        z:4
        id: gSlider02
        anchors.left: parent.left
        anchors.right: parent.right
        anchors.bottom: bSlider01.top
        height: 20
        myCorStr: "绿色："
        myCor:"green"
        visible: isSliShow&&root.isSe02
        isUseBar1Cor: 1
        isUseBar2Cor: 1
        myBar1CorStr:"#b9ffb9"
        myBar2CorStr:"#00FF00"
    }

    Slider {
        z:4
        id: bSlider02
        anchors.left: parent.left
        anchors.right: parent.right
        anchors.bottom: parent.bottom
        height: 20
        myCorStr: "蓝色："
        myCor:"blue"
        visible: isSliShow&&root.isSe02
        isUseBar1Cor: 1
        isUseBar2Cor: 1
        myBar1CorStr:"#b9b9ff"
        myBar2CorStr:"#0000FF"
    }


}
