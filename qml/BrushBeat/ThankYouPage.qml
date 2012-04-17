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
import Qt.labs.particles 1.0


Page {
    id: thankYou

    Label {
        id: thankLabel
        text: qsTr("Thank you for brushing!")
        horizontalAlignment: Text.AlignHCenter
        width: parent.width
        anchors.centerIn: parent
        font.pixelSize: 64

    }

    Button {
        text: qsTr("Done")
        anchors.top: thankLabel.bottom
        anchors.horizontalCenter: thankLabel.horizontalCenter
        onClicked: Qt.quit()
    }


    Particles {
            id: particles
            width: 1; height: 1
            emissionRate: 100
            lifeSpan: 700; lifeSpanDeviation: 600
            angle: 0; angleDeviation: 360;
            velocity: 100; velocityDeviation: 30
            source: "white.png"
        }

    function explode() {
        particles.x = parent.width * Math.random();
        particles.y = parent.height * Math.random();
        particles.burst(1000);
    }

    Timer {
        interval: 500
        running: true
        repeat: true
        onTriggered: explode();
    }


}

