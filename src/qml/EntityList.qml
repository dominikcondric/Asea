import QtQuick
import QtQuick.Controls
import "./MyTypes" as MyTypes
import SceneEditor

ListView {
    id: listView
    spacing: 0.8
    ScrollBar.vertical: ScrollBar { policy: ScrollBar.AsNeeded }
    ScrollBar.horizontal: ScrollBar { policy: ScrollBar.AsNeeded }

    function getSelectedEntity() {
        if (currentIndex === -1)
            return undefined
        else 
            return model.getEntity(currentIndex)
    }
    

    MouseArea {
        anchors.fill: parent
        acceptedButtons: Qt.RightButton
        propagateComposedEvents: true
        onClicked: (mouse) => {
            if (listView.currentIndex != -1)
                listView.currentItem.color = listView.currentItem.originalColor
            listView.currentIndex = -1
            removeEntityButton.visible = false
            addChildEntityButton.visible = false
            mouse.accepted = false
        }
    }

    header: Rectangle {
        anchors.left: parent.left
        anchors.right: parent.right
        height: 35
        radius: 3
        color: "#151515"

        Rectangle {
            anchors.left: parent.left
            anchors.right: parent.right
            anchors.bottom: parent.bottom
            height: 3
            radius: 2
            color: "#050505"
        }

        Text {
            anchors.fill: parent
            color: "#cccccc"
            font.pixelSize: 14
            font.weight: 800
            text: "Entity list"
            horizontalAlignment: Text.AlignHCenter
            verticalAlignment: Text.AlignVCenter
        }
    }

    delegate: Rectangle {
        width: parent.width
        anchors.left: parent.left
        anchors.leftMargin: 3 + 20 * entity.getDepth()
        height: 25
        color: "#202020"
        clip: true
        property string originalColor: "#202020"
        property string highlightColor: "#404040"
        radius: 3

        Text {
            id: entityTag
            anchors.fill: parent
            color: "#cccccc"
            font.pixelSize: 13
            font.weight: 300
            text: name
            verticalAlignment: Text.AlignVCenter
            leftPadding: 5
            property string originalColor: "#cccccc"
        }

        MouseArea {
            anchors.fill: parent
            hoverEnabled: true
            acceptedButtons: Qt.LeftButton
            onClicked: (mouse) => {
                if (listView.currentIndex != -1)
                    listView.currentItem.color = listView.currentItem.originalColor
                listView.currentIndex = index
                highlightItem()
            }
            onEntered: entityTag.color = "white"
            onExited: entityTag.color = entityTag.originalColor
        }
    }

    function highlightItem() {
        listView.currentItem.color = listView.currentItem.highlightColor
        removeEntityButton.visible = true
        addChildEntityButton.visible = true
    }

    MyTypes.RoundButton {
        anchors.bottom: parent.bottom
        anchors.right: parent.right
        anchors.margins: 10
        width: 30
        height: 30
        text: "+"
        fillColor: "#019e0b"
        onClicked: {
            if (listView.currentIndex != -1) {
                listView.currentItem.color = listView.currentItem.originalColor
            }

            listView.model.addEntity(-1)
            listView.currentIndex = 0
            highlightItem()
        }
    }

    MyTypes.RoundButton {
        id: addChildEntityButton
        anchors.bottom: parent.bottom
        anchors.right: parent.right
        anchors.margins: 10
        anchors.rightMargin: 10
        anchors.bottomMargin: 90
        width: 30
        height: 30
        visible: false
        text: "->"
        fillColor: "#019e0b"
        onClicked: {
            if (listView.currentIndex != -1) {
                listView.currentItem.color = listView.currentItem.originalColor
            }
            
            listView.model.addEntity(listView.currentIndex)
            listView.currentIndex += 1
            highlightItem()
        }
    }

    MyTypes.RoundButton {
        id: removeEntityButton
        anchors.bottom: parent.bottom
        anchors.right: parent.right
        anchors.rightMargin: 10
        anchors.bottomMargin: 50
        width: 30
        height: 30
        text: "-"
        visible: false
        fillColor: "red"
        onClicked: {
            listView.model.removeEntity(listView.currentIndex)
            listView.currentIndex = -1
            visible = false
            addChildEntityButton.visible = false;
        }
    }

    model: EntityListModel {
        id: entityModel
     }
}