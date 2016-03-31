class nginx (
  $root = '/var/www',
){

  $nginx_conf_dir = '/etc/nginx/conf.d'
  $doc_root = $root

  File {
    owner   => 'root',
    group   => 'root',
    mode    => '0644',
  }

  package { 'nginx':
    ensure => present,
  }

  file { '/etc/nginx/nginx.conf':
    ensure  => file,
    #source  => 'puppet:///modules/nginx/nginx.conf',
    content => template('nginx/nginx.conf.erb'),
    require => Package['nginx'],
  }
  
  file { "${nginx_conf_dir}/default.conf":
    ensure  => file,
    #source  => 'puppet:///modules/nginx/default.conf',
    content => template('nginx/default.conf.erb'),
    require => Package['nginx']
  }
  
  file { "${doc_root}/index.html":
    ensure  => file,
    #source  => 'puppet:///modules/nginx/index.html',
    content => template('nginx/index.html.erb'),
  }
  
#  file { [ "${nginx_conf_dir}", "${doc_root}" ]:
#    ensure  =>  directory,
#  }

#  file { [ '/etc/nginx/conf.d', '/var/www' ]:
#    ensure  =>  directory,
#  }

  file { $doc_root:
    ensure  =>  directory,
  }
  
  file { '/etc/nginx/conf.d':
    ensure  =>  directory,
  }

  service { 'nginx':
    ensure    => running,
    enable    => true,
    subscribe => [ File['/etc/nginx/nginx.conf'], File["${nginx_conf_dir}/default.conf"], ],
  }
}
