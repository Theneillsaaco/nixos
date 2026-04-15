{ lib }: {

  importDir = dir:
    let 
      entries = builtins.readDir dir;
      
      nixFiles = lib.filterAttrs
        (n: t: t == "regular" && lib.hasSuffix ".nix" n) entries;
    in
      map (n: dir + "/${n}") (builtins.attrNames nixFiles);
}