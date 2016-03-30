define users::managed_user (
  $shell = '/bin/bash',
  $group = $title,
  $home = "/home/${title}",
) {
  user { $title:
    ensure => present,
    group => $group,
    shell => $shell,
  }
  file { "$home":
    ensure => directory,
    mode => '0750',
    owner => $title,
  }
}
