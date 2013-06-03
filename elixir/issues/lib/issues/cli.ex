defmodule Issues.CLI do
  @default_count 4

  @moduledoc """
  Handle the command line parsing and the dispatch to the various functions
  that end up generating a table of last _n_ issues in a github project
  """

  def run(argv) do
    parse_args(argv)
  end

  @doc """
  `argv` can be -h or --help, which returns :help.

  Otherwise it is a github user name, project name, and (optionally) the
  number of entries to format

  Return a tuple of `{ user, project, count }`, or `:help` if help was given
  """
  def parse_args(argv) do
    _parse OptionParser.parse(argv, switches: [ help: :boolean],
                                     aliases: [ h: :help ])
  end

  def _parse({_, [user, project, count]}), do: {user, project, binary_to_integer(count)}
  def _parse({_, [user, project]}), do: {user, project, @default_count}
  def _parse(_), do: :help
end
