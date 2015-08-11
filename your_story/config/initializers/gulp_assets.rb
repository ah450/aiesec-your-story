pid = Process.spawn(Rails.configuration.gulp.command, 
  {chdir: Rails.configuration.gulp.directory})
Process.waitpid(pid)
listener = Listen.to(File.join(Rails.configuration.gulp.directory, 'src')) do 
  pid = Process.spawn(Rails.configuration.gulp.command, 
    {chdir: Rails.configuration.gulp.directory})
  Process.waitpid(pid)
end

listener.start