# == Class: keystone::federation::openidc
#
# == Parameters
#
# [*keystone_url*]
#  (Required) URL to keystone endpoint.
#
# [*methods*]
#  A list of methods used for authentication separated by comma or an array.
#  The allowed values are: 'external', 'password', 'token', 'oauth1', 'saml2',
#  and 'openid'
#  (Required) (string or array value).
#  Note: The external value should be dropped to avoid problems.
#
# [*idp_name*]
#  The name name associated with the IdP in Keystone.
#  (Required) String value.
#
# [*openidc_provider_metadata_url*]
#  (Optional) The url that points to your OpenID Connect metadata provider.
#  Defaults to undef
#
# [*openidc_metadata_dir*]
#  (Optional) Path of OIDCMetadataDir, directory that holds metadata in case of
#  usage of multiple OIDC provider.
#  Defaults to undef
#
# [*openidc_client_id*]
#  The client ID to use when handshaking with your OpenID Connect provider
#  (Required) String value.
#
# [*openidc_client_secret*]
#  The client secret to use when handshaking with your OpenID Connect provider
#  (Required) String value.
#
# [*openidc_crypto_passphrase*]
#  Secret passphrase to use when encrypting data for OpenID Connect handshake
#  (Optional) String value.
#  Defaults to 'openstack'
#
# [*openidc_response_type*]
#  Response type to be expected from the OpenID Connect provider.
#  (Optional) String value.
#  Defaults to 'id_token'
#
# [*openidc_response_mode*]
#  (Optional) mod_auth_openidc response mode. Can be any response type
#  supported by mod_auth_openidc (fragment, query, form_post).
#  Defaults to undef
#
# [*openidc_cache_type*]
#  (Optional) mod_auth_openidc cache type.  Can be any cache type
#  supported by mod_auth_openidc (shm, file, memcache, redis).
#  Defaults to undef.
#
# [*openidc_scope*]
#  (Optional) Array of mod_auth_openidc requested scope(s).
#  Defaults to ['openid', 'email', 'profile'].
#
# [*openidc_cache_shm_max*]
#  (Optional) The maximum number of name/value pair entries that can
#  be cached when using the 'shm' cache type. Defaults to undef.
#
# [*openidc_cache_shm_entry_size*]
#  (Optional) The maximum size for a single shm cache entry in bytes
#  with a minimum of 8464 bytes. Defaults to undef.
#
# [*openidc_cache_dir*]
#  (Optional) Directory that holds cache files; must be writable
#  for the Apache process/user. Defaults to undef.
#
# [*openidc_cache_clean_interval*]
#  (Optional) Cache file clean interval in seconds (only triggered
#  on writes). Defaults to undef.
#
# [*openidc_claim_delimiter*]
#  (Optional) The delimiter to use when setting multi-valued claims.
#  Defaults to undef.
#
# [*openidc_enable_oauth*]
#  (Optional) Set to true to enable oauthsupport.
#  Defaults to false.
#
# [*openidc_introspection_endpoint*]
#  (Required if oauth is enabled and configured for introspection)
#  OAuth introspection endpoint url.
#  Defaults to undef.
#
# [*openidc_verify_jwks_uri*]
#  (Required if oauth is enabled and configured for JWKS based validation)
#  The JWKS URL on which the Identity Provider
#  publishes the keys used to sign its JWT access tokens.
#  Defaults to undef.
#
# [*openidc_verify_method*]
#  (Optional) The method used to verify OAuth tokens.
#  Must be one of introspection or jwks
#  Defaults to introspection
#
# [*openidc_pass_userinfo_as*]
#  Define the way(s) in which the claims resolved from the userinfo endpoint
#  are passed to the application according to OIDCPassClaimsAs.
#  Defaults to undef
#
# [*openidc_pass_claim_as*]
#  Define the way in which the claims and tokens are passed to the application environment:
#  "none": no claims/tokens are passed
#  "environment": claims/tokens are passed as environment variables
#  "headers": claims/tokens are passed in headers (also useful in reverse proxy scenario's)
#  "both": claims/tokens are passed as both headers as well as environment variables (default)
#  Defaults to undef
#
# [*openidc_redirect_uri*]
#  (Optional) An arbitrary URI for OIDCRedirectURI. Defaults to undef, in this
#  case the URI is generated from keystone_url and idp_name.
#
# [*additional_locations*]
#  (Optional) Array of hashes of additional Apache <Location> directives with
#  mod_auth_openidc configuration. Accepted parameters are url, authtype,
#  oidcdiscoverurl (optional), requireoidc, loglevel (optional)
#  Example:
#  additional_locations => [{
#    url             => "/v3/auth/OS-FEDERATION/a-custom-url-needed-somehow",
#    authtype        => "openid-connect",
#    oidcdiscoverurl => "https://my-endpoint.example.com:40000",
#    requireoidc     => "claim iss:https://iam.example.com",
#    loglevel        => "debug"
#  }]
#
# [*memcached_servers*]
#  (Optional) A list of memcache servers. Defaults to undef.
#
# [*redis_server*]
#  (Optional) Specifies the Redis server used for caching as
#  <hostname>[:<port>]. Defaults to undef.
#
# [*redis_password*]
#  (Optional) Password to be used if the Redis server requires
#  authentication. When not specified, no authentication is
#  performed. Defaults to undef.
#
# [*redis_username*]
#  (Optional) Username to be used if the Redis server requires
#  authentication.
#  Defaults to undef
#
# [*redis_database*]
#  (Optional) Logical database to select on the Redis server.
#  Defaults to undef
#
# [*redis_connect_timeout*]
#  (Optional) Timeout (in seconds) for connecting to the Redis servers.
#  Defaults to undef
#
# [*redis_timeout*]
#  (Optional) Timeout waiting for a response of the Redis servers after
#  a request was sent.
#  Defaults to undef
#
# [*remote_id_attribute*]
#  (Optional) Value to be used to obtain the entity ID of the Identity
#  Provider from the environment.
#  Defaults to $facts['os_service_default'].
#
# [*template_order*]
#  This number indicates the order for the concat::fragment that will apply
#  the shibboleth configuration to Keystone VirtualHost. The value should
#  The value should be greater than 330 an less then 999, according to:
#  https://github.com/puppetlabs/puppetlabs-apache/blob/master/manifests/vhost.pp
#  The value 330 corresponds to the order for concat::fragment  "${name}-filters"
#  and "${name}-limits".
#  The value 999 corresponds to the order for concat::fragment "${name}-file_footer".
#  (Optional) Defaults to 331.
#
class keystone::federation::openidc (
  $keystone_url,
  $methods,
  $idp_name,
  $openidc_client_id,
  $openidc_client_secret,
  Optional[Stdlib::HTTPUrl] $openidc_provider_metadata_url = undef,
  Optional[Stdlib::Unixpath] $openidc_metadata_dir         = undef,
  $openidc_crypto_passphrase                               = 'openstack',
  $openidc_response_type                                   = 'id_token',
  Array[String[1], 1] $openidc_scope                       = ['openid', 'email', 'profile'],
  $openidc_response_mode                                   = undef,
  $openidc_cache_type                                      = undef,
  $openidc_cache_shm_max                                   = undef,
  $openidc_cache_shm_entry_size                            = undef,
  $openidc_cache_dir                                       = undef,
  $openidc_cache_clean_interval                            = undef,
  $openidc_claim_delimiter                                 = undef,
  Boolean $openidc_enable_oauth                            = false,
  $openidc_introspection_endpoint                          = undef,
  $openidc_verify_jwks_uri                                 = undef,
  Enum['introspection', 'jwks'] $openidc_verify_method     = 'introspection',
  Optional[Enum['claims', 'json', 'jwt']] $openidc_pass_userinfo_as = undef,
  Optional[Enum['none', 'environment', 'headers', 'both']] $openidc_pass_claim_as = undef,
  $openidc_redirect_uri                                    = undef,
  Optional[Array[Hash]] $additional_locations              = undef,
  $memcached_servers                                       = undef,
  $redis_server                                            = undef,
  $redis_password                                          = undef,
  $redis_username                                          = undef,
  $redis_database                                          = undef,
  $redis_connect_timeout                                   = undef,
  $redis_timeout                                           = undef,
  $remote_id_attribute                                     = $facts['os_service_default'],
  $template_order                                          = 331,
) {
  include apache
  include apache::mod::auth_openidc

  include keystone::deps
  include keystone::params

  if ! defined(Class['keystone::wsgi::apache']) {
    fail('The keystone::wsgi::apache class should be included in the catalog')
  }
  # With a single provider, OIDCProviderMetadataURL should be set, with multiple
  # providers OIDCMetadataDir should be used instead
  if !$openidc_provider_metadata_url and !$openidc_metadata_dir {
    fail('Set one openidc_provider_metadata_url or openidc_metadata_dir')
  }
  if $openidc_provider_metadata_url and $openidc_metadata_dir {
    fail("openidc_provider_metadata_url and openidc_metadata_dir are mutually \
exclusive, set only one of the two.")
  }

  if $openidc_enable_oauth {
    if ($openidc_verify_method == 'introspection') {
      if !$openidc_introspection_endpoint {
        fail("You must set openidc_introspection_endpoint when enabling oauth support \
and introspection.")
      }
    } else { # $openidc_verify_method == 'jwks'
      if !$openidc_verify_jwks_uri {
        fail("You must set openidc_verify_jwks_uri when enabling oauth support \
and local signature verification using a JWKS URL")
      }
    }
  }

  if $memcached_servers != undef {
    $memcached_servers_real = join(any2array($memcached_servers), ' ')
  } else {
    $memcached_servers_real = undef
  }

  # Note: if puppet-apache modify these values, this needs to be updated
  if $template_order <= 330 or $template_order >= 999 {
    fail('The template order should be greater than 330 and less than 999.')
  }

  if ('external' in $methods ) {
    fail('The external method should be dropped to avoid any interference with openid.')
  }

  if !('openid' in $methods ) {
    fail('Methods should contain openid as one of the auth methods.')
  }

  keystone_config {
    'auth/methods':               value => join(any2array($methods),',');
    'openid/remote_id_attribute': value => $remote_id_attribute;
  }

  apache::vhost::fragment { 'configure_openidc_keystone':
    vhost    => 'keystone_wsgi',
    priority => $keystone::wsgi::apache::priority,
    content  => template('keystone/openidc.conf.erb'),
    order    => $template_order,
  }

  Concat<| title == "${keystone::wsgi::apache::priority}-keystone_wsgi.conf" |> {
    show_diff => false,
  }
}
