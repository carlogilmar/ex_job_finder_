defmodule RemoteJobs.ParserUtil do
  @moduledoc """
    This module is for make operations with strings and characters
  """

  def resume_tags do
    fn
      [tag] -> tag
      tags -> Enum.join(tags, ",")
    end
  end

  def get_tags, do: fn tags -> String.split(tags, ",") end
end
