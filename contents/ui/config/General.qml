import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import org.kde.kirigami as Kirigami
import org.kde.kcmutils as KCM
import QtQuick.Dialogs as QtDialogs

Kirigami.FormLayout {
    id: page

    property alias cfg_htmlUrl: htmlUrl.text

    TextField {
        id: htmlUrl
        
        Layout.preferredWidth: 25 * Kirigami.Units.gridUnit
        placeholderText: i18n("Enter URL...")
        Kirigami.FormData.label: i18n("URL")
    }
}
