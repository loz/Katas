defmodule UsingModules do
  def convert_float_to_string(f) do
    :io.format("~.2f", [f])
  end

  def get_env(e), do: System.get_env(e)

  def ext(name), do: Path.extname(name)

  def cwd, do: System.cwd
end
