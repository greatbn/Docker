cat << EOF >> /etc/manila/manila.conf
[$BACKEND_NAME]
share_backend_name = $BACKEND_NAME
glusterfs_nfs_server_type = Ganesha
glusterfs_target=$GLUSTERFS_USER@$GLUSTERFS_ADDR:/$GLUSTERFS_VOLUME
glusterfs_server_password=$GLUSTERFS_PASS
share_driver = manila.share.drivers.glusterfs.GlusterfsShareDriver
ganesha_service_name = nfs-ganesha
driver_handles_share_servers = False
glusterfs_ganesha_server_ip=$GANESHA_ADDR
glusterfs_ganesha_server_username=$GANESHA_USER
glusterfs_ganesha_server_password=$GANESHA_PASS
EOF
