# SPDX-License-Identifier: GPL-2.0-only

KVER ?= $(shell uname -r)

obj-$(CONFIG_MT7601U)	+= mt7601u.o

mt7601u-objs	= \
	usb.o init.o main.o mcu.o trace.o dma.o core.o eeprom.o phy.o \
	mac.o util.o debugfs.o tx.o

MODDESTDIR := /lib/modules/$(KVER)/kernel/drivers/net/wireless/

MODULE_NAME := mt7601u

CFLAGS_trace.o := -I$(src)

all:
	make -C /lib/modules/$(KVER)/build M=$(PWD) modules
 
clean:
	make -C /lib/modules/$(KVER)/build M=$(PWD) clean

install:
	mkdir -p -m 644 $(MODDESTDIR)mediatek/mt7601u
	install -p -m 644 $(MODULE_NAME).ko  $(MODDESTDIR)mediatek/mt7601u/
	/sbin/depmod -a ${KVER}
