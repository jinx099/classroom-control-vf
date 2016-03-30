define users::managed_user (
  $shell = '/bin/bash',
) {
    user { $title:
    ensure => present,
  }
  file { "/home/${title}":
    ensure => directory,
    owner => $title,
    group => $group,
  }
}
