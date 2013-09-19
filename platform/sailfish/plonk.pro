include(plonk.pri)

target.path = $$PREFIX/bin

desktop.path = $$PREFIX/share/applications
desktop.files = plonk.desktop

icon.path = $$PREFIX/share/plonk
icon.files = plonk.png

INSTALLS += target icon desktop
