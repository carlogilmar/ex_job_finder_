defmodule RemoteJobs.FileUtil do
  @moduledoc """
    This module is for make file operations: read a text from file, match a text and params, build a pdf
  """

  defp get_template(template_src) do
    template = File.stream!(Path.join(:code.priv_dir(:remote_jobs), template_src))
    {:ok, content} = File.read(template.path)
    content
  end

  def build_email do
    fn {src, attrs} ->
      template_content = get_template(src)
      EEx.eval_string(template_content, attrs)
    end
  end

  def build_pdf do
    fn {src, attrs} ->
      content = get_template(src)
      template_filled = EEx.eval_string(content, attrs)

      {:ok, pdf} =
        PdfGenerator.generate(template_filled,
          page_size: "Letter",
          shell_params: ["-T", "0", "-B", "0", "-L", "0", "-R", "0"]
        )

      pdf
    end
  end
end
