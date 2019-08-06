defmodule RemoteJobs.FileUtil do
  @moduledoc """
    This module is for make file operations: read a text from file, match a text and params, build a pdf
  """

  def get_template_from_static_file(template_src) do
    template = File.stream!(Path.join(:code.priv_dir(:remote_jobs), template_src))
    template.path
    |> File.read()
    |> verify_template.()
  end

  def verify_template do
    fn
      {:error, :enoent} -> "No se encontró template"
      {:ok, content} -> content
    end
  end

  # todo
  def match_file_content(content, attrs), do: EEx.eval_string(content, attrs)

  def build_email do
    fn {src, attrs} ->
      src
      |> get_template_from_static_file()
      |> match_file_content(attrs)
    end
  end

  def build_pdf do
    fn {src, attrs} ->
      template_filled =
      src
      |> get_template_from_static_file()
      |> match_file_content(attrs)

      {:ok, pdf} =
        PdfGenerator.generate(template_filled,
          page_size: "Letter",
          shell_params: ["-T", "0", "-B", "0", "-L", "0", "-R", "0"]
        )

      pdf
    end
  end
end
