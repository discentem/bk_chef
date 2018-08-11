resource_name :bk_apm
default_action :run

action :run do

  # return if node['bk_apm']['packages'].nil?
  packages = ['platformio-ide-terminal']

  apm_cmd = node['bk_apm']['cmd']
  packages.each do |package|
    execute "install apm package: #{package}" do
      command "\"#{apm_cmd}\" install #{package}"
      not_if powershell_out("\'#{apm_cmd}\' list) | select-string #{package}").stdout.include?(package)
      action :run
    end
  end
end
