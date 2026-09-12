/*
 * SPDX-FileCopyrightText: 2012 Reza Fatahilah Shah <rshah0385@kireihana.com>
 *
 * SPDX-License-Identifier: GPL-2.0-or-later
 */

import QtQuick
import QtQuick.Layouts
import QtMultimedia
import QtWebView
import org.kde.plasma.plasmoid
import org.kde.plasma.core as PlasmaCore
import org.kde.kirigami as Kirigami
import org.kde.kquickcontrolsaddons
import QtQuick.Controls

PlasmoidItem {
    id: widget

    // Show icon in panel (taskbar), full PDA on desktop.
    // Planar = desktop, Horizontal/Vertical = panel.
    preferredRepresentation: Plasmoid.formFactor === PlasmaCore.Types.Planar ? fullRepresentation : compactRepresentation

    Plasmoid.status: PlasmaCore.Types.ActiveStatus
    Plasmoid.backgroundHints: PlasmaCore.Types.NoBackground

    toolTipMainText: "Stalker PDA"
    toolTipSubText: plasmoid.configuration.htmlUrl || ""
    activationTogglesExpanded: true
    hideOnWindowDeactivate: true

    // Small PDA icon shown in the taskbar. Click toggles the popup.
    compactRepresentation: MouseArea {
        id: compactRoot

        Layout.minimumWidth: {
            switch (Plasmoid.formFactor) {
            case PlasmaCore.Types.Vertical:
                return 0;
            case PlasmaCore.Types.Horizontal:
                return height;
            default:
                return Kirigami.Units.gridUnit * 3;
            }
        }
        Layout.minimumHeight: {
            switch (Plasmoid.formFactor) {
            case PlasmaCore.Types.Vertical:
                return width;
            case PlasmaCore.Types.Horizontal:
                return 0;
            default:
                return Kirigami.Units.gridUnit * 3;
            }
        }
        Layout.preferredWidth: Layout.minimumWidth
        Layout.preferredHeight: Layout.minimumHeight

        hoverEnabled: true
        onClicked: widget.expanded = !widget.expanded

        Image {
            anchors.fill: parent
            anchors.margins: 2
            source: "Ui_pda.png"
            fillMode: Image.PreserveAspectFit
            smooth: true
        }
    }

    // Full PDA with embedded browser: desktop widget and panel popup.
    fullRepresentation: Item {
        id: fullRoot
        Layout.preferredWidth: 960
        Layout.preferredHeight: 700
        Layout.minimumWidth: 480
        Layout.minimumHeight: 360

        // PDA UI background image
        Image {
            id: pdaBackground
            anchors.fill: parent
            source: "Ui_pda.png"
            fillMode: Image.PreserveAspectFit

            // WebView positioned at (98, 78) with size 760x525 relative to original image
            WebView {
                id: webBrowser

                // Calculate position and size based on the actual painted area of the image
                property real scaleX: pdaBackground.paintedWidth / pdaBackground.sourceSize.width
                property real scaleY: pdaBackground.paintedHeight / pdaBackground.sourceSize.height
                property real offsetX: (pdaBackground.width - pdaBackground.paintedWidth) / 2
                property real offsetY: (pdaBackground.height - pdaBackground.paintedHeight) / 2

                // Position WebView within the painted area of the image
                x: offsetX + (98 * scaleX)
                y: offsetY + (78 * scaleY)
                width: Math.min(760 * scaleX, pdaBackground.paintedWidth - (98 * scaleX))
                height: Math.min(525 * scaleY, pdaBackground.paintedHeight - (78 * scaleY))

                url: plasmoid.configuration.htmlUrl || "about:blank"
                visible: true

                // Ensure WebView stays within bounds
                clip: true
            }
        }

        // Separate MouseArea that doesn't interfere with WebView
        MouseArea {
            anchors.fill: parent
            acceptedButtons: Qt.LeftButton | Qt.RightButton | Qt.MiddleButton

            onClicked: function(mouse) {
                // Calculate WebView bounds including offsets
                var webViewLeft = pdaBackground.x + webBrowser.x
                var webViewTop = pdaBackground.y + webBrowser.y
                var webViewRight = webViewLeft + webBrowser.width
                var webViewBottom = webViewTop + webBrowser.height

                if (mouse.x < webViewLeft || mouse.x > webViewRight ||
                    mouse.y < webViewTop || mouse.y > webViewBottom) {
                    mouse.accepted = true
                } else {
                    mouse.accepted = false
                }
            }

            z: -1
        }
    }
}


