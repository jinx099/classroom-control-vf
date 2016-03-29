class nginx {
  package { 'nginx':
    ensure => present,
  }

  file { '/etc/nginx/nginx.conf':
    ensure  => file,
    #owner   => 'root',
    #group   => 'root',
    #mode    => '0644',
    source  => 'puppet:///modules/nginx/nginx.conf',
    require => Package['nginx'],
  }
  
  file { '/etc/nginx/conf.d/default.conf':
    ensure  => file,
    #owner   => 'root',
    #group   => 'root',
    #mode    => '0644',
    source  => 'puppet:///modules/nginx/default.conf',
    require => Package['nginx']
    require => Directory['/etc/nginx/conf.d'],
  }
  
  file { '/etc/nginx/conf.d':
    ensure  =>  directory,
  }
  
  file { '/var/www':
    ensure  =>  directory,
  }
  
  file { '/var/www/index.html':
    ensure  =>  directory,
    require =>  File['/var/www'],
  }

  service { 'nginx':
    ensure    => running,
    enable    => true,
    subscribe => File['/etc/nginx/nginx.conf'],
    subscribe => File['/etc/nginx/conf.d/default.conf'],
  }
}
