{ pkgs }:

with pkgs.lib;
{
  lib.maintainers = with maintainers; [ kagura ];
}
