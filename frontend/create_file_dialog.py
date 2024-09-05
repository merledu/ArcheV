import webview

from globals import window

def open_file_dialog():
    result = window.create_file_dialog(
        webview.OPEN_DIALOG
    )
    print(result)
    return result