# Class: monitoring::node_exporter
#
# Parameters:
class monitoring::node_exporter (
  $version,
  $user    = 'node_exporter',
  $exporter_name = 'node_exporter',
  $service_ensure = 'running',
  $service_enable = true,
  $port = 9100,
  $ignored_mount_points = '"^/(var/lib/docker/)|(run/docker/netns/).*"'
) {

  monitoring::daemon { $exporter_name:
    user               => $user,
    version            => $version,
    download_extension => 'tar.gz',
    real_download_url  => "https://github.com/prometheus/${exporter_name}/releases/download/v${version}/${exporter_name}-${version}.linux-amd64.tar.gz",
    runtime_options    => "--web.listen-address=:${port} --collector.filesystem.ignored-mount-points=${ignored_mount_points}",
    service_ensure     => $service_ensure,
    service_enable     => $service_enable,
  }
}
