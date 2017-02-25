#!/bin/bash

echo "root:$ROOT_PASS" | chpasswd
for i in ssh dropbear nginx; do
  service $i start;
 done
