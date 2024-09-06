class profiles::dev_server {
  $motd_message = hiera('motd_message')
  $admin_password = hiera('admin_password')

  # Create admin user
  user { 'admin':
    ensure     => 'present',
    password   => $admin_password,
    shell      => '/bin/bash',
  }

  # Install Nginx
  package { 'nginx':
    ensure => installed,
  }

  # Install Git
  package { 'git':
    ensure => installed,
  }

  # Configure Motd
  file { '/etc/motd':
    ensure  => file,
    content => epp('profiles/motd_dev.epp'), {
      user => $facts['user'],
      current_datetime => $facts['timestamp'],
    }
  }
}
