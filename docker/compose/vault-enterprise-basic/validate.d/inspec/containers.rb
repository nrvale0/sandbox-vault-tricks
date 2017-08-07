containers = %w(
  consul-enterprise0
  consul-enterprise1
  consul-enterprise2
  consul-enterprise3
  consul-enterprise4
  vault-enterprise0
  vault-enterprise1
  vault-enterprise2
)

# Check on existance of containers
containers.each do |container_name|
  describe docker_container(container_name) do
    it { should exist }
    it { should be_running }
  end
end
