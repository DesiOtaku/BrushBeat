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

PageStackWindow {
    id: appWindow

    initialPage: mainPage

    MainPage { //Intro page
        id: mainPage
        onPlayRandom: appWindow.pageStack.push(playRandom)
        onPlayFavs: appWindow.pageStack.push(playFavs)
    }

    PlayRandomPage { //play songs randomly page
        id: playRandom
        onUserCanceled: appWindow.pageStack.pop();
        onDonePlaying: appWindow.pageStack.push(thankYou);
    }

    PlayFavsPage { //play the favorite songs
        id: playFavs
        onUserCanceled: appWindow.pageStack.pop();
        onDonePlaying: appWindow.pageStack.push(thankYou);
    }

    ThankYouPage { //thank the user for using our app
        id: thankYou
    }

    Component.onCompleted: { //Because its a multimedia app, we want to
        theme.inverted = true;
    }
}
