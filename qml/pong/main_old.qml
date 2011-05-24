import Qt 4.7
import com.meego 1.0

Rectangle {
    anchors.fill: parent
    color: "blue"
    width: 360
    height: 360

    Flickable {
        anchors.fill:  parent
        contentWidth: 1200
        contentHeight: height
        Row {
            id: row
            anchors.fill:  parent
            Rectangle {
                color: "blue"
                width: 200
                height: parent.height
            }
            Rectangle {
                color: "yellow"
                width: 200
                height: parent.height

                TouchArea {
                    id: touchArea
                    anchors.fill: parent
//                    keepMouseFocus: false
                    // when this TouchArea is used, then Flickable will also trigger.

                    touchPoints: [
                        TouchPoint { id: tp1 },
                        TouchPoint { id: tp2 }
                    ]
                }

                Rectangle {
                    x: tp1.x+10
                    y: tp1.y+10
                    height: 40; width: 40
                    color: "#1b8000"
                }

            }
            Rectangle {
                color: "red"
                width: 200
                height: parent.height

                TouchArea {
                    id: touchArea2
                    anchors.fill: parent
                    keepMouseFocus: true
                    // this TouchArea will steal the focus from Flickable.

                    touchPoints: [
                        TouchPoint { id: tp11 },
                        TouchPoint { id: tp12 }
                    ]
                }

                Rectangle {
                    x: tp11.x+10
                    y: tp11.y+10
                    height: 40; width: 40
                    color: "#040080"
                }

                Rectangle {
                    x: tp12.x+10
                    y: tp12.y+10
                    height: 40; width: 40
                    color: "#1b8000"
                }
            }
            Rectangle {
                color: "green"
                width: 200
                height: parent.height
            }
            Rectangle {
                color: "brown"
                width: 200
                height: parent.height
            }
            Rectangle {
                color: "purple"
                width: 200
                height: parent.height
            }
        }
    }
}



//import QtQuick 1.0
//import com.meego 1.0

//Rectangle {
//    property int posX: 0
//    property int posY: 0
//    width: 360
//    height: 360
//    Text {
//        text: "Mouse position: " + posX + " / " + posY;
//        anchors.centerIn: parent
//    }

//    TouchArea {
//        onTouchMove: console.debug("X:" + sceneX)
//        anchors.fill: parent
//    }

////    MouseArea {
////        onMousePositionChanged: {
////            posX = mouseX
////            posY = mouseY
////        }
////        anchors.fill: parent
////    }

//}
