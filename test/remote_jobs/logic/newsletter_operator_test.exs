defmodule RemoteJobs.NewsletterOperatorTest do
  use ExUnit.Case
  alias RemoteJobs.NewsletterOperator

  test "Build job section" do
    jobs = get_fake_jobs()
    job_section = NewsletterOperator.build_job_section(jobs)
    expected_section = """
    <ul><li><b>Developer</b><small> elixir | Mexico City | Codigo Ambar</small> </li>
    <li><b>Developer</b><small> elixir | Mexico City | Codigo Ambar</small> </li>
    <li><b>Developer</b><small> elixir | Mexico City | Codigo Ambar</small> </li>\n</ul>
    """
    assert job_section == expected_section
  end

  defp get_fake_jobs do
    [
      %{position: "Developer", primary_tag: "elixir", location_restricted: "Mexico City", company_name: "Codigo Ambar"},
      %{position: "Developer", primary_tag: "elixir", location_restricted: "Mexico City", company_name: "Codigo Ambar"},
      %{position: "Developer", primary_tag: "elixir", location_restricted: "Mexico City", company_name: "Codigo Ambar"}
    ]
  end
end
