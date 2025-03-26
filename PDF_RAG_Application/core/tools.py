from langchain.tools import Tool
from langchain_community.tools import ArxivQueryRun,WikipediaQueryRun, DuckDuckGoSearchRun
from langchain_community.utilities import WikipediaAPIWrapper, ArxivAPIWrapper

def create_pdf_tool(rag_chain):
    def rag_tool_function(input_text: str):
        result = rag_chain.invoke({"input":input_text})
        return result["answer"]
    
    return Tool.from_function(name="PDF_QA_Tool",func=rag_tool_function,description="Use this tool to answer questions from uploaded PDF documents.")

def create_search_tools():
    api_wrapper_wiki = WikipediaAPIWrapper(top_k_results=1,doc_content_chars_max=1000)
    wiki=WikipediaQueryRun(api_wrapper=api_wrapper_wiki)

    api_wrapper_arxiv = ArxivAPIWrapper(top_k_results=1,doc_content_chars_max=1000)
    arxiv=ArxivQueryRun(api_wrapper=api_wrapper_arxiv )

    search = DuckDuckGoSearchRun(name="Search")
    return [search, wiki, arxiv]