from langchain_groq import ChatGroq

def load_llm(api_key: str, model_name: str = "Llama3-8b-8192"):
    return ChatGroq(groq_api_key=api_key, model_name=model_name)
