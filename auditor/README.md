## Installation
Add this line to your application's Gemfile:

```ruby
gem 'auditor'
```

And then execute:
```bash
$ bundle
```

Or install it yourself as:
```bash
$ gem install auditor
```

Install the migrations:
```bash
$ ruby auditor:install:migrations
```

Then run the migrations:
```bash
$ rails db:migrate
```

Mount the Engine to the Rails Application:
```ruby
mount Auditor::Engine, at: '/', as: 'auditor'
```

Add the following file to the Rails Application Initializer directory as ```auditor.rb```:
```ruby
module Auditor
	require("#{Auditor::Engine.root.join('app','controllers','auditor','audits_controller.rb').to_s}")

	# ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ #
	# Configure mapping between subject and decorator #
	# ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ #
	class AuditsController < ApplicationController
		def get_options

			audit_options = {
				"AppConfig" => AppConfigReport,
				"ExampleSubject" => ExampleSubjectReport
			}

		end
	end

	# ~~~~~~~~~~ #
	# Decorators #
	# ~~~~~~~~~~ #

	# Replace the class name and pushed string to subject that is stored in the database.
	class ExampleSubjectReport < ReportDecorator
		def get_report
			@original_report.search_subjects.push("ExampleSubject")
			return @original_report.get_report
		end
	end
end
```

The ```auditor.rb``` initializer can then be modified to configure the Gem.

## License
The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).
