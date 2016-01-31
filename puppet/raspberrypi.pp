# This config requires changes to netatalk module as found at
# https://github.com/ryanycoleman/puppet-netatalk.
$ext_drive_device = '/dev/sda1'
$ext_mount_point = "/mnt/ext"
$timecapsule_path = "${ext_mount_point}/timecapsule"
$allowed_user = 'pi'

# Group containing all afp users.
$afp_users = 'afp_users'

group { $afp_users:
  ensure => present,
} -> 

user { $allowed_user:
  ensure => present,
  groups => $afp_users,
}

# Prepare the mountpoint.
file { $ext_mount_point :
  ensure => directory,
}

mount { 'External drive':
	name => $ext_mount_point,
	require => File[$ext_mount_point], 
	ensure => mounted,
	device => $ext_drive_device,
	options => 'rw,relatime,data=ordered',
	fstype => ext4,
}

file { $timecapsule_path:
  require => Mount['External drive'],
  ensure => directory,
  owner => root,
  group => $afp_users,
  mode => 775,
}

class { 'netatalk': 
  share_home_directories => false,
}

netatalk::volume { 'timecapsule':
  path => $timecapsule_path,
  volume_name => 'RPi Time Capsule',
  options => 'options:tm volsize:1000000 allow:@${afp_users}',
  require => File[$timecapsule_path],
}

$share_path = "${ext_mount_point}/share/files"
file { $share_path:
  require => Mount['External drive'],
  ensure => directory,
  owner => root,
  group => $afp_users,
}
netatalk::volume { 'share':
  path => $share_path,
  volume_name => 'NAS',
  options => 'allow:@${afp_users}',
  require => File[$share_path],
}
