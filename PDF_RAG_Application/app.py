import streamlit as st
import os
from dotenv import load_dotenv

# === Import core modules ===
from core.llm import load_llm
from core.embeddings import load_embeddings
from core.retriever import create_retriever, create_contextual_retriever
from core.qa_chain import create_rag_chain
from utils.pdf_loader import load_pdf_from_upload
from core.tools import create_pdf_tool, create_search_tools

# === LangChain agent and streaming ===
from langchain.agents import initialize_agent, AgentType
from langchain.callbacks import StreamlitCallbackHandler

# === Load environment variables ===
load_dotenv()
os.environ['HF_TOKEN'] = os.getenv("HF_TOKEN")

# === Streamlit Page Config ===
st.set_page_config(page_title="Conversational PDF Q&A", layout="wide")
st.title("🧠 Conversational RAG with PDF Uploads and Web Search")
st.write("Upload PDFs and ask natural language questions about their content, or search the web.")

# === Session state initialization for in-memory cache ===
if 'store' not in st.session_state:
    st.session_state.store = {}

# === Sidebar: API Key + Reset Button ===
st.sidebar.title("Settings")
api_key = st.sidebar.text_input("🔐 Enter your GROQ API Key:", type="password")
model_name = st.sidebar.selectbox(
    "🧠 Choose LLM model",
    options=["Llama3-8b-8192", "deepseek-r1-distill-llama-70b"],
    index=0
)


if st.sidebar.button("🔁 Reset Chat/ Start chat"):
    st.session_state.messages = [
        {"role": "assistant", "content": "Hi, I'm a chatbot who can search your PDFs or the web. Ask me anything!"}
    ]

# === Only proceed if API key is provided ===
if api_key:
    session_id = st.text_input("💬 Session ID", value="default_session")

    # === Initialize LLM and Embeddings ===
    llm = load_llm(api_key, model_name)
    st.info(f"Using model: `{model_name}`")

    embeddings = load_embeddings()

    # === File Upload: Accept PDFs ===
    uploaded_files = st.file_uploader("📄 Upload one or more PDF files", type="pdf", accept_multiple_files=True)

    # === Proceed only if files are uploaded ===
    if uploaded_files:
        # Step 1: Load and parse PDFs
        documents = []
        for upload_file in uploaded_files:
            docs = load_pdf_from_upload(upload_file)
            documents.extend(docs)

        # Step 2: Create retriever and context-aware retriever
        retriever = create_retriever(documents, embeddings)
        history_aware_retriever = create_contextual_retriever(llm, retriever)

        # Step 3: Create RAG chain from PDF documents
        rag_chain = create_rag_chain(llm, history_aware_retriever)

        # Step 4: Wrap RAG chain as a tool and load search tools
        pdf_tool = create_pdf_tool(rag_chain)
        search_tools = create_search_tools()
        tools = search_tools + [pdf_tool]

        # Step 5: Create tool-using agent (ReAct agent)
        agent = initialize_agent(
            tools,
            llm,
            agent=AgentType.ZERO_SHOT_REACT_DESCRIPTION,
            handle_parsing_errors=True
        )

        # === Initialize chat message history ===
        if "messages" not in st.session_state:
            st.session_state.messages = [
                {"role": "assistant", "content": "Hi, I'm a chatbot who can search your PDFs or the web. Ask me anything!"}
            ]

        # === Display all previous messages ===
        for msg in st.session_state.messages:
            with st.chat_message(msg["role"]):
                st.markdown(msg["content"])

        # === Accept new user input ===
        user_input = st.chat_input("Ask me something...")

        if user_input:
            # Display user message
            st.session_state.messages.append({"role": "user", "content": user_input})
            with st.chat_message("user"):
                st.markdown(user_input)

            # Run the agent with callback to stream thought process
            with st.chat_message("assistant"):
                st_cb = StreamlitCallbackHandler(st.container(), expand_new_thoughts=False)
                response = agent.run(user_input, callbacks=[st_cb])
                st.markdown(f"**🤖 Assistant:** {response}")
                st.session_state.messages.append({"role": "assistant", "content": response})

else:
    st.warning("Please enter your GROQ API key to continue.")

# # === OPTIONAL: Conversational RAG Chain (Memory-Enabled) ===
# """
# # Uncomment below lines if you want to use Conversational RAG Chain instead of Agent

# from core.memory import wrap_chain_with_memory, get_session_history, save_session_history

# # Wrap chain with memory support
# conversational_rag_chain = wrap_chain_with_memory(rag_chain, st.session_state.store)

# if user_input:
#     session_history = get_session_history(session_id, st.session_state.store)
#     response = conversational_rag_chain.invoke(
#         {"input": user_input},
#         config={"configurable": {"session_id": session_id}}
#     )
#     save_session_history(session_id, session_history)
#     st.markdown(f"**🤖 Assistant:** {response['answer']}")
# """
