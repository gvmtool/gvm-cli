Feature: Verify checksums

	Background:
		Given the internet is reachable
		And an initialised environment

	Scenario: Install a specific Candidate with a valid SHA-256 checksum
		Given the system is bootstrapped
		And the candidate "grails" version "1.3.9" is available for download with checksum "1f9234c8e622ec46d33883ea45b39ede768b92d478fe08f6952548247f7fbb65" using algorithm "SHA-256"
		When I enter "sdk install grails 1.3.9"
		Then I see "Done installing!"
		And the candidate "grails" version "1.3.9" is installed
		And the response headers file is created for candidate "grails" and version "1.3.9"
		And the exit code is 0

	Scenario: Install a specific Candidate with a valid SHA1 checksum
		Given the system is bootstrapped
		And the candidate "grails" version "1.3.9" is available for download with checksum "c68e386a6deec9fc4c1e18df21f92739ba2ab36e" using algorithm "SHA1"
		When I enter "sdk install grails 1.3.9"
		Then I see "Done installing!"
		And the candidate "grails" version "1.3.9" is installed
		And the response headers file is created for candidate "grails" and version "1.3.9"
		And the exit code is 0

	Scenario: Install a specific Candidate with a valid md5 checksum
		Given the system is bootstrapped
		And the candidate "grails" version "1.3.9" is available for download with checksum "1e87a7d982a2f41da96fdec289908552" using algorithm "MD5"
		When I enter "sdk install grails 1.3.9"
		Then I see "Done installing!"
		And the candidate "grails" version "1.3.9" is installed
		And the response headers file is created for candidate "grails" and version "1.3.9"
		And the exit code is 0

	Scenario: If an unknown algorithm is used it should not fail
		Given the system is bootstrapped
		And the candidate "grails" version "1.3.9" is available for download with checksum "abc-checksum-00000" using algorithm "ABC"
		When I enter "sdk install grails 1.3.9"
		Then I see "Done installing!"
		And the candidate "grails" version "1.3.9" is installed
		And the response headers file is created for candidate "grails" and version "1.3.9"
		And the exit code is 0

	Scenario: Abort installation on download of a corrupt Candidate with invalid SHA
		Given the system is bootstrapped
		And the candidate "grails" version "1.3.9" is available for download with checksum "c68e386a6deec9fc4c1e18df21f927000000000e" using algorithm "SHA-256"
		When I enter "sdk install grails 1.3.9"
		Then I see "Stop! An invalid checksum was detected and the archive removed! Please try re-installing."
		And the candidate "grails" version "1.3.9" is not installed
		And the archive for candidate "grails" version "1.3.9" is removed
		And the exit code is 1
