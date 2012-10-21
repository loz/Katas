class FolderHTTPAdapter
  SAMPLES = File.expand_path("../sample/", __FILE__)
  def initialize(request); end
  def get(request)
    file = request.url.to_s.gsub "https://github.com/", ""
    headers = {}
    code = 200
    file = File.expand_path(file, SAMPLES)
    body = File.read(file)
    HTTPI::Response.new code, headers, body
  end
end
