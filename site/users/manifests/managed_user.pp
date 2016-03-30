define users::managed_user (
  $shell = '/bin/bash',
  $group = $title,
  $home = "/home/${title}",
) {
  user { $title:
    ensure => present,
    gid => $group,
    shell => $shell,
  }
  file { "$home":
    ensure => directory,
    mode => '0750',
    owner => $title,
  }
  group { $group:
    ensure => present,
  }
}
