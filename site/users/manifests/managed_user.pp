define users::managed_user (
  $shell = '/bin/bash',
  $group = $title,
  $groups = undef,
  $home = "/home/${title}",
) {
  user { $title:
    ensure => present,
    gid => $title,
    groups => $group,
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
  if $groups {
    group { $groups:
      ensure => present,
    }
  }
}
