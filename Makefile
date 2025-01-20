# Location of the udev rules files
UDEV = /etc/udev/rules.d

# User's bin directory for launcher script
BINDIR = ${HOME}/bin

# Location of the extracted scrcpy release files
PROGDIR = ${HOME}/Programs/scrcpy

# User's systemd unit files
SYSTEMD = ${HOME}/.config/systemd/user

# User's desktop application description files
APPDIR = ${HOME}/.local/share/applications

# Export a couple variables referenced by the cusomized files
export BINDIR
export PROGDIR

# USB Vendor ID, Product ID, and serial number
# Used in the udev device rules file
# Customize for your device
export USBVID ?= 04e8
export USBPID ?= 6860
export USBSERIAL ?= R5CT207BLVT

# Dynamic systemd unit name created when the phone is connected
# Used in the user unit file
# Customize for your device
export SYSTEMD_DEV ?= dev-serial-by\x2did-usb\x2dSAMSUNG_SAMSUNG_Android_R5CT207BLVT\x2dif01.device

# Targets for make
bin     = auto-scrcpy
rules   = 99-auto-scrcpy-usb.rules
service = auto-scrcpy.service
desktop = scrcpy.desktop

# Default make target
all: ${rules} ${service} ${bin} ${desktop}

# Install everything needed
install: install-rules install-service install-bin install-desktop 
	@echo "Ok"

# Clean up by removing the customized files
clean:
	rm -f ${rules}
	rm -f ${service}
	rm -f ${bin}
	rm -f ${desktop}

# Create custom udev rules from template
${rules}: ${rules}.in
	envsubst <$< >$@

# Install rules file and poke udev
install-rules: ${rules}
	sudo install -Cv -m 444 -t ${UDEV} $?
	sudo udevadm control --reload

# Create systemd unit file from template
${service}: ${service}.in
	envsubst <$< >$@

# Install user's unit file
install-service: ${service}
	install -Cv -m 444 -t ${SYSTEMD} $?
	systemctl --user daemon-reload
	systemctl enable --user ${service}

${bin}: ${bin}.in
	envsubst <$< >$@

# Install the launcher script
install-bin: ${bin}
	install -Cv -t ${BINDIR} $?

# Create desktop application file from template
${desktop}: ${desktop}.in
	envsubst <$< >$@

# Install desktop application
install-desktop: ${desktop}
	xdg-desktop-menu install --novendor ./scrcpy.desktop

