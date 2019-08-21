defmodule RemoteJobs.NewsletterOperator do
  @moduledoc """
  This module is for send the neswletter
  """
  use Rop
  require Logger
  alias RemoteJobs.EmailManager
  alias RemoteJobs.JobOperator
  alias RemoteJobs.SuscriptorOperator

  def get_jobs do
    JobOperator.find_all_paid_jobs()
    |> validate_empty_list.(:jobs)
  end

  def get_suscriptors(job_section) do
    SuscriptorOperator.find_all()
    |> validate_empty_list.(job_section)
  end

  def validate_process do
    fn
      {:error, msg} -> Logger.warn(" Newsletter Operator Error :: #{msg} ::")
      _msg -> Logger.info(" Newsletter Operator :: Emails sended done! ::")
    end
  end

  def validate_empty_list do
    fn
      [], :jobs -> {:error, "There isn't jobs for send newsletter"}
      jobs, :jobs -> {:ok, jobs}
      [], _jobs -> {:error, "There isn't suscribers for send newsletter"}
      suscriptors, job_section ->  {:ok, {suscriptors, job_section}}
    end
  end

  def build_job_section(jobs) do
    job_attrs =
      for job <- jobs do
        """
        <li><b>#{job.position}</b><small> #{job.primary_tag} | #{job.location_restricted} | #{job.company_name}</small> </li>
        """
      end
    Enum.join(["<ul>", job_attrs, "</ul>\n"], "")
  end

end
