class users::admins {
  users::managed_user { 'jose': }
  users::managed_user { 'alice':
    groups => 'staff',
  }
  users::managed_user { 'chen':
    groups => [ 'staff', 'wheel' ],
    shell => '/bin/sh',
  }
  group { ['staff', 'wheel' ]:
    ensure => present,
  }
}
