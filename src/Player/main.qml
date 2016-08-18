import QtQuick 2.7
import QtQuick.Layouts 1.3
import QtQuick.Controls 2.0
import QtQuick.Controls.Material 2.0
import QtQuick.Window 2.2
import Qt.labs.settings 1.0

ApplicationWindow {
    id: window
    visible: true
    minimumWidth: 370
    minimumHeight: 500
    width: 800
    height: 600
    visibility: Window.Windowed
    background: Material.background

    title: qsTr("Miam-Player QML")

    Settings {
        id: appSettings
        property int port: 5600
        property alias currentMenuState: menuPane.state
        property alias burgerMenuIsChecked: burgerMenu.checked

        property alias x: window.x
        property alias y: window.y
        property alias width: window.width
        property alias height: window.height
        property alias visibility: window.visibility

        property string theme: "Dark"
        property string background: Material.background
        property string primary: Material.Purple
        property string accent: Material.Purple
        property string style: "Material"
        property string menuPaneColor: "#171717"

        property variant musicLocations: []
    }

    Material.background: appSettings.background
    Material.theme: appSettings.theme
    Material.primary: appSettings.primary
    Material.accent: appSettings.accent

    header: ToolBar {
        RowLayout {
            anchors.fill: parent

            ToolButton {
                id: burgerMenu
                checkable: appSettings.burgerMenuIsChecked
                contentItem: Image {
                    fillMode: Image.Pad
                    horizontalAlignment: Image.AlignHCenter
                    verticalAlignment: Image.AlignVCenter
                    source: "qrc:/images/" + appSettings.style + "/" + appSettings.theme + "/drawer.png"
                }
                onClicked: {
                    if (menuPane.state == "") {
                        menuPane.state = "mini"
                    } else {
                        menuPane.state = ""
                    }
                }

                background: Image {
                    fillMode: Image.Pad
                    horizontalAlignment: Image.AlignHCenter
                    verticalAlignment: Image.AlignVCenter
                    source: "qrc:/images/" + appSettings.style + "/" + appSettings.theme + "/drawer.png"
                }
            }

            Label {
                id: titleLabel
                font.pixelSize: 20
                elide: Label.ElideRight
                horizontalAlignment: Qt.AlignLeft
                verticalAlignment: Qt.AlignVCenter
                Layout.fillWidth: true
            }
        }
    }

    RowLayout {
        id: rowLayout
        anchors.fill: parent
        Pane {
            id: menuPane

            height: window.height
            Layout.preferredWidth: 368
            Layout.minimumWidth: 368

            anchors.left: parent.left
            anchors.top: parent.top
            anchors.bottom: parent.bottom

            padding: 0

            background: Rectangle {
                color: appSettings.menuPaneColor
            }

            states: [
                State {
                    name: "mini"
                    when: burgerMenu.checked || window.width < 1180
                    PropertyChanges {
                        target: menuPane
                        width: 56
                        Layout.preferredWidth: 56
                        Layout.minimumWidth: 56
                    }
                },
                State {
                    name: ""
                    when: !burgerMenu.checked && window.width >= 1180
                    PropertyChanges {
                        target: menuPane
                        width: 368
                        Layout.preferredWidth: 368
                        Layout.minimumWidth: 368
                    }
                }
            ]

            Behavior on width {
                NumberAnimation { duration: 100 }
            }


            function loadPage(title, pageName) {
                titleLabel.text = title
                stackView.replace(pageName)
            }

            ColumnLayout {

                id: columnLayout
                anchors.topMargin: 20
                anchors.top: parent.top
                Layout.fillWidth: true
                anchors.left: parent.left
                anchors.leftMargin: menuPane.state === "mini" ? (menuPane.width - 20) / 2 : 8
                anchors.right: parent.right
                spacing: 30

                RowLayout {
                    Image {
                        id: iconSearch
                        visible: menuPane.state === "mini"
                        anchors.left: parent.left
                        source: "qrc:/images/" + appSettings.theme + "/search.png"
                        fillMode: Image.PreserveAspectFit
                        sourceSize.height: 20
                        sourceSize.width: 20
                        MouseArea {
                            anchors.fill: parent
                            onClicked: {
                                menuPane.state = ""
                                searchLabel.forceActiveFocus()
                            }
                        }
                    }
                    TextField {
                        id: searchLabel
                        topPadding: 8
                        leftPadding: 8
                        bottomPadding: 8
                        anchors.rightMargin: 8
                        anchors.left: parent.left
                        anchors.right: parent.right
                        Layout.fillWidth: true
                        visible: menuPane.state === ""
                        placeholderText: qsTr("Search")
                        font.pointSize: 12
                        background: Item {
                            id: bgSearch
                            Rectangle {
                                width: parent.width
                                height: parent.height
                                color: appSettings.menuPaneColor
                                border.color: Material.accent
                                border.width: 2

                                Image {
                                    id: name
                                    fillMode: Image.PreserveAspectFit
                                    source: "qrc:/images/" + appSettings.theme + "/search.png"
                                    anchors.rightMargin: 8
                                    anchors.right: parent.right
                                    anchors.top: parent.top
                                    anchors.topMargin: 8
                                    anchors.bottom: parent.bottom
                                    anchors.bottomMargin: 8
                                }
                            }
                        }
                    }

                }

                RowLayout {
                    Image {
                        id: iconPlaylists
                        anchors.left: parent.left
                        source: "images/" + appSettings.theme + "/playlist.png"
                        fillMode: Image.PreserveAspectFit
                        sourceSize.height: 20
                        sourceSize.width: 20
                        MouseArea {
                            anchors.fill: parent
                            onClicked: menuPane.loadPage(menuPlaylistsLabel.text, "qrc:/pages/playlists.qml")
                        }
                    }
                    Label {
                        id: menuPlaylistsLabel
                        text: qsTr("Playlists")
                        anchors.leftMargin: 8
                        anchors.left: iconPlaylists.right
                        anchors.right: parent.right
                        Layout.fillWidth: true
                        height: 30
                        font.pointSize: 12
                        MouseArea {
                            anchors.fill: parent
                            onClicked: menuPane.loadPage(parent.text, "qrc:/pages/playlists.qml")
                        }
                        visible: menuPane.state == ""
                    }
                }


                RowLayout {
                    Image {
                        id: iconAllMusic
                        anchors.left: parent.left
                        source: "qrc:/images/" + appSettings.theme + "/all-music.png"
                        fillMode: Image.PreserveAspectFit
                        sourceSize.height: 20
                        sourceSize.width: 20
                        MouseArea {
                            anchors.fill: parent
                            onClicked: menuPane.loadPage(allMusicLabel.text, "qrc:/pages/all-music.qml")
                        }
                    }
                    Label {
                        id: allMusicLabel
                        text: qsTr("All music")
                        anchors.leftMargin: 8
                        anchors.left: iconAllMusic.right
                        anchors.right: parent.right
                        Layout.fillWidth: true
                        height: 30
                        font.pointSize: 12
                        MouseArea {
                            anchors.fill: parent
                            onClicked: menuPane.loadPage(parent.text, "qrc:/pages/all-music.qml")
                        }
                        visible: menuPane.state == ""
                    }

                }

                RowLayout {
                    Image {
                        id: iconSettings
                        anchors.left: parent.left
                        source: "qrc:/images/" + appSettings.theme + "/settings.png"
                        fillMode: Image.PreserveAspectFit
                        sourceSize.height: 20
                        sourceSize.width: 20
                        MouseArea {
                            anchors.fill: parent
                            onClicked: menuPane.loadPage(settingsLabel.text, "qrc:/pages/settings.qml")
                        }
                    }
                    Label {
                        id: settingsLabel
                        text: qsTr("Settings")
                        anchors.leftMargin: 8
                        anchors.left: iconSettings.right
                        anchors.right: parent.right
                        Layout.fillWidth: true
                        height: 30
                        font.pointSize: 12
                        MouseArea {
                            anchors.fill: parent
                            onClicked: menuPane.loadPage(parent.text, "qrc:/pages/settings.qml")
                        }
                        visible: menuPane.state == ""
                    }
                }
            }
        }

        StackView {
            id: stackView
            anchors.left: menuPane.right
            anchors.top: parent.top
            anchors.bottom: parent.bottom
            anchors.right: parent.right
            replaceEnter: Transition {
                YAnimator {
                    from: (stackView.mirrored ? -1 : 1) * stackView.height
                    to: 0
                    duration: 100
                    easing.type: Easing.OutCirc
                }
            }
            replaceExit: Transition { }
        }
    }

    Component.onCompleted: {
        menuPane.loadPage(qsTr("Playlists"), "qrc:/pages/playlists.qml")
    }
}
