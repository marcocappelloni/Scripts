#!/bin/bash

# Run sensors command and store the output
SENSORS_OUTPUT=$(sensors)

echo "--- System Temperature Report ( $(date) ) ---"

# 1. CPU Temperature (k10temp)
# Tctl is the thermal control temperature for AMD CPUs
CPU_TEMP=$(echo "$SENSORS_OUTPUT" | grep 'k10temp' -A 2 | grep 'Tctl' | awk '{print $2}' | tr -d '+' | tr -d '°C')

echo "## 💻 CPU Temperature (AMD)"
if [ -z "$CPU_TEMP" ]; then
  echo "Could not find CPU temperature (Tctl)."
else
  echo "Tctl (CPU): ${CPU_TEMP}"
fi

echo "---"

# 2. GPU Temperature (amdgpu)
# 'edge' is often the most relevant die temperature for AMD GPUs
GPU_TEMP=$(echo "$SENSORS_OUTPUT" | grep 'amdgpu' -A 4 | grep 'edge:' | awk '{print $2}' | tr -d '+')

echo "## 🎮 GPU Temperature (AMDGPU)"
if [ -z "$GPU_TEMP" ]; then
  echo "Could not find GPU temperature (edge)."
else
  echo "Edge (GPU): ${GPU_TEMP}"
fi

echo "---"

# 3. Disk Temperature (nvme)
# 'Composite' is the overall temperature for the NVMe drive
DISK_TEMP=$(echo "$SENSORS_OUTPUT" | grep 'nvme' -A 2 | grep 'Composite' | awk '{print $2}' | tr -d '+')

echo "## 💾 Disk Temperature (NVMe)"
if [ -z "$DISK_TEMP" ]; then
  echo "Could not find Disk temperature (Composite)."
else
  echo "Composite (NVMe): ${DISK_TEMP}"
fi

echo "-----------------------------------------------------"
echo -e "$CPU_TEMP\n$GPU_TEMP\n$DISK_TEMP" | sort -nr | head -1
# Component,Low (Idle),Medium (Load),High (Warning),Critical (Throttling/Damage Risk)
# CPU (AMD/Intel),<40∘C,40∘C−70∘C,70∘C−90∘C,>95∘C
# GPU (Gaming/Load),<45∘C,45∘C−80∘C,80∘C−95∘C,>95∘C−105∘C
# NVMe SSD / HDD,<35∘C,35∘C−55∘C,55∘C−65∘C,>70∘C
