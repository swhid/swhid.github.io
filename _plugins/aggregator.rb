# Jekyll plugin for content aggregation
# This plugin aggregates content from external repositories during build

module Jekyll
  class ContentAggregator < Generator
    safe true
    priority :high

    def generate(site)
      return unless site.config['aggregation'] && site.config['aggregation']['enabled']
      
      sources = site.config['aggregation']['sources'] || []
      
      sources.each do |source|
        aggregate_content(site, source)
      end
    end

    private

    def aggregate_content(site, source)
      repo = source['repo']
      ref = source['ref'] || 'master'
      target_dir = source['target_dir']
      
      # For now, we'll create placeholder content
      # In a real implementation, this would clone the repo and copy content
      puts "Aggregating content from #{repo}@#{ref} to #{target_dir}/"
      
      # Create a placeholder page for the aggregated content
      page = Jekyll::Page.new(site, site.source, target_dir, "index.md")
      page.data = {
        'title' => target_dir.capitalize,
        'layout' => 'default',
        'permalink' => "/#{target_dir}/"
      }
      page.content = <<~CONTENT
        # #{target_dir.capitalize}
        
        This content is aggregated from the #{repo} repository.
        
        **Note**: This is a placeholder. In the full implementation, this would contain
        the actual content from the external repository.
        
        Repository: #{repo}  
        Reference: #{ref}
      CONTENT
      
      site.pages << page
    end
  end
end
