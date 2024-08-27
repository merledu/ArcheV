# from .frontend import expose
import webview
if __name__ == '__main__':
    # Create the main window
    window = webview.create_window(
        title='ArcheV',
        url='frontend/web/index.html',
        width=1200,
        height=600,
        resizable=False,
    )    
    # Start the webview
    webview.start(window)