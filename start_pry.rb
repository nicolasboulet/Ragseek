require 'bundler/setup'
require 'dotenv/load'

Bundler.require(:default)

# Charger un fichier Ruby ou définir des méthodes/classes
require_relative 'lib/helpers'  # Charge un fichier Ruby relatif à ce script
require_relative 'schema/schema_person'  # Charge un fichier Ruby relatif à ce script

# ou
#load 'path/to/another_file.rb'  # Charge un fichier Ruby, même s'il a déjà été chargé

llm = Langchain::LLM::Ollama.new(url: ENV["OLLAMA_URL"], default_options: {})

parser = Langchain::OutputParsers::StructuredOutputParser.from_json_schema($json_schema)
prompt = Langchain::Prompt::PromptTemplate.new(
    template: "Generate details of a fictional character.\n{format_instructions}\nCharacter description: {description}", 
    input_variables: ["description", "format_instructions"]
    )
prompt_text = prompt.format(description: "Mario from mario bros", format_instructions: parser.get_format_instructions)

llm_response = llm.chat(messages: [{role: "user", content: prompt_text}], model: "llama3.1") do |resp|
    print resp.chat_completion
    resp.chat_completion
end

# llm_response.chat_completion
# parser.parse(llm_response.chat_completion)

binding.pry


