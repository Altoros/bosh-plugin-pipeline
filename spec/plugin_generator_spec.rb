describe "bosh generate plugin" do

  describe 'magic command' do

    before(:context) do
      @current_dir = Dir.pwd
      @tmpdir = Dir.mktmpdir
      Dir.chdir(@tmpdir)
    end

    after(:context) do
      Dir.chdir(@current_dir)
      FileUtils.remove_entry_secure(@tmpdir)
    end

    context "without parameters and 'bosh-' preffix" do
      let(:plugin_folder) { File.join(Dir.pwd, 'magic') }

      before(:all) do
        system("bosh generate plugin magic >&2")
      end

      before { Git.stub(:global_config) { { "user.name" => "git user", "user.email" => "git-user@email.com" } } }

      it "creates gem with 'bosh-' prefix" do
        gemspec_file = File.join(plugin_folder, 'bosh-magic.gemspec')
        expect(File).to exist(gemspec_file)
        expect(File.read(gemspec_file)).to match(/bosh-magic/)
      end

      it 'generates gemspec with email from Git setup' do
        expect(File.read("#{plugin_folder}/bosh-magic.gemspec")).to match(/git-user@email.com/)
        expect(File.read("#{plugin_folder}/magic.gemspec")).to match(/git user/)
      end

      it 'has no license file' do
        expect(File).not_to exist(File.join(plugin_folder, 'LICENSE'))
      end

      it 'can perform magic' do
        puts "11111"
      end
      
    end

    context "with parameters, license and 'bosh-' prefix" do
      let(:plugin_folder) { File.join(Dir.pwd, 'bosh-magic') }

      before(:all) do
        command = <<-CMD 
                         bosh generate plugin bosh-magic --email=gandalf@email.com \
                                                         --author=Gandalf          \
                                                         --license=mit
CMD
        system(command)
      end

      it 'creates folder with the name specified as plugin a name' do
        expect(File).to exist(plugin_folder)
      end

      it 'creates gem with \'bosh-\' prefix' do
        gemspec_file = File.join(plugin_folder, 'bosh-magic.gemspec')
        expect(File).to exist(gemspec_file)
        expect(File.read(gemspec_file)).to match(/bosh-magic/)
      end

      it 'generates gemspec with correct email' do
        expect(File.read("#{plugin_folder}/bosh-magic.gemspec")).to match(/gandalf@email.com/)
      end

      it 'creates license file' do
        expect(File).to exist(File.join(plugin_folder, 'LICENSE'))
      end
      
      it 'can perform magic' do
        puts "22222"
      end
      
    end    
  end
end
