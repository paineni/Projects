import validators
import streamlit as st
from langchain.prompts import PromptTemplate
from langchain_groq import ChatGroq
from langchain.chains.summarize import load_summarize_chain
from langchain_community.document_loaders import  UnstructuredURLLoader
from youtube_transcript_api import YouTubeTranscriptApi
from langchain.docstore.document import Document

# Page config and styling
st.set_page_config(page_title="🧠 LangChain Summarizer", page_icon="📄", layout="centered")
st.markdown("""
    <style>
        .main { background-color: #f0f2f6; }
        h1, h3 { color: #d62828; }
        .stButton>button {
            background-color: #d62828;
            color: white;
            font-weight: bold;
        }
    </style>
""", unsafe_allow_html=True)

# YouTube logo + header
st.markdown("""
    <div style="text-align: center;">
        <img src="https://upload.wikimedia.org/wikipedia/commons/b/b8/YouTube_Logo_2017.svg" alt="YouTube Logo" width="200"/>
    </div>
""", unsafe_allow_html=True)

st.title("🧠 LangChain: Smart Summarizer for YT & Web")
st.markdown("<p style='text-align: center; font-size: 16px; color: grey;'>Summarize YouTube videos or web content into clean bullet-point notes with headings.</p>", unsafe_allow_html=True)

# Sidebar inputs
with st.sidebar:
    st.header("🔐 API & Input")
    groq_api_key = st.text_input("Enter your Groq API Key:", type="password")
    st.markdown("🚀 Using `deepseek-r1-distill-llama-70b` model via Groq.")
    st.write("---")

# URL input
st.subheader("🌐 Paste the YouTube or Website URL")
generic_url = st.text_input("URL", label_visibility="collapsed", placeholder="e.g. https://www.youtube.com/watch?v=xyz")

# Prompt template
prompt_template = """
You are a helpful assistant. Read the following content and write a clear, concise summary using only bullet points.

🔹 Structure the summary with main topic headings (bold or uppercase only).
🔹 For each main topic, add relevant sub-points using indented bullet points.
🔹 Do NOT include any internal thinking, explanation, or reasoning steps.
🔹 Do NOT use markdown headers (#, ###) or horizontal rules (---).
🔹 Keep the tone informative and professional.
🔹 Translate or keep any foreign terms in English unless contextually relevant.

Only return the summary.

CONTENT:
{text}
"""
# --- Transcript Extraction Function ---
def get_transcript(video_url):
    try:
        video_id = video_url.split("v=")[-1].split("&")[0]
        transcript = YouTubeTranscriptApi.get_transcript(video_id)
        full_text = " ".join([entry["text"] for entry in transcript])
        return full_text
    except Exception as e:
        return None
    
# On button click
if st.button("🔍 Summarize Content"):
    if not groq_api_key.strip() or not generic_url.strip():
        st.error("❗ Please provide both the API key and a valid URL.")
    elif not validators.url(generic_url):
        st.error("⚠️ Invalid URL. Please double-check and try again.")
    else:
        try:
            st.info("📥 Loading content, please wait...")
            with st.spinner("⏳ Summarizing..."):

                # Load content from YouTube or website
                if "youtube.com" in generic_url:
                    transcript_text = get_transcript(generic_url)
                    if not transcript_text:
                        st.warning("⚠️ Couldn't fetch transcript. It may be disabled for this video.")
                        st.stop()
                    docs = [Document(page_content=transcript_text)]
                else:
                    loader = UnstructuredURLLoader(
                        urls=[generic_url],
                        ssl_verify=False,
                        headers={
                            "User-Agent": "Mozilla/5.0 (Macintosh; Intel Mac OS X 13_5_1) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/116.0.0.0 Safari/537.36"
                        }
                    )
                    docs = loader.load()

                # LLM + summarization chain
                llm = ChatGroq(groq_api_key=groq_api_key, model_name="deepseek-r1-distill-qwen-32b")
                chain = load_summarize_chain(llm, chain_type="stuff", prompt=PromptTemplate(template=prompt_template, input_variables=["text"]))
                output_summary = chain.invoke(docs)

                # Output display
                st.success("✅ Summary Generated Successfully!")
                st.markdown("### 📝 Summary Output")
                st.markdown(output_summary['output_text'], unsafe_allow_html=False)

        except Exception as e:
            import traceback
            st.error("🚫 An error occurred during summarization.")
            st.text(traceback.format_exc())

