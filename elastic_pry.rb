require 'bundler/setup'
require 'dotenv/load'

Bundler.require(:default)

require_relative 'lib/helpers'  # Charge un fichier Ruby relatif à ce script

llm = Langchain::LLM::Ollama.new(url: ENV["OLLAMA_URL"], default_options: {
    
})

es = Langchain::Vectorsearch::Elasticsearch.new(
  url: ENV["ELASTICSEARCH_URL"],
  index_name: "test",
  llm: llm,
  es_options: {
    transport_options: {ssl: {verify: false}}
  }
)



binding.pry


