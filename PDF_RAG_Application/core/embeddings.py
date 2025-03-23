from langchain_huggingface import HuggingFaceEmbeddings

def load_embeddings():
    return HuggingFaceEmbeddings(model_name="all-MiniLM-L6-v2")
