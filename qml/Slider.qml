/****************************************************************************
**
** Copyright (C) 2016 The Qt Company Ltd.
** Contact: https://www.qt.io/licensing/
**
** This file is part of the QtQuick module of the Qt Toolkit.
**
** $QT_BEGIN_LICENSE:BSD$
** Commercial License Usage
** Licensees holding valid commercial Qt licenses may use this file in
** accordance with the commercial license agreement provided with the
** Software or, alternatively, in accordance with the terms contained in
** a written agreement between you and The Qt Company. For licensing terms
** and conditions see https://www.qt.io/terms-conditions. For further
** information use the contact form at https://www.qt.io/contact-us.
**
** BSD License Usage
** Alternatively, you may use this file under the terms of the BSD license
** as follows:
**
** "Redistribution and use in source and binary forms, with or without
** modification, are permitted provided that the following conditions are
** met:
**   * Redistributions of source code must retain the above copyright
**     notice, this list of conditions and the following disclaimer.
**   * Redistributions in binary form must reproduce the above copyright
**     notice, this list of conditions and the following disclaimer in
**     the documentation and/or other materials provided with the
**     distribution.
**   * Neither the name of The Qt Company Ltd nor the names of its
**     contributors may be used to endorse or promote products derived
**     from this software without specific prior written permission.
**
**
** THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS
** "AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT
** LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR
** A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT
** OWNER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL,
** SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT
** LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE,
** DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY
** THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
** (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE
** OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE."
**
** $QT_END_LICENSE$
**
****************************************************************************/

import QtQuick 2.0
import QtGraphicalEffects 1.14

Item {
    id:sli
    anchors.topMargin: 12
    anchors.bottomMargin: 12
    property color myCor

    property real value: bar.x / (foo.width - bar.width)
    property int value256: value*256
    property real valueSet: 0
    property string myCorStr: ""
    property string myBar1CorStr: ""
    property int isUseBar1Cor: 0


    property real value2: bar2.x / (foo.width - bar2.width)
    property int value256b: value2*256
    property real valueSet2: 0
    property string myCorStr2: ""
    property string myBar2CorStr: ""
    property int isUseBar2Cor: 0


//    onValueChanged: {
//        console.log(myCorStr,"---------value:",value)
//    }

    function setValue(value01){
        var tmpX = value01/256 *(foo.width - bar.width)
        if(tmpX>foo.width - bar.width){
            tmpX = foo.width - bar.width
        }else if(tmpX<0){
            tmpX =0
        }
        bar.x = tmpX
    }
    function setValue2(value02){
        var tmpX = value02/256 *(foo.width - bar2.width)
        if(tmpX>foo.width - bar2.width){
            tmpX = foo.width - bar2.width
        }else if(tmpX<0){
            tmpX =0
        }
        bar2.x = tmpX
    }
    Text {
        id: t1
        y:-5
//        anchors.left: parent.left
        anchors.horizontalCenter: parent.horizontalCenter
        text: myCorStr+"["+value256.toString()+","+value256b.toString()+"]"
    }

    Item {
        id: foo
        width: parent.width - 4
        height: 6
        anchors.centerIn: parent
        property int maxDragWidth: width - bar.width
//滑轨颜色
        Rectangle {
            height: parent.height
            anchors.left: bar.horizontalCenter
            anchors.right: bar2.horizontalCenter
            color: sli.myCor
            radius: 3
            LinearGradient {
                anchors.fill: parent
                start: Qt.point(0, 0)
                end: Qt.point(parent.width, 0)
                gradient: Gradient {
                    GradientStop { position: 0.0; color: myBar1CorStr }
                    GradientStop { position: 1.0; color: myBar2CorStr }
                }
            }
        }

        Rectangle {
            height: parent.height
            anchors.left: bar2.horizontalCenter
            anchors.right: parent.right
            color: "gray"
//            color: "#0000ff"
            radius: 3
        }
        Rectangle {
            height: parent.height
            anchors.left: parent.left
            anchors.right: bar.horizontalCenter
            color: "gray"
//            color: "#0000ff"
            radius: 3
        }
        Rectangle {
            anchors.fill: parent
            color: "transparent"
//            color: "#ff0000"
            radius: 3
            border.width: 2
            border.color: "black"
        }
        Rectangle {
            id: bar
            y: bar2.x<22?-7:bar2.x- bar.x<20?-24:-7
            x: sli.valueSet
            width: 20
            height:  20
            radius: 15
            color:isUseBar1Cor?myBar1CorStr: "white"
            border.width: 2
            border.color: "black"
            MouseArea {
                anchors.fill: parent
                drag.target: parent
                drag.axis: Drag.XAxis
                drag.minimumX: 0
                drag.maximumX: bar2.x-1
            }
        }
        Rectangle {
            id: bar2
            y: -7
            x: sli.valueSet2
            width: 20
            height: 20
            radius: 15
            color:isUseBar2Cor?myBar2CorStr: "white"
            border.width: 2
            border.color: "black"
            MouseArea {
                anchors.fill: parent
                drag.target: parent
                drag.axis: Drag.XAxis
                drag.minimumX: bar.x+1
                drag.maximumX: foo.maxDragWidth
            }
        }
    }
}

