#!/bin/bash
modprobe msr
wrmsr 0x1FC 19644
