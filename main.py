import webview

from globals import window
from frontend.expose import expose

    
if __name__ == '__main__':
    webview.start(expose, window)

