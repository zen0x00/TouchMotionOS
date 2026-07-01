Copy the complete Linux Unity build into this directory.

Expected layout:
  /opt/touchmotion-game/YourGame.x86_64
  /opt/touchmotion-game/YourGame_Data/

Autodetection rules:
  - If exactly one *.x86_64 file exists here, it will be launched.
  - Otherwise set TOUCHMOTION_GAME_CMD in /etc/default/touchmotion-kiosk.

If the executable bit is missing on the Unity binary, the launcher will try to fix it.
