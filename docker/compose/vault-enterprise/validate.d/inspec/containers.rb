%w(vault-enterprise0 vault-enterprise1).each do |container_name|
  describe docker_container(container_name) do
    it { should exist }
    it { should be_running }
  end
end
