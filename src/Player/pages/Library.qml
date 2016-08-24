import QtQuick 2.7
import QtQuick.Controls 2.0
import QtQuick.Layouts 1.3
import QtQuick.Controls.Material 2.0

import Qt.labs.folderlistmodel 1.0

Page {
    id: library
    width: parent.width
    height: parent.height

    RowLayout {
        id: rowLayout
        anchors.fill: parent

        /*Rectangle {
            color: appSettings.menuPaneColor
            anchors.fill: parent
            anchors.rightMargin: 20
            Rectangle {
                width: 200
                height: 200
                color: Material.accent
            }
        }*/
        Rectangle {
            color: appSettings.menuPaneColor
            anchors.top: parent.top
            anchors.right: parent.right
            anchors.bottom: parent.bottom
            width: 20

            Column {
                anchors.top: parent.top
                anchors.right: parent.right
                anchors.bottom: parent.bottom
                width: 20

                Repeater {
                    model: 26
                    Label {
                        text: String.fromCharCode(65 + index)
                        horizontalAlignment: Text.AlignHCenter
                        verticalAlignment: Text.AlignVCenter
                        width: parent.width
                        height: parent.height / 26
                        fontSizeMode: Label.VerticalFit
                        background: Rectangle {
                            color: appSettings.menuPaneColor
                            anchors.fill: parent
                        }

                        MouseArea {
                            id: mouseArea
                            anchors.fill: parent
                            hoverEnabled: true
                            onEntered: {
                                parent.background.color = Material.accent
                            }
                            onExited: {
                                parent.background.color = appSettings.menuPaneColor
                            }
                        }
                    }
                }
            }
        }
    }
}
