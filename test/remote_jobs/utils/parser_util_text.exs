defmodule RemoteJobs.ParserUtilTest do
  use ExUnit.Case
  alias RemoteJobs.ParserUtil

  test "Get the tag as string" do
    tags1 = ["backend", "frontend", "ux", "ui"]
    tags2 = ["primary"]
    tags1 = ParserUtil.resume_tags().(tags1)
    tags2 = ParserUtil.resume_tags().(tags2)
    assert tags1 == "backend,frontend,ux,ui"
    assert tags2 == "primary"
  end

  test "Get the tags from string" do
    tag1 = "backend,frontend,ux,ui"
    tag2 = "primary"
    tags1 = ParserUtil.get_tags().(tag1)
    tags2 = ParserUtil.get_tags().(tag2)
    assert tags1 == ["backend", "frontend", "ux", "ui"]
    assert tags2 == ["primary"]
  end
end
