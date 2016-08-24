import QtQuick 2.7
import QtQuick.Layouts 1.3
import QtQuick.Controls 2.0
import QtQuick.Controls.Material 2.0
import QtQuick.Window 2.2
import Qt.labs.settings 1.0

import org.miamplayer.qml 1.0

ApplicationWindow {
    id: window
    visible: true
    minimumWidth: 370
    minimumHeight: 500
    width: 800
    height: 600
    visibility: Window.Windowed

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
    }

    Material.background: appSettings.background
    Material.theme: appSettings.theme
    Material.primary: appSettings.primary
    Material.accent: appSettings.accent

    color: appSettings.background

    Popup {
        id: noMusicPopup
        x: window.width - 300
        y: 50
        closePolicy: Popup.CloseOnEscape | Popup.CloseOnPressOutsideParent
        focus: true
        width: 250
        height: 100
        property string folderToRemove

        background: Rectangle {
            implicitWidth: parent.width
            implicitHeight: parent.height
            color: appSettings.menuPaneColor
            border.color: Material.accent

            ColumnLayout {
                anchors.fill: parent
                Rectangle {
                    width: 20
                    height: 20
                    opacity: 0.3
                    anchors.rightMargin: 2
                    anchors.right: parent.right
                    anchors.topMargin: 2
                    anchors.top: parent.top
                    border.color: Material.foreground
                    color: appSettings.menuPaneColor
                    border.width: 1

                    Label {
                        text: "+"
                        rotation: -45
                        anchors.fill: parent
                        verticalAlignment: Text.AlignVCenter
                        horizontalAlignment: Text.AlignHCenter
                    }

                    MouseArea {
                        anchors.fill: parent
                        hoverEnabled: true
                        onEntered: {
                            parent.opacity = 1.0
                            parent.border.color = Material.accent
                        }
                        onExited: {
                            parent.opacity = 0.3
                            parent.border.color = Material.foreground
                        }
                        onClicked: {
                            noMusicPopup.close()
                        }
                    }
                }
                Label {
                    Layout.fillWidth: true
                    text: qsTr("No music was found in your Library")
                    verticalAlignment: Text.AlignVCenter
                    horizontalAlignment: Text.AlignHCenter
                }
                Button {
                    id: acceptRemove
                    anchors.alignWhenCentered: true
                    anchors.horizontalCenter: parent.horizontalCenter
                    text: qsTr("Open Settings")
                    onClicked: {
                        noMusicPopup.close()
                        menuPane.loadPage("settings")
                    }
                }
            }
        }
    }

    MusicLocationsModel {
        id: musicLocations
        Component.onCompleted: {
            if (isEmpty()) {
                console.log("display popup")
                noMusicPopup.open()
            }
        }
    }

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


            function loadPage(title) {
                var pages = [
                            {id: "settings", tr: qsTr("Settings"), url: "qrc:/pages/settings.qml"},
                            {id: "allMusic", tr: qsTr("All music"), url: "qrc:/pages/all-music.qml"},
                            {id: "playlists", tr: qsTr("Playlists"), url: "qrc:/pages/playlists.qml"}
                        ]
                for (var i = 0; i < pages.length ; i++) {
                    if (pages[i].id === title) {
                        titleLabel.text = pages[i].tr
                        stackView.replace(pages[i].url)
                    }
                }
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
                            onClicked: menuPane.loadPage("playlists")
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
                            onClicked: menuPane.loadPage("playlists")
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
                            onClicked: menuPane.loadPage("allMusic")
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
                            onClicked: menuPane.loadPage("allMusic")
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
                            onClicked: menuPane.loadPage("settings")
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
                            onClicked: menuPane.loadPage("settings")
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
            replaceExit: Transition {}
        }
    }

    Component.onCompleted: {
        menuPane.loadPage("playlists")
    }
}
