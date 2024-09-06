class profiles::basic_server {
  $motd_message = hiera('motd_message')

  # Configure Motd
  file { '/etc/motd':
    ensure  => file,
    content => epp('profiles/motd_basic.epp', {
      user            => $facts['user'],
      current_datetime => $facts['timestamp'],
    }),
  }
}
