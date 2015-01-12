describe Bosh::PluginGenerator::Helpers do
  subject { Object.new.extend(Bosh::PluginGenerator::Helpers) }
  let(:tmpdir) { Dir.mktmpdir }

  describe '#extract_options' do
    it 'takes accepts email, author and license options' do
    end

    it 'takes email and author from Git as a default values' do
    end
      
    it 'license is optional parameter' do
    end
  end

  describe '#generate_files' do
    it 'creates class for command' do
    end

    it 'creates helpers' do
    end

    it 'creates gemsec' do
    end

    it 'creates spec files' do
    end
  end  

  describe '#generate' do
    it 'exists' do
    end
  end

end