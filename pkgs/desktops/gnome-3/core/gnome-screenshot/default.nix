{ stdenv, intltool, fetchurl, pkgconfig, libcanberra_gtk3
, bash, gtk3, glib, hicolor_icon_theme, makeWrapper
, itstool, gnome3, librsvg, gdk_pixbuf }:

stdenv.mkDerivation rec {
  name = "gnome-screenshot-3.12.0";

  src = fetchurl {
    url = "mirror://gnome/sources/gnome-screenshot/3.12/${name}.tar.xz";
    sha256 = "ae4bf706652ae9b28c7930d22c2c37469a78d7f6656d312960b3c75ee5c36eb1";
  };

  doCheck = true;

  NIX_CFLAGS_COMPILE = "-I${gnome3.glib}/include/gio-unix-2.0";

  propagatedUserEnvPkgs = [ gnome3.gnome_themes_standard ];
  propagatedBuildInputs = [ gdk_pixbuf gnome3.gnome_icon_theme librsvg
                            hicolor_icon_theme gnome3.gnome_icon_theme_symbolic ];

  buildInputs = [ bash pkgconfig gtk3 glib intltool itstool libcanberra_gtk3
                  gnome3.gsettings_desktop_schemas makeWrapper ];

  installFlags = "gsettingsschemadir=\${out}/share/gnome-screenshot/glib-2.0/schemas/";

  postInstall = ''
    wrapProgram "$out/bin/gnome-screenshot" \
      --set GDK_PIXBUF_MODULE_FILE "$GDK_PIXBUF_MODULE_FILE" \
      --prefix XDG_DATA_DIRS : "${gtk3}/share:${gnome3.gnome_themes_standard}/share:${gnome3.gsettings_desktop_schemas}/share:$out/share:$out/share/gnome-screenshot:$XDG_ICON_DIRS"
  '';

  meta = with stdenv.lib; {
    homepage = http://en.wikipedia.org/wiki/GNOME_Screenshot;
    description = "Utility used in the GNOME desktop environment for taking screenshots";
    maintainers = with maintainers; [ lethalman ];
    license = licenses.gpl2;
    platforms = platforms.linux;
  };
}
