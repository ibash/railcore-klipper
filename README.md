
## Flashing Klipper
1. **Remove the internal power jumper on the duet** -- if not you risk burning out the
   board.
2. Connect a jumper across "erase" on the duet
3. Plug a usb from the duet to the raspberry pi
4. Power up
5. ssh into the pi
6. Confirm duet is detected

   ```
   pi@raspberrypi:~ $ ls /dev/serial/by-id
   usb-03eb_6124-if00
   ```

7. Remove erase jumper
8. Flash with bossa

   ```
   ~/BOSSA/bin/bossac --port=/dev/serial/by-id/usb-03eb_6124-if00 -b -U -e -w -v ~/klipper.bin
   ```

9. Power down and back up

## Flashing Duet

1. **Remove the internal power jumper on the duet** -- if not you risk burning out the
   board.
2. Connect a jumper across "erase" on the duet
3. Plug a usb from the duet to the raspberry pi
4. Power up
5. ssh into the pi
6. Confirm duet is detected

   ```
   pi@raspberrypi:~ $ ls /dev/serial/by-id
   usb-03eb_6124-if00
   ```

7. Remove erase jumper
8. Flash with bossa

   ```
   ~/BOSSA/bin/bossac -e -w -v -b /opt/dsf/sd/firmware/Duet3Firmware_MB6HC.bin
   ```

9. Power down and back up
10. Confirm the pi detects the duet in duet web control
11. Power down
12. Remove the usb cable
13. Put the internal power jumper back on
14. Power up
