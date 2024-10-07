#!/bin/bash

amixer get Master | awk -F' ' '/off/ { print $6 }' | head -n 1
