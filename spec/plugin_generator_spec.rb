describe "bosh generate plugin" do
  let(:tmpdir) { Dir.mktmpdir }
  subject { Bosh::PluginGenerator::Generator.new(context) }
  after { FileUtils.remove_entry_secure tmpdir }

# Git.global_config
# Git.global_config["user.name"]

  describe 'magic command' do

    context 'creates magic' do 
      before do
        Dir.chdir(tmpdir)
        puts "chdir #{tmpdir}"
        exec("bosh generate plugin magic")
      end

      it 'creates magic folder' do

      end

      it 'creates magic folder' do
        
      end
      
      it 'can run magic' do

      end
      
    end

    context 'creates magic' do 
      before do
        Dir.chdir(tmpdir)
        puts "chdir #{tmpdir}"
        command = <<-CMD 
                         bosh generate plugin magic --email my@email.com              \
                                                    --author Gandalf                  \
                                                    --description "short description" \
                                                    --license mit
CMD
        system(command)
      end

      it 'generates gemspec correctly' do

      end

      it 'creates license file' do
        
      end
      
      it 'can run magic' do

      end
      
    end    
  end
end
