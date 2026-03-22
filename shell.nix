{ pkgs ? import <nixpkgs> {} }:

pkgs.mkShell {
  buildInputs = [
    pkgs.uv       # provides uvx, needed for cronometer-mcp
    pkgs.pipx     # needed for paprika-mcp
    pkgs.nodejs   # needed for whoop-mcp-server
  ];
}
