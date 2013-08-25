task :compile_coffeescript do
  Dir["app/scripts/*.coffee"].each do |coffee_file|
    `node_modules/coffee-script/bin/coffee -o dist/scripts/ -c #{ coffee_file }`
  end
end

task :copy_index do
  FileUtils.copy("app/index.html", "dist/")
end

task :remove_dist do
  FileUtils.rm_rf("dist")
end

task :make_dist do
  FileUtils.mkdir("dist")
end

task :copy_assets do
  FileUtils.mkdir("dist/images")
  Dir["app/images/**/*.png"].each do |file|
    FileUtils.copy(file, "dist/images/")
  end
end

task :copy_css do
  FileUtils.mkdir("dist/styles")
  Dir["app/styles/*.css"].each do |file|
    FileUtils.copy(file, "dist/styles/")
  end
end


task :make_scriptdir do
  FileUtils.mkdir_p("dist/scripts/vendor")
end

task :copy_javascript do
  Dir["app/scripts/*.js"].each do |file|
    FileUtils.copy(file, "dist/scripts/")
  end
end

task :copy_vendor do
  Dir["app/scripts/vendor/*.js"].each do |file|
    FileUtils.copy(file, "dist/scripts/vendor/")
  end
end

task :prepare_scripts => [:make_scriptdir, :copy_javascript, :copy_vendor,  :compile_coffeescript]

task :default => [:remove_dist, :make_dist, :copy_css, :copy_index, :copy_assets, :prepare_scripts]
