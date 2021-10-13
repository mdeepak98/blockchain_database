begin
XclusiveLedgerService::Initializer.init()
rescue Exception => error
  puts "Warning: Error while initializing blockchain - #{error.message}"
end