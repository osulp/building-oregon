namespace :jetty do
  desc "Configures Jetty"
  task :config do
    Rake:Task["jetty:stop"].invoke
    sleep(2)
    FileUtils.rm_rf "jetty/solr/blacklight-core-test", :verbose => true
    FileUtils.mkdir_p "jetty/solr/blacklight-core-test", :verbose => true
    FileUtils.cp_r "jetty/solr/blacklight-core/.", "jetty/solr/blacklight-core-test/", :verbose => true
    FileUtils.rm_rf "jetty/solr/blacklight-core-test/data", :verbose => true
    FileUtils.cp "config/solr/solr.xml", "jetty/solr", :verbose => true
    FileList['config/solr/conf/*'].each do |f|
      cp("#{f}","jetty/solr/blacklight-core/conf/", :verbose => true)
      cp("#{f}","jetty/solr/blacklight-core-test/conf/", :verbose => true)
    end
    Rake::Task["jetty:start"].invoke
  end
end
