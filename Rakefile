def run(cmd)
  puts cmd
  %x(#{cmd})
end

def build_project
  run "middleman build"
end

desc "Builds the project and runs pngnq"
task :build do
  run "rm -rf build/"
  build_project
  run "pngnq -f -e .png build/images/*"
  # run "mv build/images/ build/images-orig/"
  # run "pngnq -d build/images/ build/images-orig/"
end
