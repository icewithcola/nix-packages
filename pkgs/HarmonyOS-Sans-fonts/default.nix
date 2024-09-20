{ lib
, stdenvNoCC
, fetchurl
, unzip
, ...
} @ args:

stdenvNoCC.mkDerivation rec {
  pname = "HarmonyOS-Sans-fonts${suffix}";
  version = "20240619"; # Date published on huawei's site.

  src = fetchurl {
    url = "https://developer.huawei.com/images/download/next/HarmonyOS-Sans.zip";
    hash = "sha256-yKyV83FWMfN4czbpaJVxwSroGKAFlxOnJjE2Bc4OuNM=";
  };
  
  nativeBuildInputs = [ unzip ];
  unpackPhase = ''
  mkdir -p harmonyos-sans -x __MACOSX
  unzip -d harmonyos-sans/ ${src}
  mv ./harmonyos-sans/HarmonyOS\ Sans\  ./harmonyos-sans/hmsans
  ''; # Source file has __MACOSX dir and space in the folder name

  installPhase = ''
    # There are only ttf fonts, and we install to a single directory

    local out_font=$out/share/fonts/harmonyos-sans
    for folder in $(ls -d harmonyos-sans/hmsans/*/); do
      install -m444 -Dt $out_font "$folder"/*.ttf
    done
  '';

  meta = {
    description = "Harmony OS Sans font";
    homepage = "https://developer.huawei.com/consumer/cn/design/resource/";
    longDescription = ''
    Based on users' reading feedback on multiple terminals in different scenarios, 
    a brand new default font — HarmonyOS Sans — has been designed for HarmonyOS with a variety of considerations, 
    including the dimensions of different devices, usage scenarios, and different users' requirements 
    for font size and weight due to differences in line-of-sight and angle-of-view.
    '';
    license = lib.licenses.unfree;
    platforms = lib.platforms.all;
    maintainers = with lib.maintainers; [ icewithcola ];
  };
}