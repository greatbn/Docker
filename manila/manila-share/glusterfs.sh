cat << EOF > /etc/manila/manila.conf
[$BACKEND_NAME]
share_backend_name = $BACKEND_NAME
glusterfs_servers = root@glusterfs-1
glusterfs_server_password = saphi
glusterfs_volume_pattern = manila-#{size}-.*
share_driver = manila.share.drivers.glusterfs.glusterfs_native.GlusterfsNativeShareDriver
driver_handles_share_servers = False
EOF
