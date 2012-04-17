/*
    (C) 2012 Tej A. Shah
    This file is part of BrushBreat

    BrushBreat is free software: you can redistribute it and/or modify
    it under the terms of the GNU General Public License as published by
    the Free Software Foundation, either version 3 of the License, or
    (at your option) any later version.

    BrushBreat is distributed in the hope that it will be useful,
    but WITHOUT ANY WARRANTY; without even the implied warranty of
    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
    GNU General Public License for more details.

    You should have received a copy of the GNU General Public License
    along with BrushBreat.  If not, see <http://www.gnu.org/licenses/>.
*/

import QtQuick 1.1
import com.nokia.meego 1.0
import QtMultimediaKit 1.1


Item { //A simple counter for the user before starting to play the music
    //(so the user can put the phone down before starting to play the music)
    id: countPage

    signal doneCounting //when we are done counting down
    property int counter: 3 //the current countDown number we are at

    anchors.fill: parent

    function startCountingDown() { //start the process of counting down
        countPage.opacity = 1;
        labelPleaseStart.opacity =1;
        counter =3;
        countDownAnimation.start();
    }

    function finishUp() { //make this disappear and let the parent know we are done
        labelPleaseStart.opacity =0;
        doneCounting();
    }

    function lowerCounter() { //lower the counter by one and play the beep
        //this function is here because ScriptAction wants an actual function
        counter--;
    }

    Label {
        id: labelPleaseStart
        text: qsTr("Please start brushing in:")
        horizontalAlignment: Text.AlignHCenter
        anchors.horizontalCenter: parent.horizontalCenter
        smooth: true
        Behavior on opacity { //let it fade away
            NumberAnimation {
                duration: 500
            }
        }
    }

    Label { //the actual label that will show the countdown
        id: numberText
        font.pixelSize: parent.height
        anchors.centerIn: parent
        text: counter
        smooth: true
    }

    SequentialAnimation { //do the series of steps to show the Countdown
        id: countDownAnimation
        PropertyAnimation {
            target: numberText
            properties: "scale"
            from: 1
            to: 0
            duration: 1000
        }
        ScriptAction {script: lowerCounter();}
        PropertyAnimation {
            target: numberText
            properties: "scale"
            from: 1
            to: 0
            duration: 1000
        }
        ScriptAction {script: lowerCounter();}
        PropertyAnimation {
            target: numberText
            properties: "scale"
            from: 1
            to: 0
            duration: 1000
        }
        ScriptAction {script: finishUp();}
    }
}
