import QtQuick 2.0

ListModel {
    ListElement{
        name:"Rainbow"
        icon:"pictures/game_icon_rainbow.svg"
        game_tag:"<N>"
    }
    ListElement{
        name:"Light to Left"
        icon:"pictures/game_icon_leftWalk.svg"
        game_tag:"<L>"
    }
    ListElement{
        name:"Light to Right"
        icon:"pictures/game_icon_rightWalk.svg"
        game_tag:"<R>"
    }
    ListElement{
        name:"HeartBeat"
        icon:"pictures/game_icon_breathing.svg"
        game_tag:"<B>"
    }
    ListElement{
        name:"Strong Toggle"
        icon:"pictures/game_icon_strongToggle.svg"
        game_tag:"<O>"
    }
    ListElement{
        name:"Look !"
        icon:"pictures/game_icon_LookHere.svg"
        game_tag:"<H>"
    }

    //Repeat"ListElements" for future application pages

}
