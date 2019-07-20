defmodule RemoteJobs.BuilderUtil do

  defp get_template(template_src) do
    template = File.stream!(Path.join(:code.priv_dir(:remote_jobs), template_src))
    {:ok, content} = File.read(template.path)
    content
  end

  def build_email(src) do
    template_content = get_template(src)
    EEx.eval_string( template_content, [company_name: "RemoteJobs"])
  end

  def build_pdf(template_src) do
    content = get_template(template_src)
    {:ok, pdf} = PdfGenerator.generate(content, page_size: "Letter", shell_params: [ "-T", "0", "-B", "0", "-L", "0", "-R", "0"])
    pdf
  end

end
