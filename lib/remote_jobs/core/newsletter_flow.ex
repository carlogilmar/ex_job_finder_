defmodule RemoteJobs.NewsletterFlow do
  @moduledoc """
  This module is for send the neswletter

  This module is using Railway through ROP macro

  Review https://hexdocs.pm/rop/readme.html for more details

  Rop pipe: >>>
  Rop binding: bind(fun)
  """
  use Rop
  require Logger
  alias RemoteJobs.EmailManager
  alias RemoteJobs.NewsletterOperator

  def send_newsletter do
    Logger.info(" Newsletter Operator :: Starting cron job...")
    send_emails |> NewsletterOperator.validate_process.()
  end

  defp send_emails do
    NewsletterOperator.get_jobs()
    >>> bind(NewsletterOperator.build_job_section())
    >>> NewsletterOperator.get_suscriptors()
    >>> bind(EmailManager.send_newsletter())
  end

end
