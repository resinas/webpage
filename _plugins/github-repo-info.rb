# Fetches metadata (description, language, stars, forks) for the repositories
# listed in _data/repositories.yml at build time, so the repositories page can
# render its cards as plain HTML instead of relying on an external image
# service. Results are exposed as site.data.repo_info["owner/repo"].
#
# Set GITHUB_TOKEN to avoid GitHub's unauthenticated rate limit (60 req/hour).
# If a request fails, the card falls back to showing just the repository name.

require "json"
require "net/http"

module Jekyll
  class GitHubRepoInfoGenerator < Generator
    safe true
    priority :highest

    def generate(site)
      repos = Array(site.data.dig("repositories", "github_repos")).map { |e| e.is_a?(Hash) ? e["repo"] : e }.compact
      site.data["repo_info"] = repos.to_h { |repo| [repo, fetch(repo)] }.compact
    end

    private

    def fetch(repo)
      uri = URI("https://api.github.com/repos/#{repo}")
      request = Net::HTTP::Get.new(uri)
      request["Accept"] = "application/vnd.github+json"
      request["User-Agent"] = "jekyll-github-repo-info"
      token = ENV["GITHUB_TOKEN"]
      request["Authorization"] = "Bearer #{token}" if token && !token.empty?

      response = Net::HTTP.start(uri.host, uri.port, use_ssl: true, open_timeout: 10, read_timeout: 10) do |http|
        http.request(request)
      end

      unless response.is_a?(Net::HTTPSuccess)
        Jekyll.logger.warn "GitHub repo info:", "#{repo}: HTTP #{response.code}"
        return nil
      end

      data = JSON.parse(response.body)
      {
        "description" => data["description"],
        "language" => data["language"],
        "stars" => data["stargazers_count"],
        "forks" => data["forks_count"],
        "archived" => data["archived"],
      }
    rescue StandardError => e
      Jekyll.logger.warn "GitHub repo info:", "#{repo}: #{e.message}"
      nil
    end
  end
end
