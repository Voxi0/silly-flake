{ config, lib, ... }: 
{
    programs.git = {
        enable = true;
        userName = "lucyamonster";
        userEmail = "145208219+lucyamonster@users.noreply.github.com";
    };
}