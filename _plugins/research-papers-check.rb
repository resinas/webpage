# Warns at build time about keys in _data/research_papers.yml that do not
# exist in the scholar bibliography (_bibliography/papers.bib). Without this,
# a mistyped or missing key would silently drop a paper from the research page.

require "set"

module Jekyll
  class ResearchPapersCheck < Generator
    safe true
    priority :low

    def generate(site)
      lines = site.data["research_papers"]
      return unless lines.is_a?(Hash)

      scholar = site.config["scholar"] || {}
      source = scholar.fetch("source", "_bibliography").sub(%r{\A/}, "")
      bib_path = File.join(site.source, source, scholar.fetch("bibliography", "papers.bib"))
      return unless File.exist?(bib_path)

      bib_keys = File.read(bib_path).scan(/^@\w+\{([^,\s]+),/).flatten.to_set

      lines.each do |line, keys|
        Array(keys).each do |key|
          next if bib_keys.include?(key)

          Jekyll.logger.warn "Research papers:", "#{line}: key #{key} not found in #{File.basename(bib_path)}"
        end
      end
    end
  end
end
