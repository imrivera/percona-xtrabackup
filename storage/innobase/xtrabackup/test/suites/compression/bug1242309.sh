#############################################################################
# Bug 1242309: xtrabackup_logfile not compressed in XtraBackup 2.1+
#############################################################################

start_server

xtrabackup --backup --compress --target-dir=$topdir/backup

if [ ! -f $topdir/backup/xtrabackup_logfile.zst ] ; then
	die "xtrabackup_logfile is not compressed!"
fi

rm -rf $topdir/backup/*

xtrabackup --backup --compress --stream=xbstream --target-dir=$topdir/backup | xbstream -xv -C $topdir/backup

if [ ! -f $topdir/backup/xtrabackup_logfile.zst ] ; then
	die "xtrabackup_logfile is not compressed!"
fi
