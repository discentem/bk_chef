resource_name :bk_firefox
default_action :run

action :run do

  return if node['bk_firefox']['policies'].nil?
  policies = node['bk_firefox']['policies'].reject do |_k, v|
    v.nil?
  end

  app = "/Applications/Firefox.app"
  policy_file = value_for_platform_family(
    'mac_os_x' => "#{app}/Contents/Resources/distribution/policies.json"
  )
  policy_dir = ::File.dirname(policy_file)

  directory policy_dir do
    action :create
  end

  policies = { 'policies' => policies }
  file "#{policy_file}" do
    content Chef::JSONCompat.to_json_pretty(policies)
    action :create
  end
end
