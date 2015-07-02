Name: harbour-plonk
Version: 3.0.0
Release: 1
License: GPLv3 or later
Summary: A multi-touch pong-like game for two players
Url: http://thp.io/2011/plonk/
Group: Games/Sports
Source: %{name}-%{version}.tar.gz
BuildRequires: pkgconfig(Qt5Quick)
Requires: qt5-qtdeclarative-import-particles2

%description
Plonk is an open-source game featuring high-resolution artwork and attention to
detail. It's a Pong-like game to play against another human. Two players are
needed to play this game. Try to hit the ball several times within the center
of the paddle and see what happens.

%prep
%setup -q

%build
%qmake5
make

%install
make INSTALL_ROOT=%{buildroot} install

%files
%defattr(-,root,root,-)
%{_bindir}/%{name}
%{_datadir}/applications/%{name}.desktop
%{_datadir}/%{name}/%{name}.png
