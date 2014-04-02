Make Bootable USB Drive on OS X
===============================

OS X can't burn an ISO directly, but
you can convert an ISO to a DMG then burn
the DMG (to a USB drive, ideally).

This repo has two scripts:
  - `mkdmg.sh` - give it an ISO and it gives you a DMG
  - `burn.sh` - give it a disk and a DMG (or anything really) and it'll properly `dd` it to the disk.


Any damage you do to your systems using these is on your own head.
