defmodule RemoteJobs.ParserUtil do

  def resume_tags() do
    fn
      [tag] -> tag
      tags -> Enum.join(tags, ",")
    end
  end

	def get_tags(), do: fn (tags) -> String.split(tags, ",") end

end
