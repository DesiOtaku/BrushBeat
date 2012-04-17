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

Item {
    id: songInfo
    opacity: 0

    property variant quadNames: [qsTr("first"),qsTr("second"),qsTr("third"),qsTr("fourth")]
    property int currentSecond
    property string songName
    property int currentQuad

    anchors.fill: parent

    Behavior on opacity {
        NumberAnimation {
            duration: 1000
        }
    }

    ProgressBar {
        id: progressBar
        anchors.centerIn: parent
        width: parent.width
        minimumValue: 0
        maximumValue: 30
        value: currentSecond
        Behavior on value{
            PropertyAnimation {
                target: value
                duration: 500
            }
        }
    }

    Label {
        anchors.bottom: progressBar.top
        text: qsTr("Now Playing: " + songName);
    }

    Label {
        anchors.top: progressBar.bottom
        text: qsTr("Seconds left: " + Math.floor(30 -progressBar.value));
    }


    Label {
        text:qsTr("Please brush the ") + quadNames[currentQuad] + qsTr(" quarter of your mouth")
        horizontalAlignment: Text.AlignHCenter
        font.pixelSize: 64;
        width: parent.width
    }
}
