#!/bin/bash
# Date : 2024.09.26
# Peter Acosta : peteracosta@gmail.com
# Script para ver el espacio en el disco


du -h --max-depth=1 2>/dev/null | sort -hr | head -n 10
