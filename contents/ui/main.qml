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

    Plasmoid.status: PlasmaCore.Types.HiddenStatus
    Plasmoid.backgroundHints: PlasmaCore.Types.NoBackground

    // PDA UI background image
    Image {
        id: pdaBackground
        source: "Ui_pda.png"
        anchors.fill: parent
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


