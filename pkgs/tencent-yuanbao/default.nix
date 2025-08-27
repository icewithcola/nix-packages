{
  callPackage,
  fetchurl,
  lib,
  stdenvNoCC,
  _7zz,
}:
let
  dlhash = "90a3aed2a9526055a607eaddf1e59a7a";
in
stdenvNoCC.mkDerivation rec {
  version = "2.36.0.624";
  pkgName = "腾讯元宝";
  executableName = "yuanbao";
  pname = "tencent-yuanbao";

  src = fetchurl {
    url = "https://cdn-hybrid-prod.hunyuan.tencent.com/Desktop/official/${dlhash}/yuanbao_${version}_universal.dmg";
    hash = "sha256-UAeuOPzu+90YSLAjUoDM0R4o6uqEvrInnIEG8aXkjVk=";
  };

  nativeBuildInputs = [
    _7zz
  ];

  unpackCmd = ''
    7zz x -snld ${src}
  '';

  sourceRoot = ".";

  installPhase = ''
    runHook preInstall

    mkdir -p $out/Applications
    mkdir -p $out/bin

    cp -r ./${pkgName}/${pkgName}.app $out/Applications
    ln -s "$out/Applications/${pkgName}.app/" "$out/bin/${pkgName}"

    runHook postInstall
  '';

  meta = {
    description = "Tencent Yuanbao";
    homepage = "https://yuanbao.tencent.com/";
    downloadPage = "https://yuanbao.tencent.com/download";
    license = lib.licenses.unfree;
    sourceProvenance = [ lib.sourceTypes.binaryNativeCode ];
    maintainers = with lib.maintainers; [ kagura ];
    mainProgram = "${pkgName}.app";
    platforms = [
      "aarch64-darwin"
      "x86_64-darwin"
    ];
  };
}
