Feature: "Hello Trema!" example
  Background:
    Given a file named "trema.conf" with:
    """
    vswitch { datapath_id '0xabc' }
    """

  @sudo
  Scenario: Run
    When I run `trema run ../../lib/hello_trema.rb -c trema.conf -p . -l . -s . -- foo bar baz` interactively
    And I wait for stdout to contain "Hello 0xabc!"
    And I run `trema killall`
    And the stdout should contain:
    """
    Trema started (args = ["foo", "bar", "baz"]).
    Hello 0xabc!
    """
    And a file named "HelloTrema.log" should exist
    And the file "HelloTrema.log" should contain:
    """
    Trema started (args = ["foo", "bar", "baz"]).
    """
    And the file "HelloTrema.log" should contain:
    """
    Hello 0xabc!
    """

  @sudo
  Scenario: Run as a daemon
    When I run `trema run ../../lib/hello_trema.rb -c trema.conf -d -p . -l . -s . -- foo bar baz`
    And I run `sleep 5`
    Then a file named "HelloTrema.log" should exist
    And the file "HelloTrema.log" should contain:
    """
    Trema started (args = ["foo", "bar", "baz"]).
    """
    And the file "HelloTrema.log" should contain:
    """
    Hello 0xabc!
    """
