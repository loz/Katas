defmodule Issues.CLI do
  @default_count 4

  @moduledoc """
  Handle the command line parsing and the dispatch to the various functions
  that end up generating a table of last _n_ issues in a github project
  """

  def run(argv) do
    argv
     |> parse_args
     |> process
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


  def process(:help) do
    IO.puts """
    usage: issues <user> <project> [count | #{@default_count}]
    """
    System.halt(0)
  end

  def process({user, project, count}) do
    Issues.GithubIssues.fetch(user, project)
    |> decode_response
    |> convert_to_list_of_hashdicts
    |> sort_into_ascending_order
    |> Enum.take(count)
    |> print_table_for_columns ["number", "created_at", "title"]
  end

  def decode_response({:ok, body}), do: Jsonex.decode(body)
  def decode_response({:error, msg}) do
    error = Jsonex.decode(msg)["message"]
    IO.puts "Error fetching from Github: #{error}"
    System.halt(2)
  end

  def convert_to_list_of_hashdicts(lists) do
    Enum.map(lists, HashDict.new(&1))
  end

  def sort_into_ascending_order(list_of_issues) do
    Enum.sort list_of_issues,
      fn i1, i2 -> i1["created_at"] < i2["created_at"] end
  end
end
