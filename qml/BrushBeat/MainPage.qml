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

Page {
    id: mainPage
    signal playRandom
    signal playFavs

    orientationLock: PageOrientation.LockPortrait //because I am too lazy to redo the UI in landscape

    tools: ToolBarLayout {
        ToolIcon { iconId: "toolbar-close"; onClicked: Qt.quit(); } //Because hitting a butter is lazier than swiping
        ToolButton {  text:qsTr("How to use"); onClicked: howUseDialog.open() } //instructions
        ToolButton {  text:qsTr("About"); onClicked: aboutDialog.open() } //About the app
    }

    Column { //Main title
        spacing: 20
        anchors.centerIn: parent
        Label {
            width: parent.width
            anchors.horizontalCenter: parent.horizontalCenter
            text: qsTr("Welcome to BrushBeat")
            platformStyle: LabelStyle {
                fontPixelSize: 64
            }
        }

        Button {
            text: qsTr("Play random songs")
            height: 128
            iconSource: "image://theme/icon-m-toolbar-shuffle-white"
            onClicked: mainPage.playRandom();
        }

        Button {
            text: qsTr("Play favorite songs")
            height: 128
            iconSource: "image://theme/icon-m-toolbar-frequent-used-white"
            onClicked: mainPage.playFavs();
        }

    }

    Dialog {
        id: aboutDialog
        visualParent: mainPage
        title:  Label {
            text:qsTr("About\nBrushBeat")
            platformStyle: LabelStyle {
                fontPixelSize: 64
            }
        }
        content: Label {
            text: qsTr("Written by: Tej A. Shah <a href=\"http://tshah.wordpress.com/\">http://tshah.wordpress.com/</a><br>Logo by: Ben Costa <br>(C) 2012\n" +
                       "This program comes with\nABSOLUTELY NO WARRANTY\n" +
                       "This is free software,and you are welcome to redistribute it under certain conditions.");
            onLinkActivated: Qt.openUrlExternally(link);
            width: parent.width + 20
        }

        buttons:Column {
            spacing: 15
            Button{
                text:qsTr("Donate");
                onClicked: Qt.openUrlExternally("https://secure2.convio.net/bts/site/Donation2?idb=2067054531&df_id=2847&FR_ID=1810&PROXY_ID=2325868&PROXY_TYPE=20&2847.donation=form1");
            }
            Button{
                text:qsTr("Back");
                onClicked: aboutDialog.close();
            }
        }
    }

    Dialog {
        id: howUseDialog
        visualParent: mainPage
        title:  Label {
            text:qsTr("How to Use")
            platformStyle: LabelStyle {
                fontPixelSize: 64
            }
        }

        content: Label {
            text: qsTr("This app is designed for you to brush your teeth for 2 minutes." +
                       "You will listen to songs from your collection to accompany you for those 2 minutes."+
                       "When you listen to a song, brush in a quarter of your mouth. When the song changes, " +
                       "switch to the next quarter of your mouth. When you are finished, the songs will stop" +
                       " playing.");
            width: parent.width
        }


        buttons: Button{
            text:qsTr("Done");
            onClicked: howUseDialog.close();
        }
    }

}
