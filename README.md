# Docker edavki

Runs firefox in container with dependencies for opening EDavki.

There are 2 versions of the image, one with VNC and other without VNC.

The *novnc* version uses X Window for displaying browser.

The *vnc* version has X window in the image and it requires vnc viewer for
displaying a browser.

## Instructions

```bash
make setup
```

copy certificate to **data** folder so it will be available for import
in browser.

## Running

### No VNC

`make run/novnc`

### With VNC

`make run/vnc`

then connect to `vnc://127.0.0.1:5900`.

### First run

After successful run you should see a browser and than start with the certificate import.

## Troubleshooting

### Testing if it works

Test sign page https://edavki.durs.si/EdavkiPortal/OpenPortal/Pages/Introduction/TestSign.aspx

### Using NOVNC and see error: No protocol specified

Run `xhost local:root`

