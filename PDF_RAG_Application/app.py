import streamlit as st
import os
from dotenv import load_dotenv

from core.llm import load_llm
from core.embeddings import load_embeddings
from core.retriever import create_retriever, create_contextual_retriever
from core.qa_chain import create_rag_chain
from core.memory import wrap_chain_with_memory, get_session_history
from utils.pdf_loader import load_pdf_from_upload
from core.memory import save_session_history

# Load environment variables
load_dotenv()
os.environ['HF_TOKEN'] = os.getenv("HF_TOKEN")

# Streamlit App UI
st.set_page_config(page_title="Conversational PDF Q&A", layout="wide")
st.title("🧠 Conversational RAG with PDF Uploads and Chat History")
st.write("Upload PDFs and ask natural language questions about their content.")

# Session state initialization
if 'store' not in st.session_state:
    st.session_state.store = {}

# GROQ API Key Input
api_key = st.text_input("🔐 Enter your GROQ API Key:", type="password")

if api_key:
    session_id = st.text_input("💬 Session ID", value="default_session")

    # Initialize LLM and Embeddings
    llm = load_llm(api_key)
    embeddings = load_embeddings()

    # File uploader
    uploaded_files = st.file_uploader("📄 Upload one or more PDF files", type="pdf", accept_multiple_files=True)

    if uploaded_files:
        # Load and parse all uploaded PDFs
        documents = []
        for upload_file in uploaded_files:
            docs = load_pdf_from_upload(upload_file)
            documents.extend(docs)

        # Build retriever and contextual retriever
        retriever = create_retriever(documents, embeddings)
        history_aware_retriever = create_contextual_retriever(llm, retriever)

        # Build RAG chain with chat memory
        rag_chain = create_rag_chain(llm, history_aware_retriever)
        conversational_rag_chain = wrap_chain_with_memory(rag_chain, st.session_state.store)

        # User query input
        user_input = st.text_input("❓ Ask a question from the PDF content:")

        if user_input:
            # Get chat history and invoke chain
            session_history = get_session_history(session_id, st.session_state.store)
            response = conversational_rag_chain.invoke(
                {"input": user_input},
                config={"configurable": {"session_id": session_id}}
            )
            save_session_history(session_id, session_history)
            # Display the result
            st.markdown(f"**🤖 Assistant:** {response['answer']}")

            # Optionally show history
            with st.expander("🕘 Chat History"):
                for msg in session_history.messages:
                    speaker = "🧑 You" if msg.type == "human" else "🤖 Bot"
                    st.markdown(f"**{speaker}:** {msg.content}")

else:
    st.warning("Please enter your GROQ API key to continue.")
