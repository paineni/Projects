from langchain_community.document_loaders import PyPDFLoader

def load_pdf_from_upload(upload_file):
    temp_path = "./temp.pdf"
    with open(temp_path, "wb") as f:
        f.write(upload_file.getvalue())
    loader = PyPDFLoader(temp_path)
    return loader.load()
