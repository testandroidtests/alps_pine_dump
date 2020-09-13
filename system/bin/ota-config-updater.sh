#!/system/bin/sh

# Copyright (C) 2015 Sony Mobile Communications Inc.
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#      http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#
# NOTE: This file has been modified by Sony Mobile Communications Inc.
# Modifications are licensed under the License.

# Script to create symlinks depending on currently active configuration
# Script to update symlinks when config files are updated runtime.
# The files that shall be updated shall be stored in the /data/ota-config/
# folder. When a file is stored in the folder it shall be called n-<filename>.


echo "ota-config-updater.sh ..."
src_dir="/data/customization"
target_dir="/data/customization/ota-config"


customized_filenames="apns-conf.xml"

echo "list customized_filenames:"
echo ${customized_filenames}

for filename in ${customized_filenames}; do
    src="${src_dir}/${filename}"
    dest="${target_dir}/${filename}"
    ota_file="${target_dir}/n-${filename}"
    echo "src:"
    echo ${src}
    echo "dest:"
    echo ${dest}
    echo "ota_file:"
    echo ${ota_file}
    if [ -e "${ota_file}" ]; then
        echo "do action ...."
        /system/bin/mv -f "$ota_file" "$dest"
        /system/bin/chmod 755 "$dest"
        /system/bin/ln -sf "${dest}" "${src}"
    fi
done