# Building i3 on RHEL 8.7

## Install required libs

```bash
sudo dnf install -y meson xcb-devel startup-notification-devel \
                    xcb-cursor xcb-cursor-devel xcb-util-keysyms-devel \
                    xcb-util-wm-devel xorg-x11-util-macros \
                    libxkbcommon-devel libxkbcommon-x11-devel \
                    yajl-devel cairo-devel libev-devel perl-devel \
                    libconfuse libconfuse-devel
                    

sudo dnf install -y 'pkgconfig(pangocairo)'
sudo dnf install -y 'pkgconfig(libpulse)'
sudo dnf install -y 'pgkconfig(libnl-genl-3.0)'
sudo dnf install -y 'pkgconfig(alsa)'
```

## Manually build and install xcb-util-xrm

```bash
git clone https://github.com/Airblader/xcb-util-xrm
cd xcb-util-xrm
git submodule update --init
./autogen.sh --prefix=/usr
make
sudo make install
cd ..
rm -rf xcb-util-xrm
```

## Clone, build, and install the i3
```bash
git clone https://github.com/i3/i3.git
git checkout 4.22 # (or whatever release tag)
cd i3
mkdir build
cd build
meson ..
ninja

# Install
sudo ninja install
```


## Clone and build the i3statusbar repo
i3statusbar is the default status bar for i3. It's not marked
as optional here but it really is if i3blocks is used instead.

```bash
git clone https://github.com/i3/i3status
cd i3status/build
meson ..
ninja
sudo ninja install
```

## Optional - Clone and build the i3blocks
i3blocks is an optional replacement for i3statusbar
```bash
git clone https://github.com/vivien/i3blocks
cd i3blocks
./autogen.sh
./configure
make
sudo make install
```

## Optional - Clone and build rofi (app launcher/switcher)
```
# Install dependencies
sudo dnf install -y check-devel

git clone --recursive https://github.com/DaveDavenport/rofi
cd rofi
#Optional
git checkout <most recent branch, e.g. 1.7.5>
git submodule update --init
autoreconf -i
mkdir build && cd build
../configure
make
sudo make install
```

## Install the desktop file for GDM

1. This file allows i3 to show up in GDM as an environment option.
2. Create the following file `/usr/share/xsessions/i3.desktop`
3. Add the text below to the i3.desktop file
```
[Desktop Entry]
Name=Standard (X11 display server)
Comment=This session logs you into i3wm
Exec=i3
TryExec=i3
Type=Application
DesktopNames=i3
```

## Once the above steps are completed
1. Log out of GNOME desktop.
2. On the GDM login screen, click the gear icon
3. i3 should now show up. Choose it, log back in,
and i3 should start.
