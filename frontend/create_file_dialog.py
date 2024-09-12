import webview

from globals import window


def open_file_dialog():
    return window.create_file_dialog(webview.OPEN_DIALOG)