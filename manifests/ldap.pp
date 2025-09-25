# == Class: keystone::ldap
#
# Implements ldap configuration for keystone.
#
# === Parameters:
#
# [*url*]
#   URL for connecting to the LDAP server. (string value)
#   Defaults to $facts['os_service_default']
#
# [*user*]
#   User BindDN to query the LDAP server. (string value)
#   Defaults to $facts['os_service_default']
#
# [*password*]
#   Password for the BindDN to query the LDAP server. (string value)
#   Defaults to $facts['os_service_default']
#
# [*suffix*]
#   LDAP server suffix (string value)
#   Defaults to $facts['os_service_default']
#
# [*query_scope*]
#   The LDAP scope for queries, this can be either "one"
#   (onelevel/singleLevel) or "sub" (subtree/wholeSubtree). (string value)
#   Defaults to $facts['os_service_default']
#
# [*page_size*]
#   Maximum results per page; a value of zero ("0") disables paging. (integer value)
#   Defaults to $facts['os_service_default']
#
# [*user_tree_dn*]
#   Search base for users. (string value)
#   Defaults to $facts['os_service_default']
#
# [*user_filter*]
#   LDAP search filter for users. (string value)
#   Defaults to $facts['os_service_default']
#
# [*user_objectclass*]
#   LDAP objectclass for users. (string value)
#   Defaults to $facts['os_service_default']
#
# [*user_id_attribute*]
#   LDAP attribute mapped to user id. WARNING: must not be a multivalued attribute. (string value)
#   Defaults to $facts['os_service_default']
#
# [*user_name_attribute*]
#   LDAP attribute mapped to user name. (string value)
#   Defaults to $facts['os_service_default']
#
# [*user_description_attribute*]
#   LDAP attribute mapped to user description. (string value)
#   Defaults to $facts['os_service_default']
#
# [*user_mail_attribute*]
#   LDAP attribute mapped to user email. (string value)
#   Defaults to $facts['os_service_default']
#
# [*user_enabled_attribute*]
#   LDAP attribute mapped to user enabled flag. (string value)
#   Defaults to $facts['os_service_default']
#
# [*user_enabled_mask*]
#   Bitmask integer to indicate the bit that the enabled value is stored in if
#   the LDAP server represents "enabled" as a bit on an integer rather than a
#   boolean. A value of "0" indicates the mask is not used. If this is not set
#   to "0" the typical value is "2". This is typically used when
#   "user_enabled_attribute = userAccountControl". (integer value)
#   Defaults to $facts['os_service_default']
#
# [*user_enabled_default*]
#   Default value to enable users. This should match an appropriate int value
#   if the LDAP server uses non-boolean (bitmask) values to indicate if a user
#   is enabled or disabled. If this is not set to "True" the typical value is
#   "512". This is typically used when "user_enabled_attribute =
#   userAccountControl". (string value)
#   Defaults to $facts['os_service_default']
#
# [*user_enabled_invert*]
#   Invert the meaning of the boolean enabled values. Some LDAP servers use a
#   boolean lock attribute where "true" means an account is disabled. Setting
#   "user_enabled_invert = true" will allow these lock attributes to be used.
#   This setting will have no effect if "user_enabled_mask" or
#   "user_enabled_emulation" settings are in use. (boolean value)
#   Defaults to $facts['os_service_default']
#
# [*user_attribute_ignore*]
#   List of attributes stripped off the user on update. (list value)
#   Defaults to $facts['os_service_default']
#
# [*user_default_project_id_attribute*]
#   LDAP attribute mapped to default_project_id for users. (string value)
#   Defaults to $facts['os_service_default']
#
# [*user_pass_attribute*]
#   LDAP attribute mapped to password. (string value)
#   Defaults to $facts['os_service_default']
#
# [*user_enabled_emulation*]
#   If true, Keystone uses an alternative method to determine if
#   a user is enabled or not by checking if they are a member of
#   the "user_enabled_emulation_dn" group. (boolean value)
#   Defaults to $facts['os_service_default']
#
# [*user_enabled_emulation_dn*]
#   DN of the group entry to hold enabled users when using enabled emulation.
#   (string value)
#   Defaults to $facts['os_service_default']
#
# [*user_additional_attribute_mapping*]
#   List of additional LDAP attributes used for mapping
#   additional attribute mappings for users. Attribute mapping
#   format is <ldap_attr>:<user_attr>, where ldap_attr is the
#   attribute in the LDAP entry and user_attr is the Identity
#   API attribute. (list value)
#   Defaults to $facts['os_service_default']
#
# [*group_tree_dn*]
#   Search base for groups. (string value)
#   Defaults to $facts['os_service_default']
#
# [*group_filter*]
#   LDAP search filter for groups. (string value)
#   Defaults to $facts['os_service_default']
#
# [*group_objectclass*]
#   LDAP objectclass for groups. (string value)
#   Defaults to $facts['os_service_default']
#
# [*group_id_attribute*]
#   LDAP attribute mapped to group id. (string value)
#   Defaults to $facts['os_service_default']
#
# [*group_name_attribute*]
#   LDAP attribute mapped to group name. (string value)
#   Defaults to $facts['os_service_default']
#
# [*group_member_attribute*]
#   LDAP attribute mapped to show group membership. (string value)
#   Defaults to $facts['os_service_default']
#
# [*group_members_are_ids*]
#   LDAP attribute when members of the group object class are keystone user IDs. (boolean value)
#   Defaults to $facts['os_service_default']
#
# [*group_desc_attribute*]
#   LDAP attribute mapped to group description. (string value)
#   Defaults to $facts['os_service_default']
#
# [*group_attribute_ignore*]
#   List of attributes stripped off the group on update. (list value)
#   Defaults to $facts['os_service_default']
#
# [*group_additional_attribute_mapping*]
#   Additional attribute mappings for groups. Attribute mapping
#   format is <ldap_attr>:<user_attr>, where ldap_attr is the
#   attribute in the LDAP entry and user_attr is the Identity
#   API attribute. (list value)
#   Defaults to $facts['os_service_default']
#
# [*chase_referrals*]
#   Whether or not to chase returned referrals. (boolean value)
#   Defaults to $facts['os_service_default']
#
# [*use_tls*]
#   Enable TLS for communicating with LDAP servers. (boolean value)
#   Defaults to $facts['os_service_default']
#
# [*tls_cacertfile*]
#   CA certificate file path for communicating with LDAP servers. (string value)
#   Defaults to $facts['os_service_default']
#
# [*tls_cacertdir*]
#   CA certificate directory path for communicating with LDAP servers. (string value)
#   Defaults to $facts['os_service_default']
#
# [*tls_req_cert*]
#   Valid options for tls_req_cert are demand, never, and allow. (string value)
#   Defaults to $facts['os_service_default']
#
# [*connection_timeout*]
#   Connection timeout in seconds to use with the LDAP server. (integer value)
#   Defaults to $facts['os_service_default']
#
# [*use_pool*]
#   Enable LDAP connection pooling. (boolean value)
#   Defaults to $facts['os_service_default']
#
# [*pool_size*]
#   Connection pool size. (integer value)
#   Defaults to $facts['os_service_default']
#
# [*pool_retry_max*]
#   Maximum count of reconnect trials. (integer value)
#   Defaults to $facts['os_service_default']
#
# [*pool_retry_delay*]
#   Time span in seconds to wait between two reconnect trials. (floating point value)
#   Defaults to $facts['os_service_default']
#
# [*pool_connection_timeout*]
#   Connector timeout in seconds. Value -1 indicates indefinite wait for response. (integer value)
#   Defaults to $facts['os_service_default']
#
# [*pool_connection_lifetime*]
#   Connection lifetime in seconds. (integer value)
#   Defaults to $facts['os_service_default']
#
# [*use_auth_pool*]
#   Enable LDAP connection pooling for end user authentication.
#   If use_pool is disabled, then this setting is meaningless and is not used at all. (boolean value)
#   Defaults to $facts['os_service_default']
#
# [*auth_pool_size*]
#   End user auth connection pool size. (integer value)
#   Defaults to $facts['os_service_default']
#
# [*auth_pool_connection_lifetime*]
#   End user auth connection lifetime in seconds. (integer value)
#   Defaults to $facts['os_service_default']
#
# [*manage_packages*]
#   (optional) Whether or not this module should manage
#   LDAP support packages.
#   Defaults to true.
#
# [*package_ensure*]
#   (optional) Desired ensure state of packages.
#   accepts latest or specific versions.
#   Defaults to present.
#
# == Authors
#
#   Dan Bode dan@puppetlabs.com
#   Matt Fischer matt@mattfischer.com
#
# == Copyright
#
# Copyright 2012 Puppetlabs Inc, unless otherwise noted.
#
class keystone::ldap (
  $url                                    = $facts['os_service_default'],
  $user                                   = $facts['os_service_default'],
  $password                               = $facts['os_service_default'],
  $suffix                                 = $facts['os_service_default'],
  $query_scope                            = $facts['os_service_default'],
  $page_size                              = $facts['os_service_default'],
  $user_tree_dn                           = $facts['os_service_default'],
  $user_filter                            = $facts['os_service_default'],
  $user_objectclass                       = $facts['os_service_default'],
  $user_id_attribute                      = $facts['os_service_default'],
  $user_name_attribute                    = $facts['os_service_default'],
  $user_description_attribute             = $facts['os_service_default'],
  $user_mail_attribute                    = $facts['os_service_default'],
  $user_enabled_attribute                 = $facts['os_service_default'],
  $user_enabled_mask                      = $facts['os_service_default'],
  $user_enabled_default                   = $facts['os_service_default'],
  $user_enabled_invert                    = $facts['os_service_default'],
  $user_attribute_ignore                  = $facts['os_service_default'],
  $user_default_project_id_attribute      = $facts['os_service_default'],
  $user_pass_attribute                    = $facts['os_service_default'],
  $user_enabled_emulation                 = $facts['os_service_default'],
  $user_enabled_emulation_dn              = $facts['os_service_default'],
  $user_additional_attribute_mapping      = $facts['os_service_default'],
  $group_tree_dn                          = $facts['os_service_default'],
  $group_filter                           = $facts['os_service_default'],
  $group_objectclass                      = $facts['os_service_default'],
  $group_id_attribute                     = $facts['os_service_default'],
  $group_name_attribute                   = $facts['os_service_default'],
  $group_member_attribute                 = $facts['os_service_default'],
  $group_members_are_ids                  = $facts['os_service_default'],
  $group_desc_attribute                   = $facts['os_service_default'],
  $group_attribute_ignore                 = $facts['os_service_default'],
  $group_additional_attribute_mapping     = $facts['os_service_default'],
  $chase_referrals                        = $facts['os_service_default'],
  $use_tls                                = $facts['os_service_default'],
  Variant[Openstacklib::ServiceDefault, Stdlib::Absolutepath] $tls_cacertdir
    = $facts['os_service_default'],
  $tls_cacertfile                         = $facts['os_service_default'],
  $tls_req_cert                           = $facts['os_service_default'],
  $connection_timeout                     = $facts['os_service_default'],
  $use_pool                               = $facts['os_service_default'],
  $pool_size                              = $facts['os_service_default'],
  $pool_retry_max                         = $facts['os_service_default'],
  $pool_retry_delay                       = $facts['os_service_default'],
  $pool_connection_timeout                = $facts['os_service_default'],
  $pool_connection_lifetime               = $facts['os_service_default'],
  $use_auth_pool                          = $facts['os_service_default'],
  $auth_pool_size                         = $facts['os_service_default'],
  $auth_pool_connection_lifetime          = $facts['os_service_default'],
  Boolean $manage_packages                = true,
  Stdlib::Ensure::Package $package_ensure = present,
) inherits keystone::params {
  include keystone::deps

  if $manage_packages {
    ensure_resource('package',  'python-ldappool', {
      ensure => $package_ensure,
      name   => $keystone::params::python_ldappool_package_name,
      tag    => 'keystone-package'
    })
  }

  if ! is_service_default($tls_cacertdir) {
    file { $tls_cacertdir:
      ensure => directory,
    }
  }

  keystone_config {
    'ldap/url':                                  value => $url;
    'ldap/user':                                 value => $user;
    'ldap/password':                             value => $password, secret => true;
    'ldap/suffix':                               value => $suffix;
    'ldap/query_scope':                          value => $query_scope;
    'ldap/page_size':                            value => $page_size;
    'ldap/user_tree_dn':                         value => $user_tree_dn;
    'ldap/user_filter':                          value => $user_filter;
    'ldap/user_objectclass':                     value => $user_objectclass;
    'ldap/user_id_attribute':                    value => $user_id_attribute;
    'ldap/user_name_attribute':                  value => $user_name_attribute;
    'ldap/user_description_attribute':           value => $user_description_attribute;
    'ldap/user_mail_attribute':                  value => $user_mail_attribute;
    'ldap/user_enabled_attribute':               value => $user_enabled_attribute;
    'ldap/user_enabled_mask':                    value => $user_enabled_mask;
    'ldap/user_enabled_default':                 value => $user_enabled_default;
    'ldap/user_enabled_invert':                  value => $user_enabled_invert;
    'ldap/user_attribute_ignore':                value => $user_attribute_ignore;
    'ldap/user_default_project_id_attribute':    value => $user_default_project_id_attribute;
    'ldap/user_pass_attribute':                  value => $user_pass_attribute;
    'ldap/user_enabled_emulation':               value => $user_enabled_emulation;
    'ldap/user_enabled_emulation_dn':            value => $user_enabled_emulation_dn;
    'ldap/user_additional_attribute_mapping':    value => $user_additional_attribute_mapping;
    'ldap/group_tree_dn':                        value => $group_tree_dn;
    'ldap/group_filter':                         value => $group_filter;
    'ldap/group_objectclass':                    value => $group_objectclass;
    'ldap/group_id_attribute':                   value => $group_id_attribute;
    'ldap/group_name_attribute':                 value => $group_name_attribute;
    'ldap/group_member_attribute':               value => $group_member_attribute;
    'ldap/group_members_are_ids':                value => $group_members_are_ids;
    'ldap/group_desc_attribute':                 value => $group_desc_attribute;
    'ldap/group_attribute_ignore':               value => $group_attribute_ignore;
    'ldap/group_additional_attribute_mapping':   value => $group_additional_attribute_mapping;
    'ldap/chase_referrals':                      value => $chase_referrals;
    'ldap/use_tls':                              value => $use_tls;
    'ldap/tls_cacertdir':                        value => $tls_cacertdir;
    'ldap/tls_cacertfile':                       value => $tls_cacertfile;
    'ldap/tls_req_cert':                         value => $tls_req_cert;
    'ldap/connection_timeout':                   value => $connection_timeout;
    'ldap/use_pool':                             value => $use_pool;
    'ldap/pool_size':                            value => $pool_size;
    'ldap/pool_retry_max':                       value => $pool_retry_max;
    'ldap/pool_retry_delay':                     value => $pool_retry_delay;
    'ldap/pool_connection_timeout':              value => $pool_connection_timeout;
    'ldap/pool_connection_lifetime':             value => $pool_connection_lifetime;
    'ldap/use_auth_pool':                        value => $use_auth_pool;
    'ldap/auth_pool_size':                       value => $auth_pool_size;
    'ldap/auth_pool_connection_lifetime':        value => $auth_pool_connection_lifetime;
  }
}
