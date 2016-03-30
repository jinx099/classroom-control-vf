define users::managed_user (
  $shell = '/bin/bash',
  $group = $title,
) {
    user { $title:
    ensure => present,
  }
  file { "/home/${title}":
    ensure => directory,
    owner => $title,
    group => $group,
    shell => $shell,
  }
}
