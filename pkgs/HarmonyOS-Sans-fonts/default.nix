{ lib
, stdenvNoCC
, fetchurl
, unzip
, ...
} @ args:

stdenvNoCC.mkDerivation rec {
  pname = "HarmonyOS-Sans-fonts";
  version = "20240619"; # Date published on huawei's site.

  src = fetchurl {
    url = "https://developer.huawei.com/images/download/next/HarmonyOS-Sans-v2.zip";
    hash = "sha256-un3fcfxN7jOnFwhpVkrXbUIaLtXFjlqsmlc8OZRe9lQ=";
  };
  
  nativeBuildInputs = [ unzip ];
  unpackPhase = ''
  mkdir -p harmonyos-sans
  unzip -d harmonyos-sans/ ${src}
  mv ./harmonyos-sans/HarmonyOS\ Sans ./harmonyos-sans/hmsans
  rm -rf ./harmonyos-sans/hmsans/*Arabic*
  ''; # Source file has space in the folder name

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
    license = "HarmonyOS Sans Fonts License Agreement";
    platforms = lib.platforms.all;
    maintainers = with lib.maintainers; [ ];
  };
}