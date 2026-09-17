{ lib }: {
  
  # Non-recursive by design: builtins.readDir only lists the immediate
  # entries of `dir`, and `t == "regular"` filters out subdirectories
  # entirely. So modules/deprecated/ and home/isaac/programs/old/ are never
  # picked up unless importDir is called directly on those paths — which it
  # isn't anywhere in this repo. Confirmed safe; no exclusion logic needed.
  importDir = dir:
    let 
      entries = builtins.readDir dir;
      
      nixFiles = lib.filterAttrs
        (n: t: t == "regular" && lib.hasSuffix ".nix" n) entries;
    in
      map (n: dir + "/${n}") (builtins.attrNames nixFiles);
}