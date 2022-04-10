import QtQuick 2.15
import QtQuick.Window 2.15
import QtQuick.Controls 2.12

Window {
    width: 640
    height: 480
    visible: true
    title: qsTr("Player")
    Rectangle {
        id: screen
        width: 520
        height: 350
        color: "transparent"
        anchors.horizontalCenter: parent.horizontalCenter
    }
    Button
    {
        id: play
        text: "Play"
        anchors.top: screen.bottom
        anchors.left: screen.left
        anchors.topMargin: 5
        onClicked:
        {
            rewind.isClicked = false;
            screen.color = "green";
            timer.interval = 1000;
            timer.start();
        }
    }
    Button
    {
        id: pause
        text: "Pause"
        anchors.top: screen.bottom
        anchors.left: play.right
        anchors.leftMargin: 5
        anchors.topMargin: 5
        onClicked:
        {
            screen.color = "yellow";
            timer.stop();

        }
    }
    Button
    {
        id: stop
        text: "Stop"
        anchors.top: screen.bottom
        anchors.left: pause.right
        anchors.leftMargin: 5
        anchors.topMargin: 5
        onClicked:
        {
            screen.color = "red";
            timer.stop();
            timer.seconds = progress.from;
            progress.value = timer.seconds;
        }
    }
    Button
    {
        id: rewind
        text: "Rewind"
        anchors.top: screen.bottom
        anchors.left: stop.right
        anchors.leftMargin: 5
        anchors.topMargin: 5
        property bool isClicked: false
        onClicked:
        {
            isClicked = true;
            screen.color = "lightblue";
            timer.interval = 500;
            timer.start();
        }
    }
    Button
    {
        id: forward
        text: "Forward"
        anchors.top: screen.bottom
        anchors.left: rewind.right
        anchors.leftMargin: 5
        anchors.topMargin: 5        
        onClicked:
        {
            rewind.isClicked = false;
            screen.color = "blue";
            timer.interval = 500;
            timer.start();
        }
    }
    ProgressBar
    {
        id: progress
        anchors.top: play.bottom
        anchors.horizontalCenter: screen.horizontalCenter
        anchors.topMargin: 10
        width: 520
        from: 0
        to: 100
        value: from

    }
    property int seconds: progress.from
    Timer {
        id: timer
        interval: 1000
        repeat: true;
        triggeredOnStart: true
        onTriggered: {
            if (rewind.isClicked) {
                seconds--
            }
            else seconds++;
            progress.value = seconds;
            if (seconds > progress.to) {
               timer.stop();
            }
        }
    }

}
