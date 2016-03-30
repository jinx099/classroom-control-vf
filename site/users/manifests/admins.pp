class users::admins {
  users::managed_user { 'jose': }
  users::managed_user { 'alice':
    group => 'staff',
  }
  users::managed_user { 'chen':
    group => 'staff',
    shell => '/bin/sh',
  }
  group { 'staff':
    ensure => present,
  }
}
