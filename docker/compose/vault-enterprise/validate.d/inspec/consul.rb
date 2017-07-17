containers = %x{docker ps -f "name=consul" --format="{{.Names}}|{{.ID}}" | sort -n}

puts "\nContainer SUTs:\n"
puts "#{containers}"

describe command('consul members') do
  its('exit_status') { should eq 0 }
end
