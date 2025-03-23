from langchain_groq import ChatGroq


def load_llm(api_key: str):
    return ChatGroq(groq_api_key=api_key, model_name="Llama3-8b-8192")