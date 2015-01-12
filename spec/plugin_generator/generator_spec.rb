describe Bosh::PluginGenerator::Generator do
  let(:context) { { people: ['you', 'me'] } }
  let(:tmpdir) { Dir.mktmpdir }
  let(:target) { File.join(tmpdir, 'subfolder-1', 'subfolder-2', 'result.txt') }
  let(:generator) { Bosh::PluginGenerator::Generator.new(context) }
  after { FileUtils.remove_entry_secure tmpdir }

  describe '#generate' do
    before do
      generator.generate(asset_file('simple-template.txt'), target)
    end

    context 'simple template' do 

      it 'creates file with folder' do
        expect(File).to exist(target)
      end
      
      it 'creates renders ERB' do
        expect(File.read(target)).to match(/you, me/)
      end
      
    end
  end
end