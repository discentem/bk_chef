require 'pry'

resource_name :bk_apm
default_action :run

action :run do

  # return if node['bk_apm']['packages'].nil?

  apm_cmd = node['bk_apm']['cmd']
  node['bk_apm']['packages'].each do |package|

    apm_list = "& \"#{apm_cmd}\" list | select-string #{package}"
    execute "install apm package: #{package}" do
      command "\"#{apm_cmd}\" install #{package}"
      not_if { powershell_out(apm_list).stdout.include?(package) }
      action :run
    end
    
  end
end
