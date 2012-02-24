Gem::Specification.new do |s|
  s.name = %q{rumbster}
  s.version = "1.0.0"
  s.date = %q{2007-10-22}
  s.summary = %q{Rumbster is a simple SMTP server that receives email sent from a SMTP client. Received emails are published to observers that have registered with Rumbster. There are currently two observers; FileMailObserver and MailMessageObserver.}
  s.email = %q{adam@esterlines.com}
  s.homepage = %q{http://rumbster.rubyforge.org/}
  s.rubyforge_project = %q{rumbster}
  s.description = %q{Rumbster is a simple SMTP server that receives email sent from a SMTP client. Received emails are published to observers that have registered with Rumbster. There are currently two observers; FileMailObserver and MailMessageObserver.}
  s.has_rdoc = true
  s.authors = ["Adam Esterline"]
  s.files = ["lib/message_observers.rb", "lib/rumbster.rb", "lib/smtp_protocol.rb", "lib/smtp_states.rb", "test/test_message_observers.rb", "test/test_rumbster.rb", "test/test_smtp_protocol.rb", "test/test_smtp_states.rb", "LICENSE.txt", "Rakefile", "README.rdoc"]
  s.test_files = ["test/test_message_observers.rb", "test/test_rumbster.rb", "test/test_smtp_protocol.rb", "test/test_smtp_states.rb"]
  s.rdoc_options = ["--title", "rumbster Documentation", "--main", "README.rdoc", "-q"]
  s.extra_rdoc_files = ["README.rdoc"]
end
