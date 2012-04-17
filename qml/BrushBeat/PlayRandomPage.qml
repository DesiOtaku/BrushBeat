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
import QtMobility.gallery 1.1


Page {
    id: playRandom

    signal donePlaying
    signal userCanceled

    property int quadCounter: -1

    function handleGoBack() { //when the user hits the back button
        songInfo.currentSecond =0;
        musicPlayer.stop();
        quadCounter =-1;
        songInfo.opacity =0;
        musicPlayer.source="";
        secondTimer.running = false;
        playRandom.userCanceled();
    }

    function handleSecond() {
        songInfo.currentSecond++;
        if(songInfo.currentSecond >= 30) { //switch to a new song
            musicPlayer.stop();
            quadCounter++;
            musicPlayer.nextSong();
            songInfo.currentSecond =0;
            songInfo.songName = audioModel.get(musicPlayer.playIndex).title;
            if(quadCounter > 3) {
                musicPlayer.stop();
                donePlaying();
            }
        }
    }

    function startMusic() {
        quadCounter++;
        musicPlayer.nextSong();
        songInfo.songName = audioModel.get(musicPlayer.playIndex).title;
        secondTimer.running = true;
    }

    Countdown {
        id: countDown
        onDoneCounting: {
            songInfo.opacity =1;
            playRandom.startMusic();
        }
        anchors.fill: parent
    }

    Audio {
        id:musicPlayer

        property int playIndex;

        function nextSong() {
            playIndex = Math.floor(Math.random() * audioModel.count);
            musicPlayer.source = audioModel.get(playIndex).filePath;
            musicPlayer.play();
        }
    }

    ListView { //This is a stupid hack because the Document Gallery Model
        //will not load the actual songs until the listview loads up the
        //list of songs
        id: listLoader
        width: 1
        height: 1
        model: audioModel
        header: Label {
            text: audioModel.count
            color: "black"
        }

        delegate: Label {
            text: playCount
            color: "black"
        }
    }

    DocumentGalleryModel {
        id: audioModel
        rootType: DocumentGallery.Audio //There is a bug here in that it will play movies
        //along with audio; this is a bug with Qt Mobility
        properties: ["artist", "title", "filePath", "duration", "playCount"]
        sortProperties: ["-playCount"]
    }

    SongInfo {
        id:songInfo
        currentQuad: quadCounter
    }

    Timer {
        id: secondTimer
        interval: 1000 //1 second
        running: false
        repeat: true
        onTriggered: handleSecond();
    }

    tools: ToolBarLayout {
        ToolIcon { iconId: "toolbar-back"; onClicked: handleGoBack(); }
    }

    onVisibleChanged: {
        if(playRandom.visible) { //when the user can now see this page
            countDown.startCountingDown();
        }
    }
}
