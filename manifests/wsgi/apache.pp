#
# Copyright 2013 eNovance <licensing@enovance.com>
#
# Author: Francois Charlier <francois.charlier@enovance.com>
#
# == Class: keystone::wsgi::apache
#
# Serve keystone with apache mod_wsgi in place of keystone service
# When using this class you should disable your keystone service.
#
# == Parameters
#
# [*servername*]
#   (Optional) The servername for the virtualhost.
#   Defaults to $::fqdn
#
# [*bind_host*]
#   (Optional) The host/ip address Apache will listen on.
#   Defaults to undef (listen on all ip addresses)
#
# [*api_port*]
#   (Optional) The keystone API port.
#   Defaults to 5000
#
# [*path*]
#   (Optional) The prefix for the API endpoint.
#   Defaults to '/'
#
# [*ssl*]
#   (Optional) Use SSL.
#   Defaults to true
#
# [*workers*]
#   (Optional) Number of WSGI workers to spawn.
#   Defaults to $::os_workers
#
# [*ssl_cert*]
#   (Optional) Path to SSL certificate
#   Default to apache::vhost 'ssl_*' defaults
#
# [*ssl_key*]
#   (Optional) Path to SSL key
#   Default to apache::vhost 'ssl_*' defaults
#
# [*ssl_chain*]
#   (Optional) SSL chain.
#   Default to apache::vhost 'ssl_*' defaults
#
# [*ssl_ca*]
#   (Optional) Path to SSL certificate authority.
#   Default to apache::vhost 'ssl_*' defaults
#
# [*ssl_crl_path*]
#   (Optional) Path to SSL certificate revocation list.
#   Default to apache::vhost 'ssl_*' defaults
#
# [*ssl_crl*]
#   (Optional) SSL certificate revocation list name.
#   Default to apache::vhost 'ssl_*' defaults
#
# [*ssl_certs_dir*]
#   (Optional) apache::vhost ssl parameters.
#   Default to apache::vhost 'ssl_*' defaults
#
# [*priority*]
#   (Optional) The priority for the vhost.
#   Defaults to '10'
#
# [*threads*]
#   (Optional) The number of threads for the vhost.
#   Defaults to 1
#
# [*wsgi_application_group*]
#   (Optional) The application group of the WSGI script.
#   Defaults to '%{GLOBAL}'
#
# [*wsgi_pass_authorization*]
#   (Optional) Whether HTTP authorisation headers are passed through to a WSGI
#   script when the equivalent HTTP request headers are present.
#   Defaults to 'On'
#
# [*wsgi_script_source*]
#   (Optional) The wsgi script source for the API.
#   This source is copied to the apache cgi-bin path as keystone-public.
#   Defaults to '/usr/bin/keystone-wsgi-public'
#
# [*custom_wsgi_process_options*]
#   (Optional) gives you the oportunity to add custom process options or to
#   overwrite the default options for the WSGI process.
#   For example to use a virtual python environment for the WSGI process
#   you could set it to:
#   { python-path => '/my/python/virtualenv' }
#   Defaults to {}
#
# [*access_log_file*]
#   (Optional) The log file name for the virtualhost.
#   Defaults to false
#
# [*access_log_pipe*]
#   (Optional) Specifies a pipe where Apache sends access logs for the virtualhost.
#   Defaults to false
#
# [*access_log_syslog*]
#   (Optional) Sends the virtualhost access log messages to syslog.
#   Defaults to false
#
# [*access_log_format*]
#   (Optional) The log format for the virtualhost.
#   Defaults to false
#
# [*error_log_file*]
#   (Optional) The error log file name for the virtualhost.
#   Defaults to undef
#
# [*error_log_pipe*]
#   (Optional) Specifies a pipe where Apache sends error logs for the virtualhost.
#   Defaults to undef
#
# [*error_log_syslog*]
#   (Optional) Sends the virtualhost error log messages to syslog.
#   Defaults to undef
#
# [*headers*]
#   (Optional) Headers for the vhost.
#   Defaults to undef
#
# [*vhost_custom_fragment*]
#   (Optional) Passes a string of custom configuration
#   directives to be placed at the end of the vhost configuration.
#   Defaults to undef
#
# [*wsgi_chunked_request*]
#   (Optional) apache::vhost wsgi_chunked_request parameter.
#   Defaults to undef
#
## DEPRECATED PARAMS
#
# [*servername_admin*]
#   (Optional) The servername for the admin virtualhost.
#   Defaults to undef
#
# [*public_port*]
#   (Optional) The public port.
#   Defaults to undef
#
# [*admin_port*]
#   (Optional) The admin port.
#   Defaults to undef
#
# [*admin_bind_host*]
#   (Optional) The host/ip address Apache will listen on for admin API connections.
#   Defaults to undef
#
# [*public_path*]
#   (Optional) The prefix for the public endpoint.
#   Defaults to undef
#
# [*admin_path*]
#   (Optional) The prefix for the admin endpoint.
#   Defaults to undef
#
# [*ssl_cert_admin*]
#   (Optional) Path to SSL certificate for the admin endpoint.
#   Default to undef
#
# [*ssl_key_admin*]
#   (Optional) Path to SSL key for the admin endpoint.
#   Default to undef
#
# [*wsgi_admin_script_source*]
#   (Optional) Wsgi script source for the admin endpoint. If set to undef
#   $::keystone::params::keystone_wsgi_admin_script_path is used. This source
#   is copied to the apache cgi-bin path as keystone-admin.
#   Defaults to undef
#
# [*wsgi_public_script_source*]
#   (Optional) Wsgi script source for the public endpoint. If set to undef
#   $::keystone::params::keystone_wsgi_public_script_path is used. This source
#   is copied to the apache cgi-bin path as keystone-main.
#   Defaults to undef
#
# [*custom_wsgi_process_options_main*]
#   (Optional) gives you the oportunity to add custom process options or to
#   overwrite the default options for the WSGI main process.
#   For example to use a virtual python environment for the WSGI process
#   you could set it to:
#   { python-path => '/my/python/virtualenv' }
#   Defaults to undef
#
# [*custom_wsgi_process_options_admin*]
#   (Optional) gives you the oportunity to add custom process options or to
#   overwrite the default options for the WSGI admin process.
#   eg. to use a virtual python environment for the WSGI process
#   you could set it to:
#   { python-path => '/my/python/virtualenv' }
#   Defaults to undef
#
class keystone::wsgi::apache (
  $servername                        = $::fqdn,
  $bind_host                         = undef,
  $api_port                          = 5000,
  $path                              = '/',
  $ssl                               = true,
  $workers                           = $::os_workers,
  $ssl_cert                          = undef,
  $ssl_key                           = undef,
  $ssl_chain                         = undef,
  $ssl_ca                            = undef,
  $ssl_crl_path                      = undef,
  $ssl_crl                           = undef,
  $ssl_certs_dir                     = undef,
  $threads                           = 1,
  $priority                          = '10',
  $wsgi_application_group            = '%{GLOBAL}',
  $wsgi_pass_authorization           = 'On',
  $wsgi_chunked_request              = undef,
  $wsgi_script_source                = '/usr/bin/keystone-wsgi-public',
  $access_log_file                   = false,
  $access_log_pipe                   = false,
  $access_log_syslog                 = false,
  $access_log_format                 = false,
  $error_log_file                    = undef,
  $error_log_pipe                    = undef,
  $error_log_syslog                  = undef,
  $headers                           = undef,
  $vhost_custom_fragment             = undef,
  $custom_wsgi_process_options       = {},
  ## DEPRECATED PARAMS
  $servername_admin                  = undef,
  $public_port                       = undef,
  $admin_port                        = undef,
  $admin_bind_host                   = undef,
  $public_path                       = undef,
  $admin_path                        = undef,
  $ssl_cert_admin                    = undef,
  $ssl_key_admin                     = undef,
  $wsgi_admin_script_source          = undef,
  $wsgi_public_script_source         = undef,
  $custom_wsgi_process_options_main  = undef,
  $custom_wsgi_process_options_admin = undef,
) inherits ::keystone::params {

  include ::keystone::deps

  # TODO(tobias-urdin): Remove all deprecated parameters and this warnings in Train release.
  if $servername_admin {
    warning('keystone::wsgi::apache::servername_admin has no effect, please use servername')
  }
  if $public_port or $admin_port {
    warning('keystone::wsgi::apache::public_port and admin_port has no effect, please use api_port')
  }
  if $admin_bind_host {
    warning('keystone::wsgi::apache::admin_bind_host has no effect, please use bind_host')
  }
  if $public_path or $admin_path {
    warning('keystone::wsgi::apache::public_path and admin_path has no effect, please use path')
  }
  if $ssl_cert_admin or $ssl_key_admin {
    warning('keystone::wsgi::apache::ssl_cert_admin and ssl_key_admin has no effect, please use ssl_cert and ssl_key')
  }
  if $wsgi_admin_script_source or $wsgi_public_script_source {
    warning('keystone::wsgi::apache::wsgi_admin_script_source and wsgi_public_script_source has no effect, please use wsgi_script_source')
  }
  if $custom_wsgi_process_options_main or $custom_wsgi_process_options_admin {
    warning('keystone::wsgi::apache::custom_wsgi_process_options_main and custom_wsgi_process_options_admin has no effect, \
please use custom_wsgi_process_options')
  }

  # TODO(tobias-urdin): This dependency chaining can be moved to keystone::deps
  # when we have cleaned up some old eventlet code and users are forced to use
  # apache even though it's pretty much enforced today.

  # The httpd package is untagged, but needs to have ordering enforced,
  # so handle it here rather than in the deps class.
  Anchor['keystone::install::begin']
  -> Package['httpd']
  -> Anchor['keystone::install::end']

  # Configure apache during the config phase
  Anchor['keystone::config::begin']
  -> Apache::Vhost<||>
  ~> Anchor['keystone::config::end']

  # Start the service during the service phase
  Anchor['keystone::service::begin']
  -> Service['httpd']
  -> Anchor['keystone::service::end']

  # Notify the service when config changes
  Anchor['keystone::config::end']
  ~> Service['httpd']

  ::openstacklib::wsgi::apache { 'keystone_wsgi':
    servername                  => $servername,
    bind_host                   => $bind_host,
    bind_port                   => $api_port,
    group                       => $::keystone::params::keystone_group,
    path                        => $path,
    workers                     => $workers,
    threads                     => $threads,
    user                        => $::keystone::params::keystone_user,
    priority                    => $priority,
    ssl                         => $ssl,
    ssl_cert                    => $ssl_cert,
    ssl_key                     => $ssl_key,
    ssl_chain                   => $ssl_chain,
    ssl_ca                      => $ssl_ca,
    ssl_crl_path                => $ssl_crl_path,
    ssl_crl                     => $ssl_crl,
    ssl_certs_dir               => $ssl_certs_dir,
    wsgi_daemon_process         => 'keystone',
    wsgi_process_display_name   => 'keystone',
    wsgi_process_group          => 'keystone',
    wsgi_script_dir             => $::keystone::params::keystone_wsgi_script_path,
    wsgi_script_file            => 'keystone',
    wsgi_script_source          => $wsgi_script_source,
    wsgi_application_group      => $wsgi_application_group,
    wsgi_pass_authorization     => $wsgi_pass_authorization,
    wsgi_chunked_request        => $wsgi_chunked_request,
    headers                     => $headers,
    custom_wsgi_process_options => $custom_wsgi_process_options,
    vhost_custom_fragment       => $vhost_custom_fragment,
    access_log_file             => $access_log_file,
    access_log_pipe             => $access_log_pipe,
    access_log_syslog           => $access_log_syslog,
    access_log_format           => $access_log_format,
    error_log_file              => $error_log_file,
    error_log_pipe              => $error_log_pipe,
    error_log_syslog            => $error_log_syslog,
  }

  # Workaround to empty Keystone vhost that is provided & activated by default with running
  # Canonical packaging (called 'keystone'). This will make sure upgrading the package is
  # possible, see https://bugs.launchpad.net/ubuntu/+source/keystone/+bug/1737697
  if ($::operatingsystem == 'Ubuntu') {
    ensure_resource('file', '/etc/apache2/sites-available/keystone.conf', {
      'ensure'  => 'file',
      'content' => '',
    })
    ensure_resource('file', '/etc/apache2/sites-enabled/keystone.conf', {
      'ensure'  => 'file',
      'content' => '',
    })

    Package<| tag == 'keystone-package' |>
      -> File<| title == '/etc/apache2/sites-available/keystone.conf' |>
      -> File<| title == '/etc/apache2/sites-enabled/keystone.conf'|>
      ~> Anchor['keystone::install::end']
  }
}
