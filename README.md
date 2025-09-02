# STALKER PDA Web Viewer for KDE Plasma 6

A stylish desktop widget for KDE Plasma 6 that displays any website of your choice framed within the iconic PDA device from the S.T.A.L.K.E.R. game series.

![Screenshot of the widget](./screenshot.png)

## Features

*   **Immersive Design:** Faithfully recreated PDA frame from S.T.A.L.K.E.R. for maximum zone authenticity on your desktop.
*   **Fully Configurable:** Easily set any URL you want to monitor directly from the widget's settings.
*   **Native KDE Integration:** Built as a first-class citizen for KDE Plasma 6, ensuring smooth performance and integration.
*   **Lightweight:** A simple web view widget that doesn't consume unnecessary resources.

## Installation

Of course! Here is the corrected and translated installation instruction for your GitHub page.

### Installation & Update

1.  **Clone the repository:**
    ```bash
    git clone https://github.com/MaksPV/stalkerpda-plasma.git
    cd stalkerpda-plasma
    ```

2.  **Build the package:**
    ```bash
    # Make the build script executable and run it
    chmod +x build.sh
    ./build.sh
    ```
    *This will create the `ru.makspv.stalkerpda.tar.xz` archive in the `build/` directory.*

3.  **Install the widget:**
    ```bash
    # Install for the current user (recommended)
    plasmapkg2 --type=kwidget -i build/ru.makspv.stalkerpda.tar.xz

    # Or install for all system users (requires root)
    # sudo plasmapkg2 --type=kwidget -g -i build/ru.makspv.stalkerpda.tar.xz
    ```

4.  **Add the Widget:**
    *   Right-click on your desktop or panel -> `Add Widget...`
    *   Find "**STALKER PDA**" in the list and drag it onto your desktop.
    *   Right-click on the widget -> `Configure STALKER PDA...` to set your desired URL.

### To update to a newer version:

1.  Pull the latest changes from the repository:
    ```bash
    git pull origin main
    ```
2.  Rebuild and reinstall the package (this will overwrite the old version):
    ```bash
    ./build.sh
    plasmapkg2 --type=kwidget -u build/ru.makspv.stalkerpda.tar.xz
    ```

## Configuration

After adding the widget, right-click on it and select `Configure STALKER PDA Browser...`.

*   **URL:** Enter the full web address (including `https://`) of the site you want to display (e.g., `https://www.google.com`).


## Contributing

Found a bug? Have an idea for a new feature? Feel free to:
1.  Open an [Issue](https://github.com/MaksPV/stalkerpda-plasma/issues).
2.  Submit a Pull Request. All contributions are welcome!

## License

This project is licensed under the [GPLv2](https://www.gnu.org/licenses/old-licenses/gpl-2.0.html) (or later) license to align with the KDE Plasma framework.

## Disclaimer

This is a fan-made project. S.T.A.L.K.E.R. is a trademark of GSC Game World. This project is not officially affiliated with or endorsed by GSC Game World.

---

**Get a piece of the Zone on your desktop!**
