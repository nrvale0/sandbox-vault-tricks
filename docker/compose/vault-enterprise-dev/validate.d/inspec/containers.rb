containers = %w(
  vault-enterprise-dev0
)

# Check on existance of containers
containers.each do |container_name|
  describe docker_container(container_name) do
    it { should exist }
    it { should be_running }
  end
end
