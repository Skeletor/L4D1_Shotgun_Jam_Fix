# [L4D1] Shotgun Jam Fix<br><br>
When you try to revive a teammate during the shotgun reload action it becomes unable to reload or shoot for a couple seconds. This happens due to poor NextAttack algorithm check for shotguns after the revive attempt.<br><br>
This fix is made for L4D1 only, L4D2 doesn't have that issue.<br><br>

-= Installation =-
1. Install sourcemod and metamod (preferably the latest versions) here:<br>
   https://www.sourcemod.net/downloads.php<br>
   https://www.sourcemm.net/downloads.php?branch=stable<br><br>
2. Place 'l4d1_shotgun_jam_fix.smx' into 'addons/sourcemod/plugins' folder.<br>
