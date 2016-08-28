import QtQuick 2.7
import QtQuick.Controls 1.4
import QtQuick.Controls.Styles 1.4
import QtQuick.Controls 2.0
import QtQuick.Layouts 1.3
import QtQuick.Controls.Material 2.0

import org.miamplayer.qml 1.0

Page {
    id: library
    width: parent.width
    height: parent.height

    LibraryItemModel {
        id: libraryItemModel
        Component.onCompleted: {
            load()
        }
    }

    Component {
        id: rowDelegate
        Rectangle {
            Label {
                text: artistTxt
            }
        }
    }

    RowLayout {
        id: rowLayout
        anchors.fill: parent

        TreeView {
            //selectionMode: SelectionMode.ExtendedSelection
            alternatingRowColors: false
            TableViewColumn {
                id: column
                title: qsTr("Artists")
                role: "text"
                delegate: Rectangle {
                    implicitHeight: height
                    implicitWidth: width
                    color: Material.background
                    Image {
                        id: disc
                        sourceSize.height: 20
                        sourceSize.width: 20
                        source: "qrc:/images/disc.png"
                        visible: libraryItemModel.data("cover")
                    }
                    Label {
                        anchors.left: disc.visible ? disc.right : undefined
                        text: styleData.value
                        color: Material.foreground
                    }
                }
            }
            model: libraryItemModel
            anchors.top: parent.top
            anchors.bottom: parent.bottom
            anchors.left: parent.left
            anchors.rightMargin: jumpLetters.width
            anchors.right: parent.right
            horizontalScrollBarPolicy: Qt.ScrollBarAlwaysOff
            style: TreeViewStyle {
                backgroundColor: appSettings.menuPaneColor
                frame: Rectangle {
                    border.width: 0

                }
            }
        }

        Rectangle {
            id: jumpLetters
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
